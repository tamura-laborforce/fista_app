// lib/screens/result_screen.dart

import 'package:flutter/material.dart';
import 'landing_screen.dart';
import '../models/question.dart';
import '../models/result_data.dart';
import '../models/past_result.dart';           // ← PastResult モデル
import '../utils/preferences.dart';           // ← addPastResult を持つ
import 'package:cloud_firestore/cloud_firestore.dart';

class ResultScreen extends StatelessWidget {
  final InvestmentType type;
  final List<InvestmentType> answers;

  const ResultScreen({
    super.key,
    required this.type,
    required this.answers,
  });

  Future<void> _uploadAndSave() async {
    // 1) Firestore に書き込み
    await FirebaseFirestore.instance.collection('diagnoses').add({
      'type': type.name,
      'timestamp': FieldValue.serverTimestamp(),
      'answers': answers.map((e) => e.name).toList(),
    });

    // 2) SharedPreferences に保存（PastResult に answers を渡す）
    await addPastResult(
      PastResult(
        type: type,
        answers: answers,              // ← ここを追加
        timestamp: DateTime.now(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final data = resultMapping[type]!;

    // フレーム後に一度だけアップロード＆保存を実行
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _uploadAndSave();
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('診断結果'),
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              data.title,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              data.description,
              style: const TextStyle(fontSize: 16),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LandingScreen()),
                  (route) => false,
                );
              },
              child: const Text('トップに戻る'),
            ),
            const SizedBox(height: 12),
            OutlinedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const LandingScreen()),
                );
              },
              child: const Text('もう一度診断する'),
            ),
          ],
        ),
      ),
    );
  }
}
