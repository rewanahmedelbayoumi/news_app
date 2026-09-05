import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../services/language_service.dart';
import '../services/theme_service.dart';
import '../widgets/bottom_nav_bar.dart';
import 'auth/login_screen.dart';
import 'auth/register_screen.dart';
import 'home_screen.dart';
import 'profile_screen.dart';
import 'saved_screen.dart';

class MainScreen extends StatefulWidget {
  final ThemeService themeService;
  final AuthService authService;
  final LanguageService languageService;

  const MainScreen({
    super.key,
    required this.themeService,
    required this.authService,
    required this.languageService,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  String translate(String key) {
    return widget.languageService.translate(key);
  }

  void _openLogin() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => LoginScreen(
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

  Widget _buildProtectedScreen({
    required Widget child,
    required String title,
    required IconData icon,
  }) {
    if (widget.authService.isLoggedIn) {
      return child;
    }

    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor:
      Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(30),
            child: Column(
              mainAxisAlignment:
              MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color:
                    colorScheme.surfaceContainerHighest,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    size: 55,
                    color: colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 25),
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: colorScheme.onSurface,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
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
                    onPressed: _openLogin,
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
                    onPressed: _openRegister,
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
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: [
          HomeScreen(
            authService: widget.authService,
            themeService: widget.themeService,
            languageService: widget.languageService,
          ),
          _buildProtectedScreen(
            title: translate('saved_articles'),
            icon: Icons.bookmark_outline,
            child: SavedScreen(
              key: ValueKey(
                widget.authService.isLoggedIn,
              ),
              authService: widget.authService,
              languageService: widget.languageService,
            ),
          ),
          _buildProtectedScreen(
            title: translate('profile'),
            icon: Icons.person_outline,
            child: ProfileScreen(
              themeService: widget.themeService,
              authService: widget.authService,
              languageService: widget.languageService,
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavBar(
        selectedIndex: selectedIndex,
        languageService: widget.languageService,
        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }
}