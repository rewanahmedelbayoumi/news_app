import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeService extends ChangeNotifier {
  static const String _darkModeKey = 'dark_mode';

  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  ThemeService() {
    _loadTheme();
  }

  Future<void> _loadTheme() async {
    final preferences =
    await SharedPreferences.getInstance();

    _isDarkMode =
        preferences.getBool(_darkModeKey) ?? false;

    notifyListeners();
  }

  Future<void> toggleTheme(bool value) async {
    _isDarkMode = value;

    notifyListeners();

    final preferences =
    await SharedPreferences.getInstance();

    await preferences.setBool(
      _darkModeKey,
      value,
    );
  }
}