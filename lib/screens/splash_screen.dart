import 'dart:async';

import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../services/language_service.dart';
import '../services/theme_service.dart';
import 'main_screen.dart';

class SplashScreen extends StatefulWidget {
  final ThemeService themeService;
  final AuthService authService;
  final LanguageService languageService;

  const SplashScreen({
    super.key,
    required this.themeService,
    required this.authService,
    required this.languageService,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeIn,
    );

    _scaleAnimation = Tween<double>(
      begin: 0.85,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutBack,
      ),
    );

    _animationController.forward();

    Timer(
      const Duration(milliseconds: 2200),
      _openMainScreen,
    );
  }

  void _openMainScreen() {
    if (!mounted) return;

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (_) => MainScreen(
          themeService: widget.themeService,
          authService: widget.authService,
          languageService: widget.languageService,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: ScaleTransition(
            scale: _scaleAnimation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 92,
                  height: 92,
                  decoration: BoxDecoration(
                    color: colorScheme.onSurface,
                    borderRadius: BorderRadius.circular(28),
                  ),
                  child: Icon(
                    Icons.newspaper_rounded,
                    size: 48,
                    color: colorScheme.surface,
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'NEWS',
                  style: TextStyle(
                    color: colorScheme.onSurface,
                    fontSize: 30,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 5,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Stay informed. Stay ahead.',
                  style: TextStyle(
                    color: colorScheme.onSurfaceVariant,
                    fontSize: 13,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}