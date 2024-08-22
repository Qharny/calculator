import 'package:flutter/material.dart';

final lightTheme = ThemeData(
  primarySwatch: Colors.blue,
  brightness: Brightness.light,
  buttonTheme: const ButtonThemeData(
    buttonColor: Colors.blue,
    textTheme: ButtonTextTheme.primary,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: Colors.blue,
      textStyle: const TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
  ),
  textTheme: const TextTheme(
    displayLarge: TextStyle(
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
      color: Colors.blue,
    ),
    bodyLarge: TextStyle(
      fontSize: 18.0,
      color: Colors.black87,
    ),
  ),
);

final darkTheme = ThemeData(
  primarySwatch: Colors.grey,
  brightness: Brightness.dark,
  buttonTheme: ButtonThemeData(
    buttonColor: Colors.grey[800],
    textTheme: ButtonTextTheme.primary,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: Colors.grey[800],
      textStyle: const TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.bold,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
    ),
  ),
  textTheme: TextTheme(
    displayLarge: TextStyle(
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
      color: Colors.grey[400],
    ),
    bodyLarge: const TextStyle(
      fontSize: 18.0,
      color: Colors.white70,
    ),
  ),
);
