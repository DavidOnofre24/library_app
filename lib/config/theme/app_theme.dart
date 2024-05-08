import 'package:flutter/material.dart';

class AppTheme {
  ThemeData getTheme() => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.purple,
          accentColor: Colors.purpleAccent,
          brightness: Brightness.dark,
          backgroundColor: Colors.black.withOpacity(0.1),
        ),
      );
}
