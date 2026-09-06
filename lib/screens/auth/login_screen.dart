import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/auth_service.dart';
import '../../services/language_service.dart';
import 'forgot_password_screen.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  final AuthService authService;
  final LanguageService? languageService;

  const LoginScreen({
    super.key,
    required this.authService,
    this.languageService,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static const String _rememberMeKey = 'remember_me';
  static const String _savedEmailKey = 'saved_login_email';

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool obscurePassword = true;
  bool rememberMe = false;
  bool isLoading = false;

  String translate(String key) {
    return widget.languageService?.translate(key) ?? key;
  }

  @override
  void initState() {
    super.initState();
    _loadRememberMe();
  }

  Future<void> _loadRememberMe() async {
    final preferences = await SharedPreferences.getInstance();

    final savedRememberMe =
        preferences.getBool(_rememberMeKey) ?? false;

    final savedEmail =
        preferences.getString(_savedEmailKey) ?? '';

    if (!mounted) return;

    setState(() {
      rememberMe = savedRememberMe;

      if (savedRememberMe && savedEmail.isNotEmpty) {
        emailController.text = savedEmail;
      }
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _saveRememberMe(String email) async {
    final preferences = await SharedPreferences.getInstance();

    await preferences.setBool(
      _rememberMeKey,
      rememberMe,
    );

    if (rememberMe) {
      await preferences.setString(
        _savedEmailKey,
        email,
      );
    } else {
      await preferences.remove(_savedEmailKey);
    }
  }

  Future<void> _login() async {
    if (isLoading) return;

    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showMessage(
        translate('enter_email_password'),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    final error = await widget.authService.login(
      email: email,
      password: password,
      rememberMe: rememberMe,
    );

    if (!mounted) return;

    if (error != null) {
      setState(() {
        isLoading = false;
      });

      _showMessage(error);
      return;
    }

    await _saveRememberMe(email);

    if (!mounted) return;

    setState(() {
      isLoading = false;
    });

    Navigator.pop(context);
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _openForgotPassword() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ForgotPasswordScreen(
          authService: widget.authService,
          languageService: widget.languageService,
        ),
      ),
    );
  }

  void _openRegister() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => RegisterScreen(
          authService: widget.authService,
          languageService: widget.languageService,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 25,
            vertical: 40,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              Center(
                child: Container(
                  width: 75,
                  height: 75,
                  decoration: BoxDecoration(
                    color: colorScheme.onSurface,
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: Icon(
                    Icons.newspaper_rounded,
                    color: colorScheme.surface,
                    size: 40,
                  ),
                ),
              ),
              const SizedBox(height: 35),
              Center(
                child: Text(
                  translate('welcome_back'),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: colorScheme.onSurface,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  translate('login_to_save_read'),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: colorScheme.onSurfaceVariant,
                    fontSize: 14,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Text(
                translate('email'),
                style: TextStyle(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                enabled: !isLoading,
                decoration: InputDecoration(
                  hintText: translate('enter_email'),
                  prefixIcon: const Icon(
                    Icons.email_outlined,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                translate('password'),
                style: TextStyle(
                  color: colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: passwordController,
                obscureText: obscurePassword,
                enabled: !isLoading,
                decoration: InputDecoration(
                  hintText: translate('enter_password'),
                  prefixIcon: const Icon(
                    Icons.lock_outline,
                  ),
                  suffixIcon: IconButton(
                    onPressed: isLoading
                        ? null
                        : () {
                      setState(() {
                        obscurePassword =
                        !obscurePassword;
                      });
                    },
                    icon: Icon(
                      obscurePassword
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Checkbox(
                    value: rememberMe,
                    onChanged: isLoading
                        ? null
                        : (value) {
                      setState(() {
                        rememberMe = value ?? false;
                      });
                    },
                  ),
                  Text(
                    translate('remember_me'),
                    style: TextStyle(
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed:
                    isLoading ? null : _openForgotPassword,
                    child: Text(
                      translate('forgot_password'),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 55,
                child: FilledButton(
                  onPressed: isLoading ? null : _login,
                  child: isLoading
                      ? SizedBox(
                    width: 22,
                    height: 22,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: colorScheme.onPrimary,
                    ),
                  )
                      : Text(
                    translate('login'),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 25),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      translate('dont_have_account'),
                      style: TextStyle(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed:
                    isLoading ? null : _openRegister,
                    child: Text(
                      translate('register'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}