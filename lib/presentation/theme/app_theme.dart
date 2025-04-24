import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get darkTheme => ThemeData(
        brightness: Brightness.dark,
        scaffoldBackgroundColor: const Color(0xFF1F1F2E),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF2C2C3C),
          elevation: 0,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        primaryColor: Colors.deepPurple,
        colorScheme: const ColorScheme.dark(
          primary: Colors.deepPurple,
          secondary: Colors.purpleAccent,
          surface: Color(0xFF2A2A3D),
        ),
        sliderTheme: SliderThemeData(
          activeTrackColor: Colors.purpleAccent,
          thumbColor: Colors.purpleAccent,
          inactiveTrackColor: Colors.white24,
          overlayColor: Colors.purple.withOpacity(0.2),
          trackHeight: 2.0,
        ),
        cardTheme: CardTheme(
          color: const Color(0xFF2C2C3C),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 4,
          margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        ),
      );
}
