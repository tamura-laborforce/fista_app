import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';     // ← 追加
import 'firebase_options.dart';                        // ← 追加
import 'screens/landing_screen.dart';                  // ← 既存

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // ← ここで Firebase を初期化
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const FiSTAApp());
}

class FiSTAApp extends StatelessWidget {
  const FiSTAApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FiSTA',
      theme: ThemeData(
        primarySwatch: Colors.pink,
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: const Color(0xFFFFF4ED),
      ),
      home: const LandingScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}