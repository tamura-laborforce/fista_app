// lib/screens/diagnosis_screen.dart

import 'package:flutter/material.dart';
import '../models/question.dart';
import 'result_screen.dart';

class DiagnosisScreen extends StatefulWidget {
  const DiagnosisScreen({super.key});

  @override
  State<DiagnosisScreen> createState() => _DiagnosisScreenState();
}

class _DiagnosisScreenState extends State<DiagnosisScreen> {
  int _currentIndex = 0;

  // A/B/C のスコアカウント
  final Map<InvestmentType, int> _scores = {
    InvestmentType.A: 0,
    InvestmentType.B: 0,
    InvestmentType.C: 0,
  };

  // ユーザーが選んだタイプを順にため込むリスト
  final List<InvestmentType> _answers = [];

  /// 回答ボタンを押したときに呼ばれる
  void _answer(InvestmentType type) {
    setState(() {
      // スコア加算
      _scores[type] = _scores[type]! + 1;
      // 回答履歴にも追加
      _answers.add(type);

      if (_currentIndex < questions.length - 1) {
        // 次の質問へ
        _currentIndex++;
      } else {
        // 最終問の後 → 結果判定して ResultScreen へ遷移
        final resultType = _scores.entries
            .reduce((a, b) => a.value >= b.value ? a : b)
            .key;

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => ResultScreen(
              type: resultType,
              answers: _answers,
            ),
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[_currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text('診断 (${_currentIndex + 1}/${questions.length})'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // 質問文
            Text(
              question.text,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 24),

            // 選択肢ボタン
            ...question.options.map((opt) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: ElevatedButton(
                  onPressed: () => _answer(opt.type),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: Text(opt.text),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }
}