import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes_app/constants/routes.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({Key? key}) : super(key: key);

  @override
  _VerifyEmailViewState createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  // Verify user email fn
  void _verifyEmail() async {
    final user = FirebaseAuth.instance.currentUser;

    await user?.sendEmailVerification();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verify Email'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
                'We\'ve already sent you an email verification. Open it to verify your email address'),
            const SizedBox(height: 20.0),
            const Text(
                'If you haven\'t received a verification email yet, press the button below to resend.'),
            TextButton(
              onPressed: _verifyEmail,
              child: const Text('Send Email Verification'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamedAndRemoveUntil(
                  loginRoute,
                  (route) => false,
                );
              },
              child: const Text('Go to Login'),
            ),
          ],
        ),
      ),
    );
  }
}
