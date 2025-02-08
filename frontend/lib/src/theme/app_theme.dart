import 'package:flutter/material.dart';

class AppTheme {
  static final backgrouddark = const Color.fromARGB(255, 5, 15, 25);
  static final primarydark = Color.fromARGB(255, 52, 73, 94);
  static final secondarydark = const Color.fromARGB(255, 97, 106, 107);
  static final secondary1 = const Color.fromARGB(255, 214, 137, 16);
  static final secondary2 = const Color.fromARGB(255, 176, 58, 46);
  static final textdark = const Color.fromARGB(255, 121, 125, 127);

  static final ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme(
      surface: backgrouddark,
      onSurface: textdark,

      primary: backgrouddark,
      onPrimary: textdark,

      secondary: primarydark,
      onSecondary: textdark,

      error: secondary2,
      onError: secondary2,

      brightness: Brightness.dark,

    ),
    textTheme: TextTheme(
      headlineLarge: TextStyle(
        color: textdark,
        fontFamily: 'Courier New',
        fontSize: 24.0,
        fontWeight: FontWeight.normal,
      ),
      headlineMedium: TextStyle(
        color: textdark,
        fontFamily: 'Courier New',
        fontSize: 18.0,
        fontWeight: FontWeight.normal,
      ),
      headlineSmall: TextStyle(
        color: textdark,
        fontFamily: 'Courier New',
        fontSize: 14.0,
        fontWeight: FontWeight.normal,
      ),
      bodyLarge: TextStyle(
        color: textdark,
        fontSize: 12.0,
        fontFamily: 'Courier New',
      ),
      bodyMedium: TextStyle(
        color: textdark,
        fontSize: 10.0,
        fontFamily: 'Courier New',
      ),
      bodySmall: TextStyle(
        color: textdark,
        fontSize: 8.0,
        fontFamily: 'Courier New',
      ),
    ),
    appBarTheme: AppBarTheme(
      titleTextStyle: TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontFamily: 'Courier New',
      ),
      foregroundColor: const Color.fromARGB(255, 255, 255, 255),
      backgroundColor: const Color.fromARGB(255, 26, 25, 25),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: const Color.fromARGB(134, 255, 255, 255),
      elevation: 4,
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(
          const Color.fromARGB(255, 179, 179, 179),
        ),
        overlayColor: WidgetStateProperty.all(
          const Color.fromARGB(0, 12, 12, 12),
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          textStyle: WidgetStatePropertyAll(TextStyle(
          fontFamily: 'Courier New',
          fontSize: 15,
          fontWeight: FontWeight.bold,
         )),
      backgroundColor: WidgetStatePropertyAll(Color.fromARGB(255, 12, 12, 12)),
      foregroundColor: WidgetStatePropertyAll(Color.fromARGB(255, 179, 179, 179)),
      overlayColor: WidgetStatePropertyAll(Color.fromARGB(115, 179, 179, 179)),
      )
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(),
      focusedBorder: OutlineInputBorder(),
      // floatingLabelBehavior: FloatingLabelBehavior.always,

      labelStyle: TextStyle(
        color: textdark,
        fontSize: 12.0,
        fontFamily: 'Courier New',
        fontWeight: FontWeight.bold,
      ),
      hintStyle: TextStyle(
        color: secondarydark,
        fontSize: 10.0,
        fontFamily: 'Courier New',
        fontWeight: FontWeight.normal,
      ),

      // focusedBorder: OutlineInputBorder(
      //   borderSide: BorderSide(
      //     color: const Color.fromARGB(255, 255, 255, 255),
      //     width: 1.0,
      //   ),
      // ),
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: textdark,
    ),
  );
}
