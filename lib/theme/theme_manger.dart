import 'package:flutter/material.dart';

class ThemeManger with ChangeNotifier {
  // ignore: prefer_final_fields
  ThemeMode _themeMode = ThemeMode.light;

  get themeMode => _themeMode;
  toggleTheme(bool isDark) {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}
