import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'viewmodels/video_player_viewmodel.dart';
import 'views/pip_video_player.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  bool _initialized = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      final vm = Provider.of<VideoPlayerViewModel>(context, listen: false);
      vm.initialize('assets/sample_video.mp4');
      _initialized = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<VideoPlayerViewModel>(context); // 👈 fix here

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: vm.isFullScreen
            ? null
            : AppBar(title: const Text("Appversal_Assignment")),
        body: Stack(
          children: [
            const Center(child: Text("Main Content")),
            const PiPVideoPlayer(),

            if (!vm.isVisible)
              Positioned(
                bottom: 30,
                right: 30,
                child: FloatingActionButton(
                  onPressed: vm.restorePiP,
                  backgroundColor: Colors.blueAccent,
                  child: const Icon(Icons.picture_in_picture_alt_outlined),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
