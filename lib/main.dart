// lib/main.dart
import 'package:flutter/material.dart';
import 'package:myapp/screens/login_screen.dart'; // Import the login screen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ListUp App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark, // Set the overall brightness to dark
        // primaryColor: Colors.blueGrey[900], // You could set a primary color
        // accentColor: Colors.blueAccent, // You could set an accent color (deprecated in newer Flutter)

        // Customize specific colors for a dark theme
        scaffoldBackgroundColor: Colors.black, // Make the main background black
        cardColor: Colors.grey[900], // Dark grey for card backgrounds
        canvasColor:
            Colors.black, // Background color for dialogs, drawers, etc.
        // Define the color scheme for dark mode
        colorScheme: const ColorScheme.dark(
          primary: Colors.blueAccent, // Primary color for dark mode
          onPrimary: Colors.white,
          secondary: Colors.cyanAccent, // Accent color for dark mode
          onSecondary: Colors.black,
          surface: Colors.grey, // Background color for cards, sheets, etc.
          onSurface: Colors.white,
          error: Colors.redAccent,
          onError: Colors.black,
          brightness: Brightness.dark,
        ),

        // If you used primarySwatch before, consider using colorScheme instead
        // primarySwatch: Colors.blue, // This will be overridden by colorScheme.dark
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const LoginScreen(),
    );
  }
}
