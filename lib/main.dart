import 'package:flutter/material.dart';
import 'package:notes_app/constants/routes.dart';
import 'package:notes_app/screens/home.dart';
import 'package:notes_app/screens/login.dart';
import 'package:notes_app/screens/notes.dart';
import 'package:notes_app/screens/register.dart';
import 'package:notes_app/screens/verify_email.dart';

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
      initialRoute: homeRoute,
      routes: {
        homeRoute: (context) => const HomePage(),
        loginRoute: (context) => const LoginView(),
        registerRoute: (context) => const RegisterView(),
        notesRoute: (context) => const NotesView(),
        verifyEmailRoute: (context) => const VerifyEmailView(),
      },
    );
  }
}
