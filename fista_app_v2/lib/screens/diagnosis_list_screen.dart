import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DiagnosisListScreen extends StatelessWidget {
  const DiagnosisListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('診断結果一覧')),
      body: StreamBuilder<QuerySnapshot>(
        // 1. StreamBuilder でリアルタイムに Firestore を監視
        stream: FirebaseFirestore.instance
            .collection('diagnoses')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          // 2. 読み込み中の表示
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          // 3. エラー時の表示
          if (snapshot.hasError) {
            return Center(child: Text('エラー: ${snapshot.error}'));
          }
          final docs = snapshot.data!.docs;
          if (docs.isEmpty) {
            return const Center(child: Text('データがありません'));
          }
          // 4. データを ListView で表示
          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final data = docs[index].data()! as Map<String, dynamic>;
              final type = data['type'] as String? ?? '—';
              final timestamp = (data['timestamp'] as Timestamp).toDate();
              return ListTile(
                title: Text('Type: $type'),
                subtitle: Text(timestamp.toLocal().toString()),
                // 必要なら answers フィールドも展開できます
              );
            },
          );
        },
      ),
    );
  }
}