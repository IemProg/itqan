import 'dart:math';
import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';

class WaveformVisualizer extends StatefulWidget {
  final bool isActive;
  const WaveformVisualizer({super.key, required this.isActive});

  @override
  State<WaveformVisualizer> createState() => _WaveformVisualizerState();
}

class _WaveformVisualizerState extends State<WaveformVisualizer> with TickerProviderStateMixin {
  static const int barCount = 16;
  final List<AnimationController> _controllers = [];
  final List<Animation<double>> _animations = [];
  final Random _random = Random();

  @override
  void initState() {
    super.initState();
    for (int i = 0; i < barCount; i++) {
      final duration = Duration(milliseconds: 400 + _random.nextInt(400));
      final ctrl = AnimationController(vsync: this, duration: duration);
      final anim = Tween<double>(begin: 0.1, end: 1.0).animate(
        CurvedAnimation(parent: ctrl, curve: Curves.easeInOut),
      );
      _controllers.add(ctrl);
      _animations.add(anim);
      Future.delayed(Duration(milliseconds: _random.nextInt(300)), () {
        if (mounted && widget.isActive) ctrl.repeat(reverse: true);
      });
    }
  }

  @override
  void didUpdateWidget(WaveformVisualizer old) {
    super.didUpdateWidget(old);
    if (widget.isActive && !old.isActive) {
      for (final c in _controllers) c.repeat(reverse: true);
    } else if (!widget.isActive && old.isActive) {
      for (final c in _controllers) {
        c.animateTo(0.1);
      }
    }
  }

  @override
  void dispose() {
    for (final c in _controllers) c.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(barCount, (i) {
          return AnimatedBuilder(
            animation: _animations[i],
            builder: (context, _) {
              return Container(
                width: 4,
                height: 4 + 44 * _animations[i].value,
                margin: const EdgeInsets.symmetric(horizontal: 2),
                decoration: BoxDecoration(
                  color: ItqanColors.gold.withOpacity(0.6 + 0.4 * _animations[i].value),
                  borderRadius: BorderRadius.circular(2),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}
