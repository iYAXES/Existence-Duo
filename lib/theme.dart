import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    background: Colors.white,
    onPrimary: Colors.black,
    onSecondary: Color.fromARGB(255, 250, 246, 246),
  ),
);
ThemeData darkMode = ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.dark(
        background: Colors.black,
        onPrimary: Colors.white,
        onSecondary: Colors.grey.shade900));

class MyColors {
  static const primary = Colors.black;
}
