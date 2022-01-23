import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:notes_app/screens/home.dart';
import 'package:notes_app/screens/login.dart';
import 'package:notes_app/screens/register.dart';
import 'firebase_options.dart';

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
      home: const HomePage(),
    );
  }
}
