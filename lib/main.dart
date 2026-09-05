import 'package:flutter/material.dart';

import 'screens/main_screen.dart';
import 'services/auth_service.dart';
import 'services/theme_service.dart';

void main() {
  runApp(const NewsApp());
}

class NewsApp extends StatefulWidget {
  const NewsApp({super.key});

  @override
  State<NewsApp> createState() => _NewsAppState();
}

class _NewsAppState extends State<NewsApp> {
  final ThemeService themeService = ThemeService();
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();

    themeService.addListener(_appChanged);
    authService.addListener(_appChanged);
  }

  void _appChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    themeService.removeListener(_appChanged);
    authService.removeListener(_appChanged);

    themeService.dispose();
    authService.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News App',

      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        scaffoldBackgroundColor: Colors.white,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.black,
          brightness: Brightness.light,
        ),
      ),

      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF121212),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.white,
          brightness: Brightness.dark,
        ),
      ),

      themeMode: themeService.isDarkMode
          ? ThemeMode.dark
          : ThemeMode.light,

      // The Home screen is always accessible.
      // Login and Register are required only for protected features.
      home: MainScreen(
        themeService: themeService,
        authService: authService,
      ),
    );
  }
}