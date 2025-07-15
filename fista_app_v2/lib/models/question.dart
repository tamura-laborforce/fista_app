// lib/models/question.dart
enum InvestmentType { A, B, C }

class Question {
  final String text;
  final List<AnswerOption> options;
  const Question({required this.text, required this.options});
}

class AnswerOption {
  final String text;
  final InvestmentType type;
  const AnswerOption({required this.text, required this.type});
}

/// 質問データ（Q1～Q5）
const questions = <Question>[
  Question(
    text: 'どのようなスタイルで投資を始めたいですか？',
    options: [
      AnswerOption(text: '安定的に少しずつ進めたい', type: InvestmentType.A),
      AnswerOption(text: '手間はあっても自分で動いて進めたい', type: InvestmentType.B),
      AnswerOption(text: '自分の時間を大切にして、任せられるところは任せたい', type: InvestmentType.C),
    ],
  ),
  Question(
    text: 'DIYやリフォーム作業に対して、どう感じますか？',
    options: [
      AnswerOption(text: '好き。自分で手を動かすのは苦にならない', type: InvestmentType.B),
      AnswerOption(text: '苦手ではないが、できればプロに任せたい', type: InvestmentType.C),
      AnswerOption(text: 'なるべくやりたくない。安定性重視', type: InvestmentType.A),
    ],
  ),
  Question(
    text: '本業や家庭の忙しさを考えると、投資にかけられる時間は？',
    options: [
      AnswerOption(text: '限られているので、効率的に任せたい', type: InvestmentType.C),
      AnswerOption(text: '時間はある程度作れる', type: InvestmentType.A),
      AnswerOption(text: '自分で動くのも苦じゃない', type: InvestmentType.B),
    ],
  ),
  Question(
    text: 'こんな場合、どちらを選びますか？\n\n'
          'A：月3万円の安定収入が5年間続く\n'
          'B：最初の3ヶ月は赤字でも、その後月10万円になる可能性がある',
    options: [
      AnswerOption(text: 'Aを選ぶ', type: InvestmentType.A),
      AnswerOption(text: 'Bを選ぶ', type: InvestmentType.B),
      AnswerOption(text: '条件がよければ、誰かに任せて実現したい', type: InvestmentType.C),
    ],
  ),
  Question(
    text: 'あなたにとって「理想の投資の形」はどれに近いですか？',
    options: [
      AnswerOption(text: 'なるべくリスクを抑え、ゆっくり確実に増やす', type: InvestmentType.A),
      AnswerOption(text: 'スピード感と変化のある戦略で挑戦したい', type: InvestmentType.B),
      AnswerOption(text: '本業や家族との時間を優先し、投資は仕組みで回したい', type: InvestmentType.C),
    ],
  ),
];