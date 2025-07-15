import 'package:flutter/material.dart';

class TermsScreen extends StatelessWidget {
  const TermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Terms')),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Text('Terms and Privacy Policy go here...'),
      ),
    );
  }
}