import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/spacing.dart';
import '../../core/theme/typography.dart';

// Provider that reads sessions from Hive
final sessionsProvider = Provider<List<Map>>((ref) {
  if (!Hive.isBoxOpen('sessions')) return [];
  final box = Hive.box('sessions');
  return box.values.map((v) => Map<String, dynamic>.from(v as Map)).toList();
});

class ProgressScreen extends ConsumerWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sessions = ref.watch(sessionsProvider);

    final now = DateTime.now();
    final weekStart = now.subtract(Duration(days: now.weekday - 1));
    final weekSessions = sessions.where((s) {
      final ts = DateTime.tryParse(s['timestamp'] ?? '') ?? DateTime(2000);
      return ts.isAfter(weekStart);
    }).toList();

    final totalMinutes = (weekSessions.length * 3); // ~3 min per session estimate
    final avgScore = weekSessions.isEmpty
        ? 0.0
        : weekSessions.map((s) => (s['overall'] as num).toDouble()).reduce((a, b) => a + b) / weekSessions.length;

    // Streak
    int streak = _calcStreak(sessions);

    return Scaffold(
      backgroundColor: ItqanColors.void_,
      appBar: AppBar(
        backgroundColor: ItqanColors.void_,
        title: const Text('Progress', style: ItqanTypography.heading1),
        automaticallyImplyLeading: false,
      ),
      body: sessions.isEmpty
          ? _EmptyState()
          : ListView(
              padding: const EdgeInsets.all(ItqanSpacing.lg),
              children: [
                _WeeklySummaryCard(
                  sessions: weekSessions.length,
                  minutes: totalMinutes,
                  avgScore: avgScore,
                  streak: streak,
                ),
                const SizedBox(height: ItqanSpacing.lg),
                _ActivityHeatmap(sessions: sessions),
                const SizedBox(height: ItqanSpacing.lg),
                _SurahMastery(sessions: sessions),
                const SizedBox(height: ItqanSpacing.lg),
                _WeakSpots(sessions: sessions),
                const SizedBox(height: ItqanSpacing.lg),
                _TajweedMastery(sessions: sessions),
                const SizedBox(height: ItqanSpacing.xl),
              ],
            ),
    );
  }

  int _calcStreak(List<Map> sessions) {
    if (sessions.isEmpty) return 0;
    final days = sessions
        .map((s) {
          final ts = DateTime.tryParse(s['timestamp'] ?? '');
          return ts != null ? DateTime(ts.year, ts.month, ts.day) : null;
        })
        .whereType<DateTime>()
        .toSet()
        .toList()
      ..sort();
    if (days.isEmpty) return 0;
    int streak = 1;
    final today = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    if (days.last != today && days.last != today.subtract(const Duration(days: 1))) return 0;
    for (int i = days.length - 1; i > 0; i--) {
      if (days[i].difference(days[i - 1]).inDays == 1) {
        streak++;
      } else break;
    }
    return streak;
  }
}

class _EmptyState extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('🌙', style: TextStyle(fontSize: 64)),
        const SizedBox(height: ItqanSpacing.md),
        const Text('Your journey begins here', style: ItqanTypography.heading2),
        const SizedBox(height: ItqanSpacing.sm),
        Text(
          'Start reciting to see your progress\nand track your improvement.',
          style: ItqanTypography.body.copyWith(color: ItqanColors.mist),
          textAlign: TextAlign.center,
        ),
      ],
    ),
  );
}

class _WeeklySummaryCard extends StatelessWidget {
  final int sessions, minutes;
  final double avgScore;
  final int streak;
  const _WeeklySummaryCard({required this.sessions, required this.minutes, required this.avgScore, required this.streak});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(ItqanSpacing.lg),
      decoration: BoxDecoration(
        color: ItqanColors.onyx,
        borderRadius: BorderRadius.circular(ItqanRadius.lg),
        border: Border.all(color: ItqanColors.goldGlow),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('This Week', style: ItqanTypography.label),
          const SizedBox(height: ItqanSpacing.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _Stat(label: 'Sessions', value: '$sessions'),
              _Stat(label: 'Minutes', value: '$minutes'),
              _Stat(label: 'Avg Score', value: '${avgScore.round()}'),
            ],
          ),
          if (streak > 0) ...[
            const SizedBox(height: ItqanSpacing.md),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: ItqanColors.goldShimmer,
                borderRadius: BorderRadius.circular(ItqanRadius.full),
                border: Border.all(color: ItqanColors.goldGlow),
              ),
              child: Text('🔥 $streak day streak', style: const TextStyle(color: ItqanColors.gold, fontSize: 13, fontWeight: FontWeight.w600)),
            ),
          ],
        ],
      ),
    );
  }
}

class _Stat extends StatelessWidget {
  final String label, value;
  const _Stat({required this.label, required this.value});

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Text(value, style: const TextStyle(color: ItqanColors.gold, fontSize: 24, fontWeight: FontWeight.w700)),
      Text(label, style: ItqanTypography.caption),
    ],
  );
}

class _ActivityHeatmap extends StatelessWidget {
  final List<Map> sessions;
  const _ActivityHeatmap({required this.sessions});

  @override
  Widget build(BuildContext context) {
    // Build daily counts for last 28 days
    final now = DateTime.now();
    final counts = <DateTime, int>{};
    for (final s in sessions) {
      final ts = DateTime.tryParse(s['timestamp'] ?? '');
      if (ts != null) {
        final day = DateTime(ts.year, ts.month, ts.day);
        counts[day] = (counts[day] ?? 0) + 1;
      }
    }

    final days = List.generate(28, (i) {
      final d = now.subtract(Duration(days: 27 - i));
      return DateTime(d.year, d.month, d.day);
    });

    return Container(
      padding: const EdgeInsets.all(ItqanSpacing.md),
      decoration: BoxDecoration(
        color: ItqanColors.onyx, borderRadius: BorderRadius.circular(ItqanRadius.lg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Activity', style: ItqanTypography.label),
          const SizedBox(height: ItqanSpacing.sm),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text('M', style: TextStyle(color: ItqanColors.mist, fontSize: 11)),
              Text('T', style: TextStyle(color: ItqanColors.mist, fontSize: 11)),
              Text('W', style: TextStyle(color: ItqanColors.mist, fontSize: 11)),
              Text('T', style: TextStyle(color: ItqanColors.mist, fontSize: 11)),
              Text('F', style: TextStyle(color: ItqanColors.mist, fontSize: 11)),
              Text('S', style: TextStyle(color: ItqanColors.mist, fontSize: 11)),
              Text('S', style: TextStyle(color: ItqanColors.mist, fontSize: 11)),
            ],
          ),
          const SizedBox(height: 4),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7, crossAxisSpacing: 3, mainAxisSpacing: 3,
            ),
            itemCount: 28,
            itemBuilder: (context, i) {
              final c = counts[days[i]] ?? 0;
              final color = c == 0
                  ? ItqanColors.charcoal
                  : c == 1
                      ? ItqanColors.gold.withOpacity(0.15)
                      : c == 2
                          ? ItqanColors.gold.withOpacity(0.30)
                          : c <= 4
                              ? ItqanColors.gold.withOpacity(0.50)
                              : ItqanColors.gold;
              return Container(decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(3)));
            },
          ),
        ],
      ),
    );
  }
}

class _SurahMastery extends StatelessWidget {
  final List<Map> sessions;
  const _SurahMastery({required this.sessions});

  @override
  Widget build(BuildContext context) {
    final surahData = <int, List<double>>{};
    for (final s in sessions) {
      final surah = s['surah'] as int? ?? 0;
      final score = (s['overall'] as num? ?? 0).toDouble();
      surahData.putIfAbsent(surah, () => []).add(score);
    }

    final surahNames = {1: 'Al-Fatiha', 2: 'Al-Baqarah', 112: 'Al-Ikhlas', 113: 'Al-Falaq', 114: 'An-Nas'};

    return Container(
      padding: const EdgeInsets.all(ItqanSpacing.md),
      decoration: BoxDecoration(color: ItqanColors.onyx, borderRadius: BorderRadius.circular(ItqanRadius.lg)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Surahs Practiced', style: ItqanTypography.label),
          const SizedBox(height: ItqanSpacing.md),
          if (surahData.isEmpty)
            Text('No surahs practiced yet', style: ItqanTypography.caption.copyWith(color: ItqanColors.mist))
          else
            ...surahData.entries.map((e) {
              final avg = e.value.reduce((a, b) => a + b) / e.value.length;
              final color = avg >= 90 ? ItqanColors.correct : avg >= 70 ? ItqanColors.gold : ItqanColors.error;
              final name = surahNames[e.key] ?? 'Surah ${e.key}';
              return Padding(
                padding: const EdgeInsets.only(bottom: ItqanSpacing.sm),
                child: Row(
                  children: [
                    SizedBox(width: 100, child: Text(name, style: ItqanTypography.caption)),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(3),
                        child: LinearProgressIndicator(
                          value: avg / 100,
                          backgroundColor: ItqanColors.charcoal,
                          valueColor: AlwaysStoppedAnimation(color),
                          minHeight: 8,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text('${avg.round()}', style: TextStyle(color: color, fontSize: 12, fontWeight: FontWeight.w700)),
                  ],
                ),
              );
            }),
        ],
      ),
    );
  }
}

class _WeakSpots extends StatelessWidget {
  final List<Map> sessions;
  const _WeakSpots({required this.sessions});

  @override
  Widget build(BuildContext context) {
    // For MVP: show static weak spots derived from low tajweed scores
    final lowTajweed = sessions.where((s) => (s['tajweed'] as num? ?? 100) < 70).length;
    final lowFluency = sessions.where((s) => (s['fluency'] as num? ?? 100) < 70).length;
    final lowWord = sessions.where((s) => (s['wordAccuracy'] as num? ?? 100) < 70).length;

    final spots = <Map<String, String>>[];
    if (lowTajweed > 0) spots.add({'type': 'Tajweed Rules', 'freq': 'Missed $lowTajweed times'});
    if (lowFluency > 0) spots.add({'type': 'Fluency & Rhythm', 'freq': 'Missed $lowFluency times'});
    if (lowWord > 0) spots.add({'type': 'Word Accuracy', 'freq': 'Missed $lowWord times'});

    return Container(
      padding: const EdgeInsets.all(ItqanSpacing.md),
      decoration: BoxDecoration(color: ItqanColors.onyx, borderRadius: BorderRadius.circular(ItqanRadius.lg)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Focus Areas', style: ItqanTypography.label),
          const SizedBox(height: ItqanSpacing.sm),
          if (spots.isEmpty)
            Text('Great work! No weak spots detected yet.', style: ItqanTypography.caption.copyWith(color: ItqanColors.correct))
          else
            ...spots.take(3).map((spot) => Container(
              margin: const EdgeInsets.only(bottom: ItqanSpacing.sm),
              padding: const EdgeInsets.all(ItqanSpacing.sm),
              decoration: BoxDecoration(
                color: ItqanColors.charcoal, borderRadius: BorderRadius.circular(ItqanRadius.sm),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(spot['type']!, style: ItqanTypography.body),
                      Text(spot['freq']!, style: ItqanTypography.caption),
                    ],
                  ),
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: ItqanColors.gold),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                      minimumSize: Size.zero,
                    ),
                    child: const Text('Practice', style: TextStyle(color: ItqanColors.gold, fontSize: 12)),
                  ),
                ],
              ),
            )),
        ],
      ),
    );
  }
}

class _TajweedMastery extends StatelessWidget {
  final List<Map> sessions;
  const _TajweedMastery({required this.sessions});

  @override
  Widget build(BuildContext context) {
    final rules = ['Nun Sakinah', 'Madd', 'Qalqalah', 'Ghunnah', 'Meem Sakinah'];
    final avgTajweed = sessions.isEmpty
        ? 0.0
        : sessions.map((s) => (s['tajweed'] as num? ?? 0).toDouble()).reduce((a, b) => a + b) / sessions.length;

    return Container(
      padding: const EdgeInsets.all(ItqanSpacing.md),
      decoration: BoxDecoration(color: ItqanColors.onyx, borderRadius: BorderRadius.circular(ItqanRadius.lg)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Tajweed Mastery', style: ItqanTypography.label),
          const SizedBox(height: ItqanSpacing.md),
          ...rules.map((rule) => Padding(
            padding: const EdgeInsets.only(bottom: ItqanSpacing.sm),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(rule, style: ItqanTypography.caption),
                    Text(
                      sessions.isEmpty ? 'Not yet tested' : '${avgTajweed.round()}%',
                      style: ItqanTypography.caption.copyWith(color: ItqanColors.mist),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                ClipRRect(
                  borderRadius: BorderRadius.circular(3),
                  child: LinearProgressIndicator(
                    value: sessions.isEmpty ? 0 : avgTajweed / 100,
                    backgroundColor: ItqanColors.charcoal,
                    valueColor: const AlwaysStoppedAnimation(ItqanColors.gold),
                    minHeight: 6,
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
    );
  }
}


