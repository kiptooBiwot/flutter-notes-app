import 'package:flutter/material.dart';
import 'package:notes_app/screens/home.dart';
import 'package:notes_app/screens/login.dart';
import 'package:notes_app/screens/notes.dart';
import 'package:notes_app/screens/register.dart';
import 'dart:developer' as devtools show log;

void main() async {
  // Initialize Firebase to the project
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const NotesApp());
}

class NotesApp extends StatelessWidget {
  const NotesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
      ),
      // home: const HomePage(),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomePage(),
        '/login': (context) => const LoginView(),
        '/register': (context) => const RegisterView(),
        '/notes': (context) => const NotesView(),
      },
    );
  }
}
