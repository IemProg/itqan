import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/spacing.dart';
import '../../core/theme/typography.dart';
import '../mushaf/mushaf_screen.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: ItqanColors.void_,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.all(ItqanSpacing.lg),
              sliver: SliverList(
                delegate: SliverChildListDelegate([
                  const SizedBox(height: ItqanSpacing.md),
                  // Greeting
                  const Text(
                    'السلام عليكم',
                    style: TextStyle(
                      fontFamily: 'NotoNaskhArabic',
                      fontSize: 28,
                      color: ItqanColors.gold,
                      height: 1.5,
                    ),
                    textAlign: TextAlign.center,
                    textDirection: TextDirection.rtl,
                  ),
                  const SizedBox(height: ItqanSpacing.xs),
                  const Text(
                    'Perfect your recitation, one ayah at a time.',
                    style: ItqanTypography.body,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: ItqanSpacing.xl),

                  // Continue Card
                  _ContinueCard(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const MushafScreen()),
                    ),
                  ),
                  const SizedBox(height: ItqanSpacing.lg),

                  // Quick Actions Grid
                  const Text('Practice', style: ItqanTypography.label),
                  const SizedBox(height: ItqanSpacing.md),
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: ItqanSpacing.md,
                    mainAxisSpacing: ItqanSpacing.md,
                    childAspectRatio: 1.4,
                    children: [
                      _ActionCard(
                        icon: Icons.menu_book_rounded,
                        label: 'Read',
                        subtitle: 'Browse Quran',
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const MushafScreen()),
                        ),
                      ),
                      _ActionCard(
                        icon: Icons.psychology_rounded,
                        label: 'Memorize',
                        subtitle: 'Hifz mode',
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const MushafScreen()),
                        ),
                      ),
                      _ActionCard(
                        icon: Icons.headphones_rounded,
                        label: 'Listen',
                        subtitle: 'Qari audio',
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const MushafScreen()),
                        ),
                      ),
                      _ActionCard(
                        icon: Icons.bar_chart_rounded,
                        label: 'Progress',
                        subtitle: 'Your stats',
                        onTap: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: ItqanSpacing.xl),
                ]),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 0,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.menu_book_rounded), label: 'Quran'),
          BottomNavigationBarItem(icon: Icon(Icons.mic_rounded), label: 'Record'),
          BottomNavigationBarItem(icon: Icon(Icons.bar_chart_rounded), label: 'Progress'),
          BottomNavigationBarItem(icon: Icon(Icons.settings_rounded), label: 'Settings'),
        ],
        onTap: (i) {
          if (i == 1 || i == 2) {
            Navigator.push(context, MaterialPageRoute(builder: (_) => const MushafScreen()));
          }
        },
      ),
    );
  }
}

class _ContinueCard extends StatelessWidget {
  final VoidCallback onTap;
  const _ContinueCard({required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(ItqanSpacing.lg),
        decoration: BoxDecoration(
          color: ItqanColors.onyx,
          borderRadius: BorderRadius.circular(ItqanRadius.lg),
          border: Border.all(color: ItqanColors.goldGlow, width: 1),
        ),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                color: ItqanColors.goldShimmer,
                borderRadius: BorderRadius.circular(ItqanRadius.md),
                border: Border.all(color: ItqanColors.goldGlow, width: 1),
              ),
              child: const Icon(Icons.play_arrow_rounded, color: ItqanColors.gold, size: 28),
            ),
            const SizedBox(width: ItqanSpacing.md),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Start with Al-Fatiha', style: ItqanTypography.label),
                  SizedBox(height: 2),
                  Text('Surah 1 • 7 ayahs', style: ItqanTypography.caption),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios_rounded, color: ItqanColors.mist, size: 16),
          ],
        ),
      ),
    );
  }
}

class _ActionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final String subtitle;
  final VoidCallback onTap;

  const _ActionCard({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(ItqanSpacing.md),
        decoration: BoxDecoration(
          color: ItqanColors.onyx,
          borderRadius: BorderRadius.circular(ItqanRadius.lg),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Icon(icon, color: ItqanColors.gold, size: 24),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: ItqanTypography.label),
                Text(subtitle, style: ItqanTypography.caption),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
