import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'screens/main_screen.dart';
import 'services/auth_service.dart';
import 'services/language_service.dart';
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
  final LanguageService languageService = LanguageService();

  @override
  void initState() {
    super.initState();

    themeService.addListener(_appChanged);
    authService.addListener(_appChanged);
    languageService.addListener(_appChanged);
  }

  void _appChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    themeService.removeListener(_appChanged);
    authService.removeListener(_appChanged);
    languageService.removeListener(_appChanged);

    themeService.dispose();
    authService.dispose();
    languageService.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'News App',

      locale: Locale(
        languageService.languageCode,
      ),

      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],

      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
        Locale('es'),
        Locale('fr'),
        Locale('de'),
        Locale('ja'),
        Locale('zh'),
      ],

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
        scaffoldBackgroundColor:
        const Color(0xFF121212),
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
        authService: authService,
        languageService: languageService,
      ),
    );
  }
}