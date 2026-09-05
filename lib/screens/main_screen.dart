import 'package:flutter/material.dart';

import '../services/auth_service.dart';
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

  const MainScreen({
    super.key,
    required this.themeService,
    required this.authService,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  void _openLogin() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => LoginScreen(
          authService: widget.authService,
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
                  'Login or create an account to continue.',
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
                    child: const Text(
                      'Login',
                      style: TextStyle(
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
                    child: const Text(
                      'Register',
                      style: TextStyle(
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
          ),

          _buildProtectedScreen(
            title: 'Your Saved News',
            icon: Icons.bookmark_outline,
            child: SavedScreen(
              key: ValueKey(
                widget.authService.isLoggedIn,
              ),
              authService: widget.authService,
            ),
          ),

          _buildProtectedScreen(
            title: 'Your Profile',
            icon: Icons.person_outline,
            child: ProfileScreen(
              themeService: widget.themeService,
              authService: widget.authService,
            ),
          ),
        ],
      ),

      bottomNavigationBar: BottomNavBar(
        selectedIndex: selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            selectedIndex = index;
          });
        },
      ),
    );
  }
}