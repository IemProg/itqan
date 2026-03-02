import 'package:flutter/material.dart';
import 'package:itqan/l10n/app_localizations.dart';
import '../../core/extensions/context_extensions.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/spacing.dart';
import '../../core/theme/typography.dart';
import '../quran/models/ayah.dart';
import '../scoring/results_screen.dart';
import 'recitation_controller.dart';
import 'widgets/record_button.dart';
import 'widgets/waveform_visualizer.dart';
import 'widgets/word_token.dart';

class RecitationScreen extends ConsumerStatefulWidget {
  final Ayah ayah;
  final String surahName;

  const RecitationScreen({super.key, required this.ayah, required this.surahName});

  @override
  ConsumerState<RecitationScreen> createState() => _RecitationScreenState();
}

class _RecitationScreenState extends ConsumerState<RecitationScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(recitationProvider.notifier).loadAyah(widget.ayah);
    });
  }

  String _formatDuration(Duration d) {
    final m = d.inMinutes.remainder(60).toString().padLeft(1, '0');
    final s = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(recitationProvider);
    final notifier = ref.read(recitationProvider.notifier);
    final isRecording = data.state == RecitationState.recording;
    final isPlaying = data.state == RecitationState.playing;
    final isProcessing = data.state == RecitationState.processing;

    // Navigate to results when scored
    ref.listen(recitationProvider, (prev, next) {
      if (next.state == RecitationState.scored && next.result != null) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ResultsScreen(
              result: next.result!,
              ayah: widget.ayah,
              surahName: widget.surahName,
              onRetry: () {
                notifier.retry();
                Navigator.pop(context);
              },
              onNext: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
          ),
        );
      }
    });

    RecordButtonState btnState = RecordButtonState.idle;
    if (isRecording) btnState = RecordButtonState.recording;
    if (isProcessing) btnState = RecordButtonState.processing;

    return Scaffold(
      backgroundColor: ItqanColors.void_,
      appBar: AppBar(
        backgroundColor: ItqanColors.void_,
        title: Column(
          children: [
            Text(widget.surahName, style: ItqanTypography.label),
            Text('Ayah ${widget.ayah.ayahNumber}', style: ItqanTypography.caption),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: ItqanSpacing.md),
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: ItqanColors.goldShimmer,
              borderRadius: BorderRadius.circular(ItqanRadius.full),
              border: Border.all(color: ItqanColors.goldGlow),
            ),
            child: Text(
              '${widget.ayah.ayahNumber}',
              style: const TextStyle(color: ItqanColors.gold, fontWeight: FontWeight.w700),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(ItqanSpacing.lg),
          child: Column(
            children: [
              // Quran text card
              Expanded(
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(ItqanSpacing.lg),
                  decoration: BoxDecoration(
                    color: ItqanColors.onyx,
                    borderRadius: BorderRadius.circular(ItqanRadius.xl),
                    border: Border.all(color: ItqanColors.goldGlow, width: 1.5),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // Full text
                        Text(
                          widget.ayah.textUthmani,
                          style: ItqanTypography.arabicLarge,
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.rtl,
                        ),
                        const SizedBox(height: ItqanSpacing.lg),
                        // Word tokens
                        if (widget.ayah.words.isNotEmpty)
                          Wrap(
                            alignment: WrapAlignment.center,
                            textDirection: TextDirection.rtl,
                            spacing: ItqanSpacing.xs,
                            runSpacing: ItqanSpacing.xs,
                            children: widget.ayah.words.map((w) {
                              return WordToken(word: w, state: WordState.idle);
                            }).toList(),
                          ),
                        const SizedBox(height: ItqanSpacing.lg),
                        // Translation
                        if (widget.ayah.translation.isNotEmpty)
                          Text(
                            '"${widget.ayah.translation}"',
                            style: ItqanTypography.caption.copyWith(
                              fontStyle: FontStyle.italic,
                            ),
                            textAlign: TextAlign.center,
                          ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: ItqanSpacing.lg),

              // Waveform (visible when recording)
              AnimatedOpacity(
                opacity: isRecording ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 300),
                child: WaveformVisualizer(isActive: isRecording),
              ),

              // Recording timer
              AnimatedOpacity(
                opacity: isRecording ? 1.0 : 0.0,
                duration: const Duration(milliseconds: 300),
                child: Padding(
                  padding: const EdgeInsets.only(top: ItqanSpacing.sm),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.circle, color: ItqanColors.error, size: 10),
                      const SizedBox(width: 6),
                      Text(
                        _formatDuration(data.recordingDuration),
                        style: const TextStyle(
                          color: ItqanColors.error,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              if (data.error != null)
                Padding(
                  padding: const EdgeInsets.only(top: ItqanSpacing.sm),
                  child: Text(data.error!, style: const TextStyle(color: ItqanColors.error)),
                ),

              const SizedBox(height: ItqanSpacing.lg),

              // Controls
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Listen button
                  _ControlButton(
                    icon: isPlaying ? Icons.stop_rounded : Icons.headphones_rounded,
                    label: isPlaying ? AppLocalizations.of(context)!.recitationStop : AppLocalizations.of(context)!.recitationListenFirst,
                    color: isPlaying ? ItqanColors.error : ItqanColors.info,
                    onTap: notifier.listen,
                  ),

                  // Record button
                  RecordButton(
                    state: btnState,
                    onTap: () {
                      if (isRecording) {
                        notifier.stopRecording();
                      } else if (!isProcessing) {
                        notifier.startRecording();
                      }
                    },
                  ),

                  // Retry / skip
                  _ControlButton(
                    icon: Icons.refresh_rounded,
                    label: AppLocalizations.of(context)!.recitationRetry,
                    color: ItqanColors.mist,
                    onTap: notifier.retry,
                  ),
                ],
              ),

              const SizedBox(height: ItqanSpacing.lg),
            ],
          ),
        ),
      ),
    );
  }
}

class _ControlButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  const _ControlButton({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              shape: BoxShape.circle,
              border: Border.all(color: color.withOpacity(0.4)),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(height: 6),
          Text(label, style: ItqanTypography.caption),
        ],
      ),
    );
  }
}
