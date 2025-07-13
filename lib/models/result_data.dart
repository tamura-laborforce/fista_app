// lib/models/result_data.dart
import 'question.dart';

class ResultData {
  final String title, description;
  const ResultData({required this.title, required this.description});
}

const resultMapping = <InvestmentType, ResultData>{
  InvestmentType.A: ResultData(
    title: 'Aタイプ：安定志向型',
    description: '…（説明文）…',
  ),
  InvestmentType.B: ResultData(
    title: 'Bタイプ：アクティブチャレンジャー',
    description: '…',
  ),
  InvestmentType.C: ResultData(
    title: 'Cタイプ：ハンズオフ・ビルダー',
    description: '…',
  ),
};