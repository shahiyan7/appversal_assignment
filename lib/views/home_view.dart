import 'package:flutter/material.dart';
import 'pip_video_player.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [
          Center(child: Text("Welcome to PiP Video Player")),
          PiPVideoPlayer(),
        ],
      ),
    );
  }
}
