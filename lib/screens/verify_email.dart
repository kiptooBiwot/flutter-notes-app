import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

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
      body: Column(
        children: [
          const SizedBox(
            height: 40.0,
          ),
          const Text('Please verify your email'),
          TextButton(
            onPressed: _verifyEmail,
            child: const Text('Send Email Verification'),
          ),
        ],
      ),
    );
  }
}
