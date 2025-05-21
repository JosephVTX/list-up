// lib/screens/login_screen.dart
import 'package:flutter/material.dart';
import 'package:myapp/screens/home_screen.dart'; // Import the home screen
import 'package:myapp/screens/registration_screen.dart'; // Import registration screen

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Optional: App bar for back navigation in a real app, but not needed for the entry point
      // appBar: AppBar(title: Text('Iniciar Sesión')),
      body: Center(
        // Center the content
        child: SingleChildScrollView(
          // Allow scrolling if the content overflows
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center vertically
            crossAxisAlignment:
                CrossAxisAlignment.stretch, // Stretch horizontally
            children: [
              // Placeholder for the app logo
              Image.asset(
                'assets/listup_logo.png',
                height: 200,
                width: 200,
              ), // Assuming you have a logo asset
              const SizedBox(height: 30.0),
              const Text(
                'Iniciar Sesión',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30.0),
              // Username/Email input field
              TextField(
                decoration: InputDecoration(
                  labelText: 'Usuario o Email',
                  prefixIcon: const Icon(Icons.person_outline),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(
                        255,
                        210,
                        123,
                        76,
                      ), // Color del borde inicial
                      width: 2.0,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16.0),
              // Password input field
              TextField(
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  prefixIcon: const Icon(Icons.lock_outline),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(
                        255,
                        210,
                        123,
                        76,
                      ), // Color del borde inicial
                      width: 2.0,
                    ),
                  ),
                ),
                obscureText: true, // Oculta la contraseña
              ),

              const SizedBox(height: 24.0),
              // Login Button
              ElevatedButton(
                onPressed: () {
                  // Simulated Login: Navigate to the HomeScreen
                  Navigator.pushReplacement(
                    // Replace the current screen
                    context,
                    MaterialPageRoute(builder: (context) => const HomeScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                child: const Text(
                  'Iniciar Sesión',
                  style: TextStyle(fontSize: 18.0),
                ),
              ),
              const SizedBox(height: 16.0),
              // Option to navigate to Registration
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RegistrationScreen(),
                    ),
                  );
                },
                child: const Text('¿No tienes cuenta? Regístrate'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
