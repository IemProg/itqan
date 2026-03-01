import 'package:flutter/material.dart';
import '../../../core/theme/colors.dart';
import '../../../core/theme/spacing.dart';
import '../../../core/theme/typography.dart';
import '../models/score_result.dart';
import '../../tajweed/tajweed_data.dart';

class WordDetailSheet extends StatelessWidget {
  final WordScore word;
  final String? tajweedRule;

  const WordDetailSheet({super.key, required this.word, this.tajweedRule});

  Color _scoreColor(double score) {
    if (score >= 0.85) return ItqanColors.correct;
    if (score >= 0.65) return ItqanColors.gold;
    return ItqanColors.error;
  }

  @override
  Widget build(BuildContext context) {
    final scoreColor = _scoreColor(word.score);
    final pct = '${(word.score * 100).round()}%';
    final letters = word.word.split('');

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: ItqanSpacing.lg, vertical: ItqanSpacing.md),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle
            Center(
              child: Container(
                width: 40, height: 4,
                decoration: BoxDecoration(
                  color: ItqanColors.charcoal,
                  borderRadius: BorderRadius.circular(ItqanRadius.full),
                ),
              ),
            ),
            const SizedBox(height: ItqanSpacing.lg),

            // Arabic word
            Text(
              word.word,
              style: const TextStyle(fontFamily: 'NotoNaskhArabic', fontSize: 42, color: ItqanColors.snow, height: 1.8),
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.center,
            ),

            // Score pill
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: scoreColor.withOpacity(0.15),
                borderRadius: BorderRadius.circular(ItqanRadius.full),
                border: Border.all(color: scoreColor.withOpacity(0.4)),
              ),
              child: Text(pct, style: TextStyle(color: scoreColor, fontSize: 16, fontWeight: FontWeight.w700)),
            ),
            const SizedBox(height: ItqanSpacing.lg),

            // What you said — letter breakdown
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(ItqanSpacing.md),
              decoration: BoxDecoration(
                color: ItqanColors.charcoal, borderRadius: BorderRadius.circular(ItqanRadius.lg),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Letters', style: ItqanTypography.label),
                  const SizedBox(height: ItqanSpacing.sm),
                  Wrap(
                    textDirection: TextDirection.rtl,
                    spacing: 6, runSpacing: 6,
                    children: letters.map((l) => Container(
                      width: 36, height: 36,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: ItqanColors.onyx,
                        borderRadius: BorderRadius.circular(ItqanRadius.sm),
                      ),
                      child: Text(l, style: const TextStyle(fontFamily: 'NotoNaskhArabic', fontSize: 18, color: ItqanColors.snow)),
                    )).toList(),
                  ),
                  if (word.error != null) ...[
                    const SizedBox(height: ItqanSpacing.sm),
                    Text('💡 ${word.error}', style: ItqanTypography.caption.copyWith(color: ItqanColors.warning)),
                  ],
                ],
              ),
            ),
            const SizedBox(height: ItqanSpacing.md),

            // Tajweed note
            if (tajweedRule != null) ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(ItqanSpacing.md),
                decoration: BoxDecoration(
                  color: ItqanColors.charcoal,
                  borderRadius: BorderRadius.circular(ItqanRadius.lg),
                  border: Border(left: BorderSide(color: tajweedColor(tajweedRule!), width: 3)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(tajweedRuleName(tajweedRule!), style: ItqanTypography.label.copyWith(color: tajweedColor(tajweedRule!))),
                    const SizedBox(height: 4),
                    Text(tajweedExplanation(tajweedRule!), style: ItqanTypography.caption),
                  ],
                ),
              ),
              const SizedBox(height: ItqanSpacing.md),
            ],

            // Close button
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: ItqanColors.charcoal),
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                child: const Text('Close', style: TextStyle(color: ItqanColors.mist)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void showWordDetail(BuildContext context, WordScore word, {String? tajweedRule}) {
  showModalBottomSheet(
    context: context,
    backgroundColor: ItqanColors.onyx,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (_) => WordDetailSheet(word: word, tajweedRule: tajweedRule),
  );
}
