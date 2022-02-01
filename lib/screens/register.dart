// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:notes_app/constants/routes.dart';
import 'package:notes_app/services/auth/auth_exceptions.dart';
import 'package:notes_app/services/auth/auth_service.dart';
import 'package:notes_app/utilities/show_error_dialog.dart';

class RegisterView extends StatefulWidget {
  const RegisterView({Key? key}) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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

  void registerUser() async {
    final email = _email.text;
    final password = _password.text;

    // Create a new Firebase Auth instance

    try {
      // Register user using email and password
      await AuthService.firebase().createUser(
        email: email,
        password: password,
      );

      // Verify email first
      AuthService.firebase().sendEmailVerification();

      // Send the user to the verify email screen
      Navigator.of(context).pushNamed(verifyEmailRoute);

      // print(_userCredential);
    } on WeakPasswordAuthException {
      await showErrorDialog(context, 'The password provided is too weak');
    } on EmailAlreadyInUseAuthException {
      await showErrorDialog(context,
          'An account already exists for that email. Do you want to login?');
    } on InvalidEmailAuthException {
      await showErrorDialog(context, 'Invalid email entered');
    } on GenericAuthException {
      await showErrorDialog(
        context,
        'Registration failed. Please try again.',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Register'),
        centerTitle: true,
      ),
      body: Center(
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
                onPressed: registerUser,
                child: const Text('Register'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    loginRoute,
                    (route) => false,
                  );
                },
                child: const Text('Have an Account? Login here'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
