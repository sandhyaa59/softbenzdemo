import 'package:flutter/material.dart';

class CustomTheme {
  static ThemeData lightTheme = ThemeData(
    primaryColor: Colors.teal,

    scaffoldBackgroundColor: Colors.white,
    textTheme:const  TextTheme(
      displayLarge: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.black),
      displayMedium: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
      bodyLarge: TextStyle(fontSize: 16, color: Colors.black87),
      bodyMedium: TextStyle(fontSize: 14, color: Colors.black54),
      labelLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
    ),
    buttonTheme:const ButtonThemeData(
      buttonColor: Colors.teal,
      textTheme: ButtonTextTheme.primary,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.teal,
      foregroundColor: Colors.white,
    ),
  );
}
