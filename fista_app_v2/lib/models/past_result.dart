// lib/models/past_result.dart
import 'question.dart';

class PastResult {
  final InvestmentType type;
  final DateTime timestamp;
  final List<InvestmentType> answers;

  PastResult({
    required this.type,
    required this.timestamp,
    required this.answers,
  });

  // SharedPreferences などに保存するための JSON 変換
  Map<String, dynamic> toJson() => {
        'type': type.name,
        'timestamp': timestamp.toIso8601String(),
        'answers': answers.map((e) => e.name).toList(),
      };

  // JSON から再構築するとき
  factory PastResult.fromJson(Map<String, dynamic> json) => PastResult(
        type: InvestmentType.values
            .firstWhere((e) => e.name == json['type'] as String),
        timestamp: DateTime.parse(json['timestamp'] as String),
        answers: (json['answers'] as List<dynamic>)
            .map((e) =>
                InvestmentType.values.firstWhere((it) => it.name == e as String))
            .toList(),
      );
}