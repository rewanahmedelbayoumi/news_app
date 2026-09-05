import 'package:flutter/material.dart';

import '../services/theme_service.dart';
import '../widgets/bottom_nav_bar.dart';
import 'home_screen.dart';
import 'profile_screen.dart';
import 'saved_screen.dart';

class MainScreen extends StatefulWidget {
  final ThemeService themeService;

  const MainScreen({
    super.key,
    required this.themeService,
  });

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: [
          const HomeScreen(),

          SavedScreen(
            key: ValueKey(selectedIndex == 1),
          ),

          ProfileScreen(
            themeService: widget.themeService,
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