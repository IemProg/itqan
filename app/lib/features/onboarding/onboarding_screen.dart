import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/spacing.dart';
import '../../core/theme/typography.dart';
import '../settings/settings_service.dart';
import '../home/home_screen.dart';
import '../quran/models/ayah.dart';
import '../quran/services/quran_service.dart';
import '../recitation/recitation_screen.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final _controller = PageController();
  int _page = 0;
  String _selectedLevel = 'beginner';
  int _selectedGoal = 20;

  void _next() {
    if (_page < 2) {
      _controller.nextPage(duration: const Duration(milliseconds: 350), curve: Curves.easeInOut);
    }
  }

  Future<void> _finish() async {
    // Save settings
    final settings = ref.read(settingsProvider);
    await ref.read(settingsProvider.notifier).update(
      settings.copyWith(level: _selectedLevel, dailyGoalMinutes: _selectedGoal),
    );
    // Mark onboarding done
    await Hive.box('settings').put('onboarding_done', true);
    if (!mounted) return;
    // Navigate to recitation for Surah 1 Ayah 1
    final service = QuranService();
    await service.init();
    final ayahs = await service.getAyahs(1);
    if (!mounted) return;
    if (ayahs.isNotEmpty) {
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (_) => RecitationScreenWrapper(ayah: ayahs.first, surahName: 'Al-Fatiha'),
      ));
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomeScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ItqanColors.void_,
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (i) => setState(() => _page = i),
            children: [
              _WelcomePage(onNext: _next),
              _LevelPage(
                selected: _selectedLevel,
                onSelect: (l) => setState(() => _selectedLevel = l),
                onNext: _next,
              ),
              _GoalPage(
                selected: _selectedGoal,
                onSelect: (g) => setState(() => _selectedGoal = g),
                onFinish: _finish,
              ),
            ],
          ),
          // Dot indicators
          Positioned(
            bottom: 40, left: 0, right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (i) => AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                margin: const EdgeInsets.symmetric(horizontal: 4),
                width: _page == i ? 20 : 8,
                height: 8,
                decoration: BoxDecoration(
                  color: _page == i ? ItqanColors.gold : ItqanColors.charcoal,
                  borderRadius: BorderRadius.circular(ItqanRadius.full),
                ),
              )),
            ),
          ),
        ],
      ),
    );
  }
}

class _WelcomePage extends StatelessWidget {
  final VoidCallback onNext;
  const _WelcomePage({required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Islamic pattern placeholder
        CustomPaint(size: const Size(160, 160), painter: _IslamicPatternPainter()),
        const SizedBox(height: ItqanSpacing.xl),
        const Text(
          'إتقان',
          style: TextStyle(fontFamily: 'Amiri', fontSize: 64, color: ItqanColors.gold, height: 1.4),
          textDirection: TextDirection.rtl,
        ),
        const Text('Itqan', style: TextStyle(fontFamily: 'Inter', fontSize: 24, color: ItqanColors.mist)),
        const SizedBox(height: ItqanSpacing.sm),
        const Text(
          'Perfect your Quran recitation',
          style: TextStyle(fontSize: 16, color: ItqanColors.silver),
        ),
        const SizedBox(height: ItqanSpacing.xxl),
        GestureDetector(
          onTap: onNext,
          child: Container(
            width: 56, height: 56,
            decoration: BoxDecoration(
              color: ItqanColors.goldShimmer,
              shape: BoxShape.circle,
              border: Border.all(color: ItqanColors.gold),
            ),
            child: const Icon(Icons.arrow_forward_rounded, color: ItqanColors.gold),
          ),
        ),
      ],
    );
  }
}

class _LevelPage extends StatelessWidget {
  final String selected;
  final ValueChanged<String> onSelect;
  final VoidCallback onNext;
  const _LevelPage({required this.selected, required this.onSelect, required this.onNext});

  @override
  Widget build(BuildContext context) {
    final levels = [
      {'key': 'beginner', 'emoji': '🌱', 'title': 'Beginner', 'sub': "I'm learning to read Arabic"},
      {'key': 'intermediate', 'emoji': '📖', 'title': 'Intermediate', 'sub': 'I can read, want better tajweed'},
      {'key': 'advanced', 'emoji': '🎓', 'title': 'Advanced', 'sub': 'I want to perfect my recitation'},
    ];

    return Padding(
      padding: const EdgeInsets.all(ItqanSpacing.lg),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text("What's your experience level?", style: ItqanTypography.heading2, textAlign: TextAlign.center),
          const SizedBox(height: ItqanSpacing.xl),
          ...levels.map((l) {
            final active = selected == l['key'];
            return GestureDetector(
              onTap: () => onSelect(l['key']!),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                margin: const EdgeInsets.only(bottom: ItqanSpacing.md),
                padding: const EdgeInsets.all(ItqanSpacing.md),
                decoration: BoxDecoration(
                  color: active ? ItqanColors.goldShimmer : ItqanColors.onyx,
                  borderRadius: BorderRadius.circular(ItqanRadius.lg),
                  border: Border.all(color: active ? ItqanColors.gold : ItqanColors.charcoal),
                  boxShadow: active ? [BoxShadow(color: ItqanColors.goldGlow, blurRadius: 12)] : null,
                ),
                child: Row(
                  children: [
                    Text(l['emoji']!, style: const TextStyle(fontSize: 28)),
                    const SizedBox(width: ItqanSpacing.md),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(l['title']!, style: ItqanTypography.label.copyWith(color: active ? ItqanColors.gold : ItqanColors.snow)),
                        Text(l['sub']!, style: ItqanTypography.caption),
                      ],
                    ),
                  ],
                ),
              ),
            );
          }),
          const SizedBox(height: ItqanSpacing.xl),
          _GoldButton(label: 'Continue', onPressed: onNext),
        ],
      ),
    );
  }
}

class _GoalPage extends StatelessWidget {
  final int selected;
  final ValueChanged<int> onSelect;
  final VoidCallback onFinish;
  const _GoalPage({required this.selected, required this.onSelect, required this.onFinish});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(ItqanSpacing.lg),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text('How much time can you practice daily?', style: ItqanTypography.heading2, textAlign: TextAlign.center),
          const SizedBox(height: ItqanSpacing.xl),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [10, 20, 30].map((min) {
              final active = selected == min;
              return GestureDetector(
                onTap: () => onSelect(min),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                  decoration: BoxDecoration(
                    color: active ? ItqanColors.goldShimmer : ItqanColors.onyx,
                    borderRadius: BorderRadius.circular(ItqanRadius.full),
                    border: Border.all(color: active ? ItqanColors.gold : ItqanColors.charcoal),
                  ),
                  child: Text(
                    '$min min',
                    style: TextStyle(color: active ? ItqanColors.gold : ItqanColors.mist, fontWeight: FontWeight.w600),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: ItqanSpacing.xxl),
          _GoldButton(label: 'Start with Al-Fatiha', onPressed: onFinish),
        ],
      ),
    );
  }
}

class _GoldButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  const _GoldButton({required this.label, required this.onPressed});

  @override
  Widget build(BuildContext context) => ElevatedButton(
    onPressed: onPressed,
    style: ElevatedButton.styleFrom(
      backgroundColor: ItqanColors.gold,
      foregroundColor: ItqanColors.void_,
      padding: const EdgeInsets.symmetric(vertical: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(ItqanRadius.lg)),
    ),
    child: Text(label, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
  );
}

// Simple 8-pointed Islamic star pattern
class _IslamicPatternPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = ItqanColors.gold.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final center = Offset(size.width / 2, size.height / 2);
    final r = size.width / 2;

    // Outer circle
    canvas.drawCircle(center, r - 4, paint);

    // 8-pointed star
    final starPaint = Paint()
      ..color = ItqanColors.gold.withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    final path = Path();
    for (int i = 0; i < 8; i++) {
      final angle1 = (i * 45) * 3.14159 / 180;
      final angle2 = ((i * 45) + 22.5) * 3.14159 / 180;
      final outer = Offset(center.dx + (r - 10) * _cos(angle1), center.dy + (r - 10) * _sin(angle1));
      final inner = Offset(center.dx + (r * 0.4) * _cos(angle2), center.dy + (r * 0.4) * _sin(angle2));
      if (i == 0) path.moveTo(outer.dx, outer.dy);
      else path.lineTo(outer.dx, outer.dy);
      path.lineTo(inner.dx, inner.dy);
    }
    path.close();
    canvas.drawPath(path, starPaint);

    // Inner decorative circle
    final innerCircle = Paint()
      ..color = ItqanColors.gold.withOpacity(0.2)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, r * 0.25, innerCircle);
  }

  double _cos(double rad) => _approxCos(rad);
  double _sin(double rad) => _approxSin(rad);

  // Use dart:math equivalent approximations
  double _approxCos(double x) {
    // Simple Taylor/identity: use platform's math
    return _mathCos(x);
  }
  double _approxSin(double x) => _mathSin(x);

  static double _mathCos(double x) {
    // cos via series
    double result = 1;
    double term = 1;
    for (int i = 1; i <= 10; i++) {
      term *= -x * x / ((2 * i - 1) * (2 * i));
      result += term;
    }
    return result;
  }

  static double _mathSin(double x) {
    double result = x;
    double term = x;
    for (int i = 1; i <= 10; i++) {
      term *= -x * x / ((2 * i) * (2 * i + 1));
      result += term;
    }
    return result;
  }

  @override
  bool shouldRepaint(_) => false;
}

// Wrapper to use when navigating to recitation from onboarding
class RecitationScreenWrapper extends ConsumerWidget {
  final Ayah ayah;
  final String surahName;
  const RecitationScreenWrapper({super.key, required this.ayah, required this.surahName});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return RecitationScreen(ayah: ayah, surahName: surahName);
  }
}
