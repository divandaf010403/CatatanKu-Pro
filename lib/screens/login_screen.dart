import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // App Logo/Icon
              Icon(
                Icons.note_alt,
                size: 100,
                color: Colors.blue[700],
              ),
              const SizedBox(height: 24),
              
              // App Title
              Text(
                'CatatanKu Pro',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue[900],
                ),
              ),
              const SizedBox(height: 8),
              
              Text(
                'Aplikasi Catatan Pribadi',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 48),
              
              // Username Field
              TextField(
                decoration: InputDecoration(
                  labelText: 'Username',
                  hintText: 'Masukkan username',
                  prefixIcon: const Icon(Icons.person),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              
              // Password Field
              TextField(
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Masukkan password',
                  prefixIcon: const Icon(Icons.lock),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
              const SizedBox(height: 32),
              
              // Login Button
              ElevatedButton(
                onPressed: () {
                  // Navigate to Home Screen using pushReplacement
                  Navigator.pushReplacementNamed(context, '/home');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[700],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Masuk',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              
              // Register Link
              TextButton(
                onPressed: () {
                  // Show snackbar for demo
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Fitur registrasi belum tersedia'),
                      backgroundColor: Colors.grey,
                    ),
                  );
                },
                child: Text(
                  'Belum punya akun? Daftar di sini',
                  style: TextStyle(
                    color: Colors.blue[700],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}