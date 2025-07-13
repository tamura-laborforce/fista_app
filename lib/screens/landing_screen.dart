// lib/screens/landing_screen.dart

import 'package:flutter/material.dart';
import '../utils/preferences.dart';
import 'diagnosis_screen.dart';
import 'mypage_screen.dart';
import 'diagnosis_list_screen.dart';  // ← インポート追加

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  bool? _hasDoneDiagnosis;

  @override
  void initState() {
    super.initState();
    _loadDiagnosisFlag();
  }

  Future<void> _loadDiagnosisFlag() async {
    final result = await hasDoneDiagnosis();
    setState(() => _hasDoneDiagnosis = result);
  }

  @override
  Widget build(BuildContext context) {
    if (_hasDoneDiagnosis == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFFFFF4ED),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'FiSTA',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),

            // 診断開始／マイページへ
            ElevatedButton(
              onPressed: () {
                if (_hasDoneDiagnosis!) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const MyPageScreen()),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const DiagnosisScreen()),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink[200],
                foregroundColor: Colors.white,
              ),
              child: Text(_hasDoneDiagnosis! ? 'マイページへ' : '診断をはじめる'),
            ),
            const SizedBox(height: 12),

            // 診断結果リセット
            ElevatedButton(
              onPressed: () async {
                await resetDiagnosisFlag();
                setState(() => _hasDoneDiagnosis = false);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey,
                foregroundColor: Colors.white,
              ),
              child: const Text('診断結果をリセット'),
            ),
            const SizedBox(height: 12),

            // ← ここから追加：診断結果一覧へ遷移
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const DiagnosisListScreen(),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
              child: const Text('診断結果一覧を見る'),
            ),
            // ここまで追加
          ],
        ),
      ),
    );
  }
}