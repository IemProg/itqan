import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/colors.dart';
import '../../core/theme/spacing.dart';
import '../../core/theme/typography.dart';
import 'settings_service.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    final s = ref.read(settingsProvider);
    _nameController = TextEditingController(text: s.userName);
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _update(AppSettings s) => ref.read(settingsProvider.notifier).update(s);

  @override
  Widget build(BuildContext context) {
    final s = ref.watch(settingsProvider);

    return Scaffold(
      backgroundColor: ItqanColors.void_,
      appBar: AppBar(
        backgroundColor: ItqanColors.void_,
        title: const Text('Settings', style: ItqanTypography.heading2),
      ),
      body: ListView(
        padding: const EdgeInsets.all(ItqanSpacing.lg),
        children: [
          _sectionTitle('Profile'),
          _card([
            TextField(
              controller: _nameController,
              style: ItqanTypography.body,
              decoration: const InputDecoration(
                labelText: 'Your name',
                labelStyle: TextStyle(color: ItqanColors.mist),
                enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: ItqanColors.charcoal)),
                focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: ItqanColors.gold)),
              ),
              onChanged: (v) => _update(s.copyWith(userName: v)),
            ),
            const SizedBox(height: ItqanSpacing.md),
            const Text('Experience Level', style: ItqanTypography.caption),
            const SizedBox(height: ItqanSpacing.sm),
            _SegmentedPicker(
              options: const ['Beginner', 'Intermediate', 'Advanced'],
              selected: _capitalize(s.level),
              onSelect: (v) => _update(s.copyWith(level: v.toLowerCase())),
            ),
            const SizedBox(height: ItqanSpacing.md),
            const Text('Daily Goal', style: ItqanTypography.caption),
            const SizedBox(height: ItqanSpacing.sm),
            _ChipPicker(
              options: const ['10 min', '20 min', '30 min'],
              selected: '${s.dailyGoalMinutes} min',
              onSelect: (v) => _update(s.copyWith(dailyGoalMinutes: int.parse(v.split(' ')[0]))),
            ),
          ]),
          _sectionTitle('Quran Display'),
          _card([
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Script', style: ItqanTypography.body),
                _SegmentedPicker(
                  options: const ['Uthmani', 'Indo-Pak'],
                  selected: s.quranicScript == 'uthmani' ? 'Uthmani' : 'Indo-Pak',
                  onSelect: (v) => _update(s.copyWith(quranicScript: v == 'Uthmani' ? 'uthmani' : 'indopak')),
                  compact: true,
                ),
              ],
            ),
            const SizedBox(height: ItqanSpacing.lg),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Font Size', style: ItqanTypography.caption),
                Text('${s.fontSize.round()}px', style: ItqanTypography.caption.copyWith(color: ItqanColors.gold)),
              ],
            ),
            Slider(
              value: s.fontSize,
              min: 20, max: 48,
              activeColor: ItqanColors.gold,
              inactiveColor: ItqanColors.charcoal,
              onChanged: (v) => _update(s.copyWith(fontSize: v)),
            ),
            Center(
              child: Text(
                'بِسْمِ اللَّهِ',
                style: TextStyle(fontFamily: 'NotoNaskhArabic', fontSize: s.fontSize, color: ItqanColors.snow, height: 2),
                textDirection: TextDirection.rtl,
              ),
            ),
            const SizedBox(height: ItqanSpacing.md),
            _SwitchRow(
              label: 'Tajweed Color Overlay',
              value: s.tajweedOverlay,
              onChanged: (v) => _update(s.copyWith(tajweedOverlay: v)),
            ),
            const SizedBox(height: ItqanSpacing.sm),
            _DropdownRow(
              label: 'Translation',
              value: s.translationLanguage,
              options: const {'english': 'English', 'french': 'French', 'arabic': 'Arabic Tafsir'},
              onChanged: (v) => _update(s.copyWith(translationLanguage: v)),
            ),
          ]),
          _sectionTitle('Audio'),
          _card([
            _DropdownRow(
              label: 'Default Qari',
              value: s.defaultQari,
              options: const {'alafasy': 'Alafasy', 'abdulbasit': 'Abdul Basit', 'alhusary': 'Al-Husary'},
              onChanged: (v) => _update(s.copyWith(defaultQari: v)),
            ),
            const SizedBox(height: ItqanSpacing.md),
            const Text('Playback Speed', style: ItqanTypography.caption),
            const SizedBox(height: ItqanSpacing.sm),
            _ChipPicker(
              options: const ['0.75×', '1.0×', '1.25×'],
              selected: '${s.playbackSpeed}×',
              onSelect: (v) => _update(s.copyWith(playbackSpeed: double.parse(v.replaceAll('×', '')))),
            ),
          ]),
          _sectionTitle('Scoring'),
          _card([
            const Text('Difficulty', style: ItqanTypography.caption),
            const SizedBox(height: ItqanSpacing.sm),
            _SegmentedPicker(
              options: const ['Beginner', 'Intermediate', 'Advanced'],
              selected: _capitalize(s.scoringDifficulty),
              onSelect: (v) => _update(s.copyWith(scoringDifficulty: v.toLowerCase())),
            ),
            const SizedBox(height: ItqanSpacing.md),
            _ScoringWeightsTable(level: s.scoringDifficulty),
          ]),
          _sectionTitle('App'),
          _card([
            _DropdownRow(
              label: 'Theme',
              value: s.theme,
              options: const {'dark': 'Dark', 'light': 'Light (Soon)', 'system': 'System'},
              onChanged: (v) => _update(s.copyWith(theme: v)),
            ),
            const SizedBox(height: ItqanSpacing.sm),
            _DropdownRow(
              label: 'Language',
              value: s.language,
              options: const {'english': 'English', 'french': 'Français', 'arabic': 'العربية'},
              onChanged: (v) => _update(s.copyWith(language: v)),
            ),
            const SizedBox(height: ItqanSpacing.sm),
            _SwitchRow(
              label: 'Notifications',
              value: s.notifications,
              onChanged: (v) => _update(s.copyWith(notifications: v)),
            ),
          ]),
          _sectionTitle('About'),
          _card([
            const _AboutRow(label: 'Version', value: '1.0.0'),
            const SizedBox(height: ItqanSpacing.sm),
            OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.code, color: ItqanColors.gold, size: 16),
              label: const Text('View source on GitHub', style: TextStyle(color: ItqanColors.gold)),
              style: OutlinedButton.styleFrom(side: const BorderSide(color: ItqanColors.goldGlow)),
            ),
            const SizedBox(height: ItqanSpacing.sm),
            const Text('Open Source — MIT License', style: ItqanTypography.caption),
            const SizedBox(height: ItqanSpacing.xs),
            const Text(
              'Built with Flutter • Quran data: quran.com • Audio: EveryAyah.com',
              style: ItqanTypography.caption,
            ),
          ]),
          const SizedBox(height: ItqanSpacing.xl),
        ],
      ),
    );
  }

  String _capitalize(String s) => s.isEmpty ? s : '${s[0].toUpperCase()}${s.substring(1)}';

  Widget _sectionTitle(String title) => Padding(
    padding: const EdgeInsets.only(top: ItqanSpacing.lg, bottom: ItqanSpacing.sm),
    child: Text(title.toUpperCase(), style: ItqanTypography.label.copyWith(color: ItqanColors.mist, fontSize: 11)),
  );

  Widget _card(List<Widget> children) => Container(
    padding: const EdgeInsets.all(ItqanSpacing.md),
    decoration: BoxDecoration(
      color: ItqanColors.onyx,
      borderRadius: BorderRadius.circular(ItqanRadius.lg),
    ),
    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: children),
  );
}

class _SegmentedPicker extends StatelessWidget {
  final List<String> options;
  final String selected;
  final ValueChanged<String> onSelect;
  final bool compact;

  const _SegmentedPicker({
    required this.options, required this.selected, required this.onSelect, this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: compact ? MainAxisSize.min : MainAxisSize.max,
      children: options.map((o) {
        final active = o == selected;
        return Flexible(
          flex: compact ? 0 : 1,
          child: GestureDetector(
            onTap: () => onSelect(o),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              margin: const EdgeInsets.only(right: 4),
              decoration: BoxDecoration(
                color: active ? ItqanColors.goldShimmer : ItqanColors.charcoal,
                borderRadius: BorderRadius.circular(ItqanRadius.sm),
                border: Border.all(color: active ? ItqanColors.gold : Colors.transparent),
              ),
              child: Text(o, style: TextStyle(
                color: active ? ItqanColors.gold : ItqanColors.mist,
                fontSize: 12, fontWeight: FontWeight.w600,
              )),
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _ChipPicker extends StatelessWidget {
  final List<String> options;
  final String selected;
  final ValueChanged<String> onSelect;
  const _ChipPicker({required this.options, required this.selected, required this.onSelect});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      children: options.map((o) {
        final active = o == selected;
        return ChoiceChip(
          label: Text(o),
          selected: active,
          selectedColor: ItqanColors.goldShimmer,
          backgroundColor: ItqanColors.charcoal,
          labelStyle: TextStyle(color: active ? ItqanColors.gold : ItqanColors.mist, fontSize: 12),
          side: BorderSide(color: active ? ItqanColors.gold : Colors.transparent),
          onSelected: (_) => onSelect(o),
        );
      }).toList(),
    );
  }
}

class _SwitchRow extends StatelessWidget {
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;
  const _SwitchRow({required this.label, required this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(label, style: ItqanTypography.body),
      Switch(value: value, onChanged: onChanged, activeColor: ItqanColors.gold),
    ],
  );
}

class _DropdownRow extends StatelessWidget {
  final String label;
  final String value;
  final Map<String, String> options;
  final ValueChanged<String> onChanged;
  const _DropdownRow({required this.label, required this.value, required this.options, required this.onChanged});

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(label, style: ItqanTypography.body),
      DropdownButton<String>(
        value: value,
        dropdownColor: ItqanColors.onyx,
        style: ItqanTypography.body.copyWith(color: ItqanColors.gold),
        underline: const SizedBox(),
        items: options.entries.map((e) => DropdownMenuItem(value: e.key, child: Text(e.value))).toList(),
        onChanged: (v) { if (v != null) onChanged(v); },
      ),
    ],
  );
}

class _AboutRow extends StatelessWidget {
  final String label;
  final String value;
  const _AboutRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Text(label, style: ItqanTypography.body),
      Text(value, style: ItqanTypography.body.copyWith(color: ItqanColors.mist)),
    ],
  );
}

class _ScoringWeightsTable extends StatelessWidget {
  final String level;
  const _ScoringWeightsTable({required this.level});

  @override
  Widget build(BuildContext context) {
    final weights = switch (level) {
      'intermediate' => {'Word Accuracy': '30%', 'Letter Accuracy': '30%', 'Tajweed': '30%', 'Fluency': '10%'},
      'advanced'     => {'Word Accuracy': '20%', 'Letter Accuracy': '30%', 'Tajweed': '40%', 'Fluency': '10%'},
      _              => {'Word Accuracy': '40%', 'Letter Accuracy': '30%', 'Tajweed': '20%', 'Fluency': '10%'},
    };
    return Column(
      children: weights.entries.map((e) => Padding(
        padding: const EdgeInsets.only(bottom: 4),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(e.key, style: ItqanTypography.caption),
            Text(e.value, style: ItqanTypography.caption.copyWith(color: ItqanColors.gold)),
          ],
        ),
      )).toList(),
    );
  }
}
