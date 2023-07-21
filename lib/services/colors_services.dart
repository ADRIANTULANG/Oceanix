import 'package:flutter/material.dart';

class ColorServices {
  static Color white = Color(0xFFFBFAF9);
  static Color cyan = Color.fromARGB(255, 1, 83, 83);
  static Color black = Colors.black;
  static const int _primaryValue = 0xFF184242;
  static MaterialColor mainColor = MaterialColor(
    _primaryValue,
    <int, Color>{
      50: Color(0xFF184242),
      100: Color(0xFF184242),
      200: Color(0xFF184242),
      300: Color(0xFF184242),
      400: Color(0xFF184242),
      500: Color(0xFF184242),
      600: Color(0xFF184242),
      700: Color(0xFF184242),
      800: Color(0xFF184242),
      900: Color(0xFF184242),
    },
  );
}
