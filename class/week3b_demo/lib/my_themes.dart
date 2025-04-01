import 'package:flutter/material.dart';

ThemeData myLightTheme(BuildContext context) {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      appBarTheme: AppBarTheme(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontStyle: FontStyle.italic,
          fontSize: 20
        ),
      ),
      textTheme: TextTheme(
        bodyMedium: TextStyle(
          color: Colors.purple,
          fontSize: 15,
          fontFamily: "Times"
        ),
        displayLarge: TextStyle(
          color: Colors.blue,
          fontSize: 50,
          fontFamily: "Courier",
          fontWeight: FontWeight.bold,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey,
              foregroundColor: Colors.yellow,
              overlayColor: Colors.green,
              textStyle: TextStyle(
                fontFamily: "Courier",
                fontSize: 20,
                fontWeight: FontWeight.bold,
                shadows: [
                  Shadow(
                    color: Colors.black,
                    offset: Offset(1, 2),
                    blurRadius: 20
                  ),
                ]
              ),
            ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(),
      useMaterial3: true,
    );
  }