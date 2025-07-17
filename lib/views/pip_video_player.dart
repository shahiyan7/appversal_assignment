import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import '../viewmodels/video_player_viewmodel.dart';

class PiPVideoPlayer extends StatefulWidget {
  const PiPVideoPlayer({super.key});

  @override
  State<PiPVideoPlayer> createState() => _PiPVideoPlayerState();
}

class _PiPVideoPlayerState extends State<PiPVideoPlayer> {
  bool _showControls = true;
  Timer? _hideTimer;

  void _startHideTimer() {
    _hideTimer?.cancel();
    _hideTimer = Timer(const Duration(seconds: 3), () {
      setState(() => _showControls = false);
    });
  }

  @override
  void initState() {
    super.initState();
    _startHideTimer();
  }

  @override
  void dispose() {
    _hideTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<VideoPlayerViewModel>(context);
    if (!vm.isInitialized || !vm.isVisible) return const SizedBox.shrink();
    final controller = vm.controller;

    final mediaSize = MediaQuery.of(context).size;
    final isLandscape = mediaSize.width > mediaSize.height;

    return Positioned(
      left: vm.isFullScreen ? 0 : vm.offset.dx,
      top: vm.isFullScreen ? 0 : vm.offset.dy,
      child: GestureDetector(
        onTap: () {
          setState(() => _showControls = !_showControls);
          if (_showControls) _startHideTimer();
        },
        onDoubleTapDown: (details) {
          final tapX = details.globalPosition.dx;
          final screenWidth = MediaQuery.of(context).size.width;
          if (tapX < screenWidth / 2) {
            vm.seekBackward();
          } else {
            vm.seekForward();
          }
        },
        onPanUpdate: (details) {
          if (!vm.isFullScreen) {
            final newOffset = vm.offset + details.delta;

            // Bound check
            final newX = newOffset.dx.clamp(0.0, mediaSize.width - 300);
            final newY = newOffset.dy.clamp(0.0, mediaSize.height - 200);
            vm.setPosition(Offset(newX, newY));
          }
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: vm.isFullScreen ? mediaSize.width : 300,
          height: vm.isFullScreen ? mediaSize.height : 200,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: vm.isFullScreen ? null : BorderRadius.circular(12),
          ),
          child: Stack(
            children: [
              Center(
                child: AspectRatio(
                  aspectRatio: controller.value.aspectRatio,
                  child: VideoPlayer(controller),
                ),
              ),
              if (vm.isFullScreen && _showControls)
                Positioned(
                  top: 32,
                  right: 16,
                  child: IconButton(
                    icon: const Icon(Icons.close, color: Colors.white, size: 28),
                    onPressed: () => vm.hidePiP(),
                  ),
                ),

              // ▶️ Pause/Play Center Icon
              if (_showControls)
                Center(
                  child: AnimatedOpacity(
                    opacity: _showControls ? 1.0 : 0.0,
                    duration: const Duration(milliseconds: 300),
                    child: IconButton(
                      icon: Icon(
                        controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
                        color: Colors.white,
                        size: 40,
                      ),
                      onPressed: () {
                        vm.togglePlayPause();
                        _startHideTimer();
                      },
                    ),
                  ),
                ),

              // Bottom Controls
              if (_showControls)
                Positioned(
                  bottom: 8,
                  left: 8,
                  right: 8,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // 🔇 Mute/Unmute
                      IconButton(
                        icon: Icon(
                          vm.isMuted ? Icons.volume_off : Icons.volume_up,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          vm.toggleMute();
                          _startHideTimer();
                        },
                      ),

                      // ⏳ Progress bar
                      Expanded(
                        child: VideoProgressIndicator(
                          controller,
                          allowScrubbing: true,
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          colors: const VideoProgressColors(
                            playedColor: Colors.blueAccent,
                            backgroundColor: Colors.grey,
                          ),
                        ),
                      ),

                      // ⛶ Fullscreen toggle
                      IconButton(
                        icon: Icon(
                          vm.isFullScreen ? Icons.fullscreen_exit : Icons.fullscreen,
                          color: Colors.white,
                        ),
                        onPressed: () {
                          setState(() {
                            vm.isFullScreen
                                ? vm.exitFullScreen()
                                : vm.enterFullScreen();
                          });
                          _startHideTimer();
                        },
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
