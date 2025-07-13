// ignore_for_file: typo

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  /// フェードアウト後に表示したい画面を渡します
  final Widget nextScreen;

  const SplashScreen({
    super.key,
    required this.nextScreen,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _ani;
  bool _animationDone = false; // アニメ完了後は true に

  @override
  void initState() {
    super.initState();

    // ① アニメーション全体 ＝ 4秒（1秒フェードイン + 2秒保持 + 1秒フェードアウト）
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    // ② TweenSequence でフェードイン→保持→フェードアウトを定義
    _ani = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: 0.0, end: 1.0)
            .chain(CurveTween(curve: Curves.easeIn)), // フェードイン
        weight: 1,
      ),
      TweenSequenceItem(
        tween: ConstantTween<double>(1.0),           // 完全表示
        weight: 2,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 1.0, end: 0.0)
            .chain(CurveTween(curve: Curves.easeOut)),// フェードアウト
        weight: 1,
      ),
    ]).animate(_ctrl)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          // アニメ完了したのでフラグを立て、即ナビゲーション
          setState(() => _animationDone = true);
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (_) => widget.nextScreen),
          );
        }
      });

    // ③ アニメーション開始
    _ctrl.forward();
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // アニメ完了後は何も描かない
    if (_animationDone) {
      return const SizedBox.shrink();
    }

    // アニメ中はフェードトランジション
    return Scaffold(
      backgroundColor: const Color(0xFFF5F3E7),
      body: Center(
        child: FadeTransition(
          opacity: _ani,
          child: Image.asset(
            'assets/fista_icon_1024.png',
            width: 200,
            height: 200,
          ),
        ),
      ),
    );
  }
}