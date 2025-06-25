import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  //appBarTheme: AppBarTheme(backgroundColor: Colors.white, elevation: 0),
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    surfaceTint: Colors.transparent,
    surface: Colors.blueGrey.shade200,
    onPrimary: Colors.black,
    onSecondary: Color.fromARGB(255, 250, 246, 246),
    // secondary: Colors.white,
  ),
);
ThemeData darkMode = ThemeData(
  //appBarTheme: AppBarTheme(backgroundColor: Colors.black, elevation: 0),
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    surfaceTint: Colors.transparent,
    surface: Colors.blueGrey.shade800,
    onPrimary: Colors.white,
    onSecondary: Colors.grey.shade900,
    // secondary: Colors.black
  ),
);

class MyColors {
  static const primary = Colors.black;
}
