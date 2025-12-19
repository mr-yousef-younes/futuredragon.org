import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ATheme {
  static const Color primary = Color(0xFFC9B5DC);
  static const Color primaryd = Color(0xFFC9B5DC);
  static const Color green = Color(0xFF4CAF50);
  static const Color accentFire = Color(0xFFFF5722);
  static const Color accentGold = Color(0xFFFFC107);
  static const Color ink = Color(0xFF0D0D0D);
  static const Color ash = Color(0xFF2C2C2C);
  static const Color background = Color(0xFFF9F9F9);
  static const Color phoenixStart = Color(0xFFFF512F);
  static const Color phoenixEnd = Color(0xFFDD2476);

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      primaryColor: primary,
      colorScheme: ColorScheme.fromSeed(seedColor: primary),
      scaffoldBackgroundColor: background,
      fontFamily: "Cairo",
      appBarTheme: const AppBarTheme(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        elevation: 3,
        titleTextStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: ink, fontSize: 16, height: 1.5),
        bodyMedium: TextStyle(color: ash, fontSize: 14, height: 1.4),
        titleLarge: TextStyle(
          color: ink,
          fontSize: 26,
          fontWeight: FontWeight.w700,
        ),
        titleMedium: TextStyle(
          color: ink,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(primary),
          foregroundColor: const WidgetStatePropertyAll(Colors.white),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
          elevation: const WidgetStatePropertyAll(5),
          shadowColor: WidgetStatePropertyAll(accentFire.withValues(alpha: 0.25)),
          overlayColor: WidgetStatePropertyAll(primary.withValues(alpha: 0.8)),
          padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          ),
          textStyle: const WidgetStatePropertyAll(
            TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStatePropertyAll(primary),
          overlayColor: WidgetStatePropertyAll(primary.withValues(alpha: 0.1)),
          textStyle: const WidgetStatePropertyAll(
            TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: accentFire,
        contentTextStyle: TextStyle(color: Colors.white),
        behavior: SnackBarBehavior.floating,
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 4,
        shadowColor: Colors.black.withValues(alpha: 0.1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      primaryColor: primary,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primary,
        brightness: Brightness.dark,
      ),
      scaffoldBackgroundColor: ink,
      fontFamily: "Cairo",
      appBarTheme: const AppBarTheme(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        elevation: 3,
        titleTextStyle: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      textTheme: const TextTheme(
        bodyLarge: TextStyle(color: Colors.white, fontSize: 16, height: 1.5),
        bodyMedium: TextStyle(color: Colors.white70, fontSize: 14, height: 1.4),
        titleLarge: TextStyle(
          color: Colors.white,
          fontSize: 26,
          fontWeight: FontWeight.w700,
        ),
        titleMedium: TextStyle(
          color: Colors.white70,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStatePropertyAll(primary),
          foregroundColor: const WidgetStatePropertyAll(Colors.white),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          ),
          elevation: const WidgetStatePropertyAll(5),
          shadowColor: WidgetStatePropertyAll(accentFire.withValues(alpha: 0.25)),
          overlayColor: WidgetStatePropertyAll(primary.withValues(alpha: 0.8)),
          padding: const WidgetStatePropertyAll(
            EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          ),
          textStyle: const WidgetStatePropertyAll(
            TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          foregroundColor: WidgetStatePropertyAll(accentGold),
          overlayColor: WidgetStatePropertyAll(accentFire.withValues(alpha: 0.1)),
          textStyle: const WidgetStatePropertyAll(
            TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
      snackBarTheme: const SnackBarThemeData(
        backgroundColor: accentFire,
        contentTextStyle: TextStyle(color: Colors.white),
        behavior: SnackBarBehavior.floating,
      ),
      cardTheme: CardThemeData(
        color: ash,
        elevation: 6,
        shadowColor: Colors.black.withValues(alpha: 0.2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    );
  }
}

class ThemeModeNotifier extends Notifier<ThemeMode> {
  static const _themeKey = 'appThemeMode';

  @override
  ThemeMode build() {
    _loadThemeMode();
    return ThemeMode.light;
  }

  Future<void> _loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final themeString = prefs.getString(_themeKey);
    if (themeString == 'light') {
      state = ThemeMode.light;
    } else if (themeString == 'dark') {
      state = ThemeMode.dark;
    } else {
      state = ThemeMode.system;
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    String themeString;
    switch (mode) {
      case ThemeMode.light:
        themeString = 'light';
        break;
      case ThemeMode.dark:
        themeString = 'dark';
        break;
      case ThemeMode.system:
        themeString = 'system';
        break;
    }
    await prefs.setString(_themeKey, themeString);
    state = mode;
  }
}

final themeModeProvider = NotifierProvider<ThemeModeNotifier, ThemeMode>(() {
  return ThemeModeNotifier();
});
