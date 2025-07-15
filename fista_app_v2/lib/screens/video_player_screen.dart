import 'package:flutter/material.dart';

class VideoPlayerScreen extends StatelessWidget {
  final String title;
  const VideoPlayerScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Playing $title')),
      body: const Center(child: Icon(Icons.play_arrow, size: 80)),
    );
  }
}