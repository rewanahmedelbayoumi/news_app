import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onDestinationSelected;

  const BottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onDestinationSelected,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return NavigationBar(
      selectedIndex: selectedIndex,
      onDestinationSelected: onDestinationSelected,

      backgroundColor: colorScheme.surface,

      indicatorColor: colorScheme.primaryContainer,

      destinations: [
        NavigationDestination(
          icon: Icon(
            Icons.home_outlined,
            color: colorScheme.onSurfaceVariant,
          ),
          selectedIcon: Icon(
            Icons.home,
            color: colorScheme.onPrimaryContainer,
          ),
          label: 'Home',
        ),
        NavigationDestination(
          icon: Icon(
            Icons.bookmark_outline,
            color: colorScheme.onSurfaceVariant,
          ),
          selectedIcon: Icon(
            Icons.bookmark,
            color: colorScheme.onPrimaryContainer,
          ),
          label: 'Saved',
        ),
        NavigationDestination(
          icon: Icon(
            Icons.person_outline,
            color: colorScheme.onSurfaceVariant,
          ),
          selectedIcon: Icon(
            Icons.person,
            color: colorScheme.onPrimaryContainer,
          ),
          label: 'Profile',
        ),
      ],
    );
  }
}