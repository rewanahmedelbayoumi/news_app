import 'package:flutter/material.dart';

import '../services/auth_service.dart';
import '../services/theme_service.dart';
import 'auth/login_screen.dart';
import 'auth/register_screen.dart';
import 'settings_screen.dart';

class ProfileScreen extends StatelessWidget {
  final ThemeService themeService;
  final AuthService authService;

  const ProfileScreen({
    super.key,
    required this.themeService,
    required this.authService,
  });

  void _openLogin(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => LoginScreen(
          authService: authService,
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
                  'Login Required',
                  style: TextStyle(
                    color: colorScheme.onSurface,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  'Login or create an account to access your profile.',
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
                    onPressed: () {
                      Navigator.pop(context);
                      _openRegister(context);
                    },
                    child: const Text(
                      'Register',
                      style: TextStyle(
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

    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            'Edit Profile',
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  prefixIcon: Icon(
                    Icons.person_outline,
                  ),
                ),
              ),

              const SizedBox(height: 15),

              TextField(
                controller: emailController,
                keyboardType:
                TextInputType.emailAddress,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(
                    Icons.email_outlined,
                  ),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text(
                'Cancel',
              ),
            ),
            FilledButton(
              onPressed: () {
                final name =
                nameController.text.trim();
                final email =
                emailController.text.trim();

                if (name.isEmpty || email.isEmpty) {
                  return;
                }

                authService.updateProfile(
                  name: name,
                  email: email,
                );

                Navigator.pop(dialogContext);

                ScaffoldMessenger.of(context)
                    .showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Profile updated successfully.',
                    ),
                  ),
                );
              },
              child: const Text(
                'Save',
              ),
            ),
          ],
        );
      },
    );
  }

  void _logout(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) {
        return AlertDialog(
          title: const Text(
            'Logout',
          ),
          content: const Text(
            'Are you sure you want to logout?',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(dialogContext);
              },
              child: const Text(
                'Cancel',
              ),
            ),
            FilledButton(
              onPressed: () {
                authService.logout();

                Navigator.pop(dialogContext);

                ScaffoldMessenger.of(context)
                    .showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Logged out successfully.',
                    ),
                  ),
                );
              },
              child: const Text(
                'Logout',
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final isDark =
        theme.brightness == Brightness.dark;

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
          'Profile',
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
                backgroundColor: isDark
                    ? Colors.white
                    : Colors.black,
                child: Icon(
                  Icons.person_outline,
                  size: 50,
                  color: isDark
                      ? Colors.black
                      : Colors.white,
                ),
              ),

              const SizedBox(height: 25),

              Text(
                'Welcome',
                style: TextStyle(
                  color: colorScheme.onSurface,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'Login or create an account to access your profile.',
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
                  onPressed: () {
                    _openRegister(context);
                  },
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
          'Profile',
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
              color: isDark
                  ? Colors.black
                  : Colors.white,
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
                color: colorScheme.onSurfaceVariant,
                fontSize: 14,
              ),
            ),
          ),

          const SizedBox(height: 35),

          _ProfileOption(
            icon: Icons.person_outline,
            title: 'Edit Profile',
            onTap: () {
              _showEditProfile(context);
            },
          ),

          _ProfileOption(
            icon: Icons.bookmark_outline,
            title: 'Saved Articles',
            onTap: () {},
          ),

          _ProfileOption(
            icon: Icons.history,
            title: 'Reading History',
            onTap: () {},
          ),

          _ProfileOption(
            icon: Icons.notifications_none,
            title: 'Notification Preferences',
            onTap: () {},
          ),

          _ProfileOption(
            icon: Icons.settings_outlined,
            title: 'Settings',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => SettingsScreen(
                    themeService: themeService,
                  ),
                ),
              );
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
              label: const Text(
                'Logout',
                style: TextStyle(
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
          color: colorScheme
              .surfaceContainerHighest,
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