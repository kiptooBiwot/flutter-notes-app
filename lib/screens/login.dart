import 'package:flutter/material.dart';
import 'package:notes_app/constants/routes.dart';
import 'package:notes_app/services/auth/auth_exceptions.dart';
import 'package:notes_app/services/auth/auth_service.dart';
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
      await AuthService.firebase().login(
        email: email,
        password: password,
      );

      // Check if email is verified
      final user = AuthService.firebase().currentUser;

      if (user?.isEmailVerified ?? false) {
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
    } on UserNotFoundAuthException {
      await showErrorDialog(
          context, 'User not found. Do you want to register a new account?');
    } on WrongPasswordAuthException {
      await showErrorDialog(
          context, 'Invalid email and/or password. Try again.');
    } on InvalidEmailAuthException {
      await showErrorDialog(context, 'A valid email is required');
    } on GenericAuthException {
      await showErrorDialog(
        context,
        'Authentication error',
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
