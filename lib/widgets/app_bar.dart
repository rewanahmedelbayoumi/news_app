import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final VoidCallback onMenuPressed;
  final VoidCallback onSearchPressed;

  const AppBarWidget({
    super.key,
    required this.onMenuPressed,
    required this.onSearchPressed,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return AppBar(
      backgroundColor: theme.scaffoldBackgroundColor,
      elevation: 0,
      surfaceTintColor: Colors.transparent,

      leading: IconButton(
        onPressed: onMenuPressed,
        icon: Icon(
          Icons.menu,
          color: colorScheme.onSurface,
        ),
      ),

      title: Text(
        'News',
        style: TextStyle(
          color: colorScheme.onSurface,
          fontSize: 25,
          fontWeight: FontWeight.bold,
        ),
      ),

      centerTitle: true,

      actions: [
        IconButton(
          onPressed: onSearchPressed,
          icon: Icon(
            Icons.search,
            color: colorScheme.onSurface,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(
    kToolbarHeight,
  );
}