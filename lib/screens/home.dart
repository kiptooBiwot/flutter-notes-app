import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/firebase_options.dart';
import 'package:notes_app/screens/login.dart';
import 'package:notes_app/screens/verify_email.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Notes App'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              // Check if user's email is verified
              // final user = FirebaseAuth.instance.currentUser;
              // final emailVerified = user?.emailVerified ?? false;

              // print(user);
              // Can also be written as
              // if(user?.emailVerified ?? false) {}

              // if (emailVerified) {
              //   print('Email is verified!');
              //   return const Text('Done!');
              // } else {
              //   return const VerifyEmailView();
              // }

              return const LoginView();

            // break;
            default:
              return const Text('Loading....');
          }
        },
      ),
    );
  }
}
