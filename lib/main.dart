import 'package:flutter/material.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/note_form_screen.dart';
import 'models/note.dart';

void main() {
  runApp(const CatatanKuProApp());
}

class CatatanKuProApp extends StatelessWidget {
  const CatatanKuProApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CatatanKu Pro',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue[700],
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blue[700],
          foregroundColor: Colors.white,
          elevation: 2,
          centerTitle: true,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue[700],
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        cardTheme: const CardThemeData(
          elevation: 2,
        ),
        floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: Colors.blue[700],
          foregroundColor: Colors.white,
        ),
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/note-form': (context) => const NoteFormScreen(),
      },
      onGenerateRoute: (settings) {
        // Handle dynamic routes with parameters
        if (settings.name == '/note-form-edit') {
          final Note note = settings.arguments as Note;
          return MaterialPageRoute(
            builder: (context) => NoteFormScreen(note: note),
          );
        }
        return null;
      },
    );
  }
}
