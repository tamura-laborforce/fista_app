import 'package:flutter/material.dart';

class VideoDetailScreen extends StatelessWidget {
  final String title;
  const VideoDetailScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            // push player
          },
          child: const Text('Play'),
        ),
      ),
    );
  }
}