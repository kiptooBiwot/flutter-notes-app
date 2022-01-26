import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notes_app/constants/routes.dart';
import 'package:notes_app/screens/register.dart';
import 'dart:developer' as devtools show log;

import 'package:notes_app/utilities/show_error_dialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();

    super.dispose();
  }

  void _loginUser() async {
    final email = _email.text;
    final password = _password.text;

    try {
      UserCredential _userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Check if email is verified
      final user = FirebaseAuth.instance.currentUser;

      if (user?.emailVerified ?? false) {
        Navigator.of(context).pushNamedAndRemoveUntil(
          notesRoute,
          (route) => false,
        );
      } else {
        Navigator.of(context)
            .pushNamedAndRemoveUntil(verifyEmailRoute, (route) => false);
      }
      // devtools.log(_userCredential.toString());

      // print(_userCredential);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        // devtools.log('No user found for that email.');
        await showErrorDialog(
            context, 'User not found. Do you want to register a new account?');
      } else if (e.code == 'wrong-password') {
        // devtools.log('Wrong password provided for that user.');
        await showErrorDialog(
            context, 'Invalid email and/or password. Try again.');
      } else if (e.code == 'invalid-email') {
        // devtools.log('Invalid email entered');
        await showErrorDialog(context, 'A valid email is required');
      } else {
        await showErrorDialog(
          context,
          'Error ${e.code}',
        );
      }
    } catch (e) {
      await showErrorDialog(
        context,
        'Error: ${e.toString()}',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                TextField(
                  controller: _email,
                  enableSuggestions: false,
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter your email',
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                TextField(
                  controller: _password,
                  autocorrect: false,
                  obscureText: true,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Enter your password',
                  ),
                ),
                const SizedBox(
                  height: 10.0,
                ),
                TextButton(
                  onPressed: _loginUser,
                  child: const Text('Log In'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      registerRoute,
                      (route) => false,
                    );
                  },
                  child: const Text('Not registered yet, Register here'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
