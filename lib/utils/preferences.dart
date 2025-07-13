import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/past_result.dart';

Future<void> setDiagnosisIsDone() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('hasDoneDiagnosis', true);
}

/// 診断済みかどうかを取得
Future<bool> hasDoneDiagnosis() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool('diagnosisDone') ?? false;
}

/// 診断済み状態を保存
Future<void> setDiagnosisDone() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.setBool('diagnosisDone', true);
}

/// 診断結果をリセット
Future<void> resetDiagnosisFlag() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove('hasDoneDiagnosis');
}

const _kPastResultsKey = 'past_results';

Future<List<PastResult>> getPastResults() async {
  final prefs = await SharedPreferences.getInstance();
  final s = prefs.getString(_kPastResultsKey);
  if (s == null) return [];
  return (jsonDecode(s) as List)
      .map((e) => PastResult.fromJson(e))
      .toList();
}

Future<void> addPastResult(PastResult r) async {
  final prefs = await SharedPreferences.getInstance();
  final list = await getPastResults();
  list.add(r);
  await prefs.setString(_kPastResultsKey, jsonEncode(list));
}

Future<void> clearPastResults() async {
  final prefs = await SharedPreferences.getInstance();
  await prefs.remove(_kPastResultsKey);
}