import 'package:flutter/material.dart';

class AppTheme {
  static final background = const Color.fromARGB(255, 17, 31, 31);

  static final primary = Color.fromARGB(255, 17, 31, 31);

  static final secondary = const Color.fromARGB(243, 1, 13, 13);

  static final textdark = const Color.fromARGB(255, 121, 125, 127);


  static final ThemeData darkTheme = ThemeData(
    colorScheme: ColorScheme(
      surface: background,
      onSurface: textdark,

      outline: textdark,

      primary: primary,
      onPrimary: textdark,

      secondary: textdark,
      onSecondary: secondary,

      error: const  Color.fromARGB(255, 255, 0, 0),
      onError: textdark,

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
        color: textdark,
        fontSize: 20,
        fontFamily: 'Courier New',
      ),
      foregroundColor: textdark,
      backgroundColor: secondary,
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: const Color.fromARGB(134, 255, 255, 255),
      elevation: 4,
    ),

    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(
          textdark
        ),
        textStyle: WidgetStateProperty.all(
          TextStyle(
            fontFamily: 'Courier New',
            fontSize: 12,
            fontWeight: FontWeight.normal,
          ),
        ),

      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(

        textStyle: WidgetStatePropertyAll(
          TextStyle(
            fontFamily: 'Courier New',
            fontSize: 14,
            fontWeight: FontWeight.normal,
          ),
        ),
        side: WidgetStateProperty.all(
            BorderSide(
              color: textdark,
              width: 1,
            ),
        ),
        shape: WidgetStatePropertyAll(
          ContinuousRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        backgroundColor: WidgetStatePropertyAll(primary),
        foregroundColor: WidgetStatePropertyAll(textdark),
        overlayColor: WidgetStatePropertyAll(secondary),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: textdark,
          width: 1,
        )
      ),
      // floatingLabelBehavior: FloatingLabelBehavior.always,
      prefixIconColor: textdark,
      labelStyle: TextStyle(
        color: textdark,
        fontSize: 12.0,
        fontFamily: 'Courier New',
        fontWeight: FontWeight.bold,
      ),

      hintStyle: TextStyle(
        color: textdark,
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
      color: secondary,
      linearTrackColor: textdark,
    ),
  );
}
