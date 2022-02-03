import 'package:flutter/material.dart';
import 'package:notes_app/screens/login.dart';
import 'package:notes_app/screens/notes/notes_view.dart';
import 'package:notes_app/screens/verify_email.dart';
import 'package:notes_app/services/auth/auth_service.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: AuthService.firebase().initialize(),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            // Check if user's email is verified
            final user = AuthService.firebase().currentUser;
            final isEmailVerified = user?.isEmailVerified ?? false;

            if (user != null) {
              if (user.isEmailVerified) {
                return const NotesView();
              } else {
                return const VerifyEmailView();
              }
            } else {
              return const LoginView();
            }
          // return const Text('Done');
          // break;
          default:
            return const CircularProgressIndicator();
        }
      },
    );
  }
}
