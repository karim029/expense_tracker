import 'package:flutter/material.dart';
import 'package:expense_tracker/widgets/expenses.dart';

// Define custom color schemes for light and dark themes
var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 96, 59, 181),
);

var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 5, 99, 125),
);

void main() {
  // Main entry point of the application
  runApp(
    MaterialApp(
      // Define dark theme settings
      darkTheme: ThemeData.dark().copyWith(
          colorScheme: kDarkColorScheme, // Apply custom dark color scheme
          cardTheme: const CardTheme().copyWith(
            color: kDarkColorScheme.secondaryContainer,
            elevation: 3,
            margin: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: kDarkColorScheme.primaryContainer,
              foregroundColor: kDarkColorScheme.onPrimaryContainer,
            ),
          )),
      // Define light theme settings
      theme: ThemeData().copyWith(
        colorScheme: kColorScheme, // Apply custom light color scheme
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.primaryContainer,
          elevation: 3,
        ),
        cardTheme: const CardTheme().copyWith(
          color: kColorScheme.secondaryContainer,
          elevation: 3,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.primaryContainer,
          ),
        ),
        textTheme: ThemeData().textTheme.copyWith(
              titleLarge: TextStyle(
                fontWeight: FontWeight.bold,
                color: kColorScheme.onSecondaryContainer,
                fontSize: 16,
              ),
            ),
      ),
      // Set theme mode to system default (light or dark based on system settings)
      themeMode: ThemeMode.system,
      // Set the home widget to be displayed first (Expenses widget in this case)
      home: const Expenses(),
    ),
  );
}
