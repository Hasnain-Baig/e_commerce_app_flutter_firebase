import 'package:e_commerce_app_flutter_firebase/controllers/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

CustomTheme currentTheme = CustomTheme();

ThemeController _themeController = Get.put(ThemeController());

class CustomTheme with ChangeNotifier {
  static bool _isDark = false;
  ThemeMode get currentMode =>
      _themeController.isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    _isDark = _themeController.isDarkTheme;
    notifyListeners();
  }

  static get lightTheme {
    return ThemeData(
      colorScheme: ColorScheme(
        primary: Colors.orange.shade800,
        onPrimary: Colors.white,
        secondary: Colors.white,
        onSecondary: Colors.black87,
        primaryVariant: Colors.orange.shade800,
        secondaryVariant: Colors.black12,
        background: Colors.white,
        onBackground: Colors.white,
        surface: Color(0xFFA5D6A7),
        onSurface: Colors.grey,
        error: Colors.red,
        onError: Colors.white,
        brightness: Brightness.light,
      ),
    );
  }

  static get darkTheme {
    return ThemeData(
      colorScheme: ColorScheme(
        primary: Colors.orange.shade900,
        onPrimary: Colors.white,
        secondary: Colors.black87,
        onSecondary: Colors.white,
        primaryVariant: Colors.white,
        secondaryVariant: Colors.black87,
        background: Colors.orange.shade900,
        onBackground: Colors.white,
        surface: Colors.green,
        onSurface: Colors.white,
        error: Colors.red,
        onError: Colors.white,
        brightness: Brightness.dark,
      ),
    );
  }
}
