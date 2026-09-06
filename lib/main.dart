import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'firebase_options.dart';
import 'screens/main_screen.dart';
import 'screens/splash_screen.dart';
import 'services/auth_service.dart';
import 'services/language_service.dart';
import 'services/theme_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final AuthService authService = AuthService();

  await authService.initializeSession();

  runApp(
    NewsApp(
      authService: authService,
    ),
  );
}

class NewsApp extends StatefulWidget {
  final AuthService authService;

  const NewsApp({
    super.key,
    required this.authService,
  });

  @override
  State<NewsApp> createState() => _NewsAppState();
}

class _NewsAppState extends State<NewsApp> {
  late final ThemeService themeService;
  late final LanguageService languageService;

  @override
  void initState() {
    super.initState();

    themeService = ThemeService();
    languageService = LanguageService();

    themeService.addListener(_appChanged);
    widget.authService.addListener(_appChanged);
    languageService.addListener(_appChanged);
  }

  void _appChanged() {
    if (!mounted) return;

    setState(() {});
  }

  @override
  void dispose() {
    themeService.removeListener(_appChanged);
    widget.authService.removeListener(_appChanged);
    languageService.removeListener(_appChanged);

    themeService.dispose();
    widget.authService.dispose();
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
        scaffoldBackgroundColor: const Color(0xFF121212),
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.white,
          brightness: Brightness.dark,
        ),
      ),
      themeMode: themeService.isDarkMode
          ? ThemeMode.dark
          : ThemeMode.light,
      home: SplashScreen(
        themeService: themeService,
        authService: widget.authService,
        languageService: languageService,
      ),
    );
  }
}