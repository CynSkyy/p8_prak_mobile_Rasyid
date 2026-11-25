import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  String _namaUser = '';

  ThemeMode get themeMode => _themeMode;
  bool get isDarkMode => _themeMode == ThemeMode.dark;
  String get namaUser => _namaUser;

  static const String _themeKey = 'Them_key';
  static const String _namaKey = 'Nama_key';

  ThemeProvider() {
    _loadPreferences();
  }

  void _loadPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final isDark = prefs.getBool(_themeKey) ?? false;
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;

    _namaUser = prefs.getString(_namaKey) ?? '';
    notifyListeners();
  }

  void toggleTheme(bool isOn) async {
    _themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.setBool(_themeKey, isOn);
  }

  void saveNama(String nama) async {
    _namaUser = nama;
    notifyListeners();

    final prefs = await SharedPreferences.getInstance();
    prefs.setString(_namaKey, nama);
  }
}