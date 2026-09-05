import 'package:flutter/material.dart';

import 'screens/main_screen.dart';
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

  @override
  void initState() {
    super.initState();

    themeService.addListener(_themeChanged);
  }

  void _themeChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    themeService.removeListener(_themeChanged);
    themeService.dispose();
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

      home: MainScreen(
        themeService: themeService,
      ),
    );
  }
}