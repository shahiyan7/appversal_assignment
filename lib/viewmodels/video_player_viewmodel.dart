import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerViewModel extends ChangeNotifier {
  late VideoPlayerController _controller;
  bool _isInitialized = false;
  bool _isFullScreen = false;
  bool _isVisible = true;
  bool _isBuffering = false;
  Offset _offset = const Offset(20, 500);
  double _width = 300;
  double _height = 200;

  bool get isInitialized => _isInitialized;
  bool get isFullScreen => _isFullScreen;
  bool get isMuted => _controller.value.volume == 0;
  bool get isVisible => _isVisible;
  bool get isBuffering => _isBuffering;
  Offset get offset => _offset;
  double get width => _width;
  double get height => _height;
  VideoPlayerController get controller => _controller;

  Future<void> initialize(String assetPath) async {
    _controller = VideoPlayerController.asset(assetPath);

    _controller.addListener(() {
      final buffering = _controller.value.isBuffering;
      if (buffering != _isBuffering) {
        _isBuffering = buffering;
        notifyListeners();
      }
    });

    await _controller.initialize();
    _controller.setLooping(true);
    _controller.setVolume(1); // avoid sound delay
    _controller.play();
    _isInitialized = true;
    notifyListeners();
  }

  void togglePlayPause() {
    _controller.value.isPlaying ? _controller.pause() : _controller.play();
    notifyListeners();
  }

  void toggleMute() {
    _controller.setVolume(isMuted ? 1 : 0);
    notifyListeners();
  }

  void enterFullScreen() {
    _isFullScreen = true;
    notifyListeners();
  }

  void exitFullScreen() {
    _isFullScreen = false;
    notifyListeners();
  }

  void seekForward() {
    final current = _controller.value.position;
    final duration = _controller.value.duration;
    final target = current + const Duration(seconds: 10);
    _controller.seekTo(target > duration ? duration : target);
  }

  void seekBackward() {
    final current = _controller.value.position;
    final target = current - const Duration(seconds: 10);
    _controller.seekTo(target < Duration.zero ? Duration.zero : target);
  }

  void setPosition(Offset newOffset) {
    final screenSize = WidgetsBinding.instance.platformDispatcher.views.first.physicalSize /
        WidgetsBinding.instance.platformDispatcher.views.first.devicePixelRatio;

    final dx = newOffset.dx.clamp(0, screenSize.width - _width);
    final dy = newOffset.dy.clamp(0, screenSize.height - _height);

    _offset = Offset(dx.toDouble(), dy.toDouble());
    notifyListeners();
  }


  void setSize(Size newSize) {
    const minWidth = 200.0;
    const maxWidth = 400.0;
    const minHeight = 150.0;
    const maxHeight = 300.0;

    _width = newSize.width.clamp(minWidth, maxWidth);
    _height = newSize.height.clamp(minHeight, maxHeight);
    notifyListeners();
  }

  void hidePiP() {
    _isVisible = false;
    _controller.pause();
    notifyListeners();
  }

  void restorePiP() {
    _isVisible = true;
    _controller.play();
    notifyListeners();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
