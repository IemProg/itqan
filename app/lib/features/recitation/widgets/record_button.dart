import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';

enum RecordButtonState { idle, recording, processing }

class RecordButton extends StatefulWidget {
  final RecordButtonState state;
  final VoidCallback onTap;

  const RecordButton({super.key, required this.state, required this.onTap});

  @override
  State<RecordButton> createState() => _RecordButtonState();
}

class _RecordButtonState extends State<RecordButton> with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _scaleController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1500))
      ..repeat();
    _scaleController = AnimationController(vsync: this, duration: const Duration(milliseconds: 300));
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.6).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeOut),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.92).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );
  }

  @override
  void didUpdateWidget(RecordButton old) {
    super.didUpdateWidget(old);
    if (widget.state == RecordButtonState.recording) {
      _pulseController.repeat();
    } else {
      _pulseController.stop();
      _pulseController.reset();
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const size = 72.0;
    final isRecording = widget.state == RecordButtonState.recording;
    final isProcessing = widget.state == RecordButtonState.processing;

    return GestureDetector(
      onTapDown: (_) => _scaleController.forward(),
      onTapUp: (_) {
        _scaleController.reverse();
        widget.onTap();
      },
      onTapCancel: () => _scaleController.reverse(),
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) => Transform.scale(
          scale: _scaleAnimation.value,
          child: SizedBox(
            width: size + 32,
            height: size + 32,
            child: Stack(
              alignment: Alignment.center,
              children: [
                if (isRecording)
                  AnimatedBuilder(
                    animation: _pulseAnimation,
                    builder: (context, _) => Transform.scale(
                      scale: _pulseAnimation.value,
                      child: Container(
                        width: size,
                        height: size,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: ItqanColors.error.withOpacity(
                              1 - (_pulseAnimation.value - 1) / 0.6,
                            ),
                            width: 2,
                          ),
                        ),
                      ),
                    ),
                  ),
                Container(
                  width: size,
                  height: size,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isRecording ? ItqanColors.error : ItqanColors.gold,
                    boxShadow: [
                      BoxShadow(
                        color: (isRecording ? ItqanColors.error : ItqanColors.gold)
                            .withOpacity(0.35),
                        blurRadius: 24,
                        spreadRadius: 4,
                      ),
                    ],
                  ),
                  child: isProcessing
                      ? const Padding(
                          padding: EdgeInsets.all(20),
                          child: CircularProgressIndicator(
                            color: ItqanColors.void_,
                            strokeWidth: 3,
                          ),
                        )
                      : Icon(
                          isRecording ? Icons.stop_rounded : Icons.mic_rounded,
                          color: ItqanColors.void_,
                          size: 32,
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
