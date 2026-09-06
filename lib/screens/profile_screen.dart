import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../services/language_service.dart';
import '../services/theme_service.dart';
import 'auth/login_screen.dart';
import 'auth/register_screen.dart';
import 'settings_screen.dart';

class ProfileScreen extends StatelessWidget {
  final ThemeService themeService;
  final AuthService authService;
  final LanguageService languageService;

  const ProfileScreen({
    super.key,
    required this.themeService,
    required this.authService,
    required this.languageService,
  });

  String translate(String key) {
    return languageService.translate(key);
  }

  void _openLogin(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => LoginScreen(
          authService: authService,
          languageService: languageService,
        ),
      ),
    );
  }

  void _openRegister(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => RegisterScreen(
          authService: authService,
          languageService: languageService,
        ),
      ),
    );
  }

  void _showLoginRequired(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    showModalBottomSheet(
      context: context,
      backgroundColor: colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              25,
              25,
              25,
              20,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 45,
                  height: 5,
                  decoration: BoxDecoration(
                    color: colorScheme.onSurfaceVariant
                        .withOpacity(0.3),
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(height: 25),
                Container(
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color:
                    colorScheme.surfaceContainerHighest,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.person_outline,
                    size: 35,
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  translate('login_required'),
                  style: TextStyle(
                    color: colorScheme.onSurface,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  translate('login_or_register'),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: colorScheme.onSurfaceVariant,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 25),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: FilledButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _openLogin(context);
                    },
                    child: Text(
                      translate('login'),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      _openRegister(context);
                    },
                    child: Text(
                      translate('register'),
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        );
      },
    );
  }

  void _showEditProfile(BuildContext context) {
    final nameController = TextEditingController(
      text: authService.name ?? '',
    );

    final emailController = TextEditingController(
      text: authService.email ?? '',
    );

    bool isLoading = false;

    showDialog(
      context: context,
      builder: (dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text(
                translate('edit_profile'),
              ),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: nameController,
                    enabled: !isLoading,
                    decoration: InputDecoration(
                      labelText: translate('name'),
                      prefixIcon: const Icon(
                        Icons.person_outline,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: emailController,
                    enabled: !isLoading,
                    keyboardType:
                    TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: translate('email'),
                      prefixIcon: const Icon(
                        Icons.email_outlined,
                      ),
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: isLoading
                      ? null
                      : () {
                    Navigator.pop(dialogContext);
                  },
                  child: Text(
                    translate('cancel'),
                  ),
                ),
                FilledButton(
                  onPressed: isLoading
                      ? null
                      : () async {
                    final name =
                    nameController.text.trim();
                    final email =
                    emailController.text.trim();

                    if (name.isEmpty ||
                        email.isEmpty) {
                      return;
                    }

                    setDialogState(() {
                      isLoading = true;
                    });

                    final error =
                    await authService.updateProfile(
                      name: name,
                      email: email,
                    );

                    if (!context.mounted) return;

                    if (error != null) {
                      setDialogState(() {
                        isLoading = false;
                      });

                      ScaffoldMessenger.of(context)
                          .showSnackBar(
                        SnackBar(
                          content: Text(error),
                        ),
                      );

                      return;
                    }

                    Navigator.pop(dialogContext);

                    ScaffoldMessenger.of(context)
                        .showSnackBar(
                      SnackBar(
                        content: Text(
                          translate(
                            'profile_updated',
                          ),
                        ),
                      ),
                    );
                  },
                  child: isLoading
                      ? const SizedBox(
                    width: 20,
                    height: 20,
                    child:
                    CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  )
                      : Text(
                    translate('save'),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _logout(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        bool isLoading = false;

        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: Text(
                translate('logout'),
              ),
              content: Text(
                translate('logout_confirmation'),
              ),
              actions: [
                TextButton(
                  onPressed: isLoading
                      ? null
                      : () {
                    Navigator.pop(dialogContext);
                  },
                  child: Text(
                    translate('cancel'),
                  ),
                ),
                FilledButton(
                  onPressed: isLoading
                      ? null
                      : () async {
                    setDialogState(() {
                      isLoading = true;
                    });

                    await authService.logout();

                    if (!context.mounted) return;

                    Navigator.pop(dialogContext);

                    ScaffoldMessenger.of(context)
                        .showSnackBar(
                      SnackBar(
                        content: Text(
                          translate('logged_out'),
                        ),
                      ),
                    );
                  },
                  child: isLoading
                      ? const SizedBox(
                    width: 20,
                    height: 20,
                    child:
                    CircularProgressIndicator(
                      strokeWidth: 2,
                    ),
                  )
                      : Text(
                    translate('logout'),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _openSettings(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => SettingsScreen(
          themeService: themeService,
          languageService: languageService,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark = theme.brightness == Brightness.dark;
    final isLoggedIn = authService.isLoggedIn;

    if (!isLoggedIn) {
      return _buildGuestProfile(
        context,
        colorScheme,
        isDark,
      );
    }

    return _buildLoggedInProfile(
      context,
      colorScheme,
      isDark,
    );
  }

  Widget _buildGuestProfile(
      BuildContext context,
      ColorScheme colorScheme,
      bool isDark,
      ) {
    return Scaffold(
      backgroundColor:
      Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor:
        Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        title: Text(
          translate('profile'),
          style: TextStyle(
            color: colorScheme.onSurface,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment:
            MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 45,
                backgroundColor:
                isDark ? Colors.white : Colors.black,
                child: Icon(
                  Icons.person_outline,
                  size: 50,
                  color:
                  isDark ? Colors.black : Colors.white,
                ),
              ),
              const SizedBox(height: 25),
              Text(
                translate('welcome'),
                style: TextStyle(
                  color: colorScheme.onSurface,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                translate('login_or_register'),
                textAlign: TextAlign.center,
                style: TextStyle(
                  color:
                  colorScheme.onSurfaceVariant,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 30),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: FilledButton(
                  onPressed: () {
                    _openLogin(context);
                  },
                  child: Text(
                    translate('login'),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                height: 52,
                child: OutlinedButton(
                  onPressed: () {
                    _openRegister(context);
                  },
                  child: Text(
                    translate('register'),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLoggedInProfile(
      BuildContext context,
      ColorScheme colorScheme,
      bool isDark,
      ) {
    return Scaffold(
      backgroundColor:
      Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor:
        Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        title: Text(
          translate('profile'),
          style: TextStyle(
            color: colorScheme.onSurface,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const SizedBox(height: 15),
          CircleAvatar(
            radius: 45,
            backgroundColor:
            isDark ? Colors.white : Colors.black,
            child: Icon(
              Icons.person,
              size: 50,
              color:
              isDark ? Colors.black : Colors.white,
            ),
          ),
          const SizedBox(height: 15),
          Center(
            child: Text(
              authService.name ?? 'News Reader',
              style: TextStyle(
                color: colorScheme.onSurface,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Center(
            child: Text(
              authService.email ?? '',
              style: TextStyle(
                color:
                colorScheme.onSurfaceVariant,
                fontSize: 14,
              ),
            ),
          ),
          const SizedBox(height: 35),
          _ProfileOption(
            icon: Icons.person_outline,
            title: translate('edit_profile'),
            onTap: () {
              _showEditProfile(context);
            },
          ),
          _ProfileOption(
            icon: Icons.bookmark_outline,
            title: translate('saved_articles'),
            onTap: () {},
          ),
          _ProfileOption(
            icon: Icons.history,
            title: translate('reading_history'),
            onTap: () {},
          ),
          _ProfileOption(
            icon: Icons.notifications_none,
            title: translate(
              'notification_preferences',
            ),
            onTap: () {},
          ),
          _ProfileOption(
            icon: Icons.settings_outlined,
            title: translate('settings'),
            onTap: () {
              _openSettings(context);
            },
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 52,
            child: OutlinedButton.icon(
              onPressed: () {
                _logout(context);
              },
              icon: const Icon(
                Icons.logout,
              ),
              label: Text(
                translate('logout'),
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProfileOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _ProfileOption({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme =
        Theme.of(context).colorScheme;

    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color:
          colorScheme.surfaceContainerHighest,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          icon,
          color: colorScheme.onSurface,
        ),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: colorScheme.onSurface,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: Icon(
        Icons.arrow_forward_ios,
        size: 16,
        color: colorScheme.onSurfaceVariant,
      ),
      onTap: onTap,
    );
  }
}