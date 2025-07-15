import 'package:flutter/material.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Auth')),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Login'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Continue as Guest'),
            ),
          ],
        ),
      ),
    );
  }
}