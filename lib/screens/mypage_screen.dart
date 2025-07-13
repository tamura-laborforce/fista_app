import 'package:flutter/material.dart';
import '../models/past_result.dart';
import '../models/result_data.dart';
import '../utils/preferences.dart';

class MyPageScreen extends StatefulWidget {
  const MyPageScreen({super.key});

  @override
  State<MyPageScreen> createState() => _MyPageScreenState();
}

class _MyPageScreenState extends State<MyPageScreen> {
  late Future<List<PastResult>> _futureResults;

  @override
  void initState() {
    super.initState();
    _futureResults = getPastResults();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('マイページ')),
      body: FutureBuilder<List<PastResult>>(
        future: _futureResults,
        builder: (context, snap) {
          if (snap.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          final results = snap.data!.reversed.toList();
          if (results.isEmpty) {
            return const Center(child: Text('診断履歴がありません'));
          }
          return ListView.separated(
            padding: const EdgeInsets.all(16),
            itemCount: results.length,
            separatorBuilder: (_, __) => const Divider(),
            itemBuilder: (context, idx) {
              final res = results[idx];
              final data = resultMapping[res.type]!;
              return ListTile(
                leading: Text(
                  res.type.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                title: Text(data.title),
                subtitle: Text(
                  res.timestamp.toLocal().toString().split('.')[0],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // ① 履歴を削除
          await clearPastResults();

          // ② 新しい Future を取得
          final newFuture = getPastResults();

          // ③ 同期的に setState して画面を再ビルド
          setState(() {
            _futureResults = newFuture;
          });
        },
        tooltip: '履歴クリア',
        child: const Icon(Icons.delete),
      ),
    );
  }
}