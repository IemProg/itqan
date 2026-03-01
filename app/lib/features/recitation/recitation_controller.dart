import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:just_audio/just_audio.dart';
import 'package:record/record.dart';
import 'package:path_provider/path_provider.dart';
import '../quran/models/ayah.dart';
import '../scoring/scoring_service.dart';
import '../scoring/models/score_result.dart';

enum RecitationState { idle, playing, recording, processing, scored }

class RecitationData {
  final RecitationState state;
  final Ayah? ayah;
  final ScoreResult? result;
  final Duration recordingDuration;
  final String? error;

  const RecitationData({
    this.state = RecitationState.idle,
    this.ayah,
    this.result,
    this.recordingDuration = Duration.zero,
    this.error,
  });

  RecitationData copyWith({
    RecitationState? state,
    Ayah? ayah,
    ScoreResult? result,
    Duration? recordingDuration,
    String? error,
  }) {
    return RecitationData(
      state: state ?? this.state,
      ayah: ayah ?? this.ayah,
      result: result ?? this.result,
      recordingDuration: recordingDuration ?? this.recordingDuration,
      error: error,
    );
  }
}

class RecitationController extends StateNotifier<RecitationData> {
  final AudioPlayer _player = AudioPlayer();
  final AudioRecorder _recorder = AudioRecorder();
  final ScoringService _scorer = ScoringService();
  Timer? _recordingTimer;
  String? _currentRecordingPath;

  RecitationController() : super(const RecitationData());

  void loadAyah(Ayah ayah) {
    state = RecitationData(ayah: ayah);
  }

  Future<void> listen() async {
    if (state.ayah == null) return;
    if (state.state == RecitationState.playing) {
      await _player.stop();
      state = state.copyWith(state: RecitationState.idle);
      return;
    }
    try {
      state = state.copyWith(state: RecitationState.playing);
      await _player.setUrl(state.ayah!.audioUrl);
      await _player.play();
      _player.playerStateStream.listen((ps) {
        if (ps.processingState == ProcessingState.completed) {
          if (mounted) state = state.copyWith(state: RecitationState.idle);
        }
      });
    } catch (e) {
      state = state.copyWith(state: RecitationState.idle, error: 'Audio error: $e');
    }
  }

  Future<void> startRecording() async {
    if (state.state != RecitationState.idle) return;
    final hasPermission = await _recorder.hasPermission();
    if (!hasPermission) {
      state = state.copyWith(error: 'Microphone permission denied');
      return;
    }
    final dir = await getTemporaryDirectory();
    _currentRecordingPath = '${dir.path}/recitation_${DateTime.now().millisecondsSinceEpoch}.m4a';

    await _recorder.start(
      const RecordConfig(encoder: AudioEncoder.aacLc, bitRate: 128000),
      path: _currentRecordingPath!,
    );

    state = state.copyWith(state: RecitationState.recording, recordingDuration: Duration.zero);

    _recordingTimer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (mounted) {
        state = state.copyWith(
          recordingDuration: state.recordingDuration + const Duration(seconds: 1),
        );
      }
    });
  }

  Future<void> stopRecording() async {
    if (state.state != RecitationState.recording) return;
    _recordingTimer?.cancel();

    await _recorder.stop();
    state = state.copyWith(state: RecitationState.processing);

    if (state.ayah != null && _currentRecordingPath != null) {
      try {
        final result = await _scorer.scoreRecording(
          audioPath: _currentRecordingPath!,
          ayah: state.ayah!,
        );
        state = state.copyWith(state: RecitationState.scored, result: result);
      } catch (e) {
        state = state.copyWith(state: RecitationState.idle, error: 'Scoring failed: $e');
      }
    }
  }

  void retry() {
    state = RecitationData(ayah: state.ayah);
  }

  @override
  void dispose() {
    _recordingTimer?.cancel();
    _player.dispose();
    _recorder.dispose();
    super.dispose();
  }
}

final recitationProvider = StateNotifierProvider.autoDispose<RecitationController, RecitationData>(
  (ref) => RecitationController(),
);
