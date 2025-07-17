import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app.dart';
import 'viewmodels/video_player_viewmodel.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => VideoPlayerViewModel(),
      child: const App(), // ✅ Not MyApp — App comes from app.dart
    ),
  );
}
