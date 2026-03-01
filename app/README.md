# Itqan — إتقان

> **"Perfect your recitation, one ayah at a time."**

A Flutter app for Quran pronunciation practice and memorization with AI-powered scoring.

## MVP Status (Phase 1 — March 2026)

### ✅ What's Working
- **Full app scaffold** — Dark design system with gold Itqan theme
- **Quran data** — Fetches all 114 surahs + ayahs from quran.com API v4 (cached offline via Hive)
- **Mushaf screen** — Browse all surahs, tap to see ayahs with Arabic text + translation
- **Recitation screen** — Arabic text display, word tokens, waveform visualizer, recording controls
- **Results screen** — Animated score ring, breakdown bars (word accuracy / letter / tajweed / fluency), word-by-word color analysis, mistake cards
- **State machine** — Full IDLE → RECORDING → PROCESSING → SCORED → RETRY loop via Riverpod
- **Audio playback** — Tap "Listen" to hear Alafasy's recitation for any ayah
- **Recording** — Records audio (m4a) via `record` package with live timer
- **Design tokens** — Full Itqan color system (void_, obsidian, onyx, gold scale, tajweed colors)
- **Fonts** — NotoNaskhArabic Regular/Medium/Bold embedded

### 🟡 Stubbed / Placeholder
- **Scoring** — MVP uses randomized scores (70-95 range) to test UI flow. Real scoring needs Whisper or Tarteel API integration (Phase 2)
- **Word-level highlighting** — Currently shows idle state; real-time highlighting needs phoneme alignment
- **Progress tracking** — Stats screen is a placeholder
- **Memorization mode** — Not yet implemented

### 🔴 Blockers (Needs Imad's input)
1. **Xcode** — Not fully installed on the Mac mini. Need to install Xcode from App Store + run `sudo xcode-select --switch /Applications/Xcode.app/Contents/Developer`. Required for iOS Simulator and macOS build.
2. **Android SDK** — Not configured. Install Android Studio for Android emulator.
3. **Web** builds successfully (`flutter build web --debug` ✅) — can preview in browser as workaround.

## Setup

### Prerequisites
```bash
flutter doctor  # Check your setup
```

### Run (after Xcode is installed)
```bash
cd ~/Desktop/SaaS/itqan/app
flutter run  # Picks up iOS Simulator or connected device
```

### Run on Web (works now, no Xcode needed)
```bash
flutter run -d chrome
# OR
flutter run -d web-server --web-port 3000
```

## Architecture

```
lib/
├── main.dart                    # Hive init + ProviderScope
├── app.dart                     # MaterialApp + dark theme
├── core/
│   └── theme/                   # Colors, spacing, typography, AppTheme
├── features/
│   ├── home/home_screen.dart    # Landing screen with grid nav
│   ├── mushaf/mushaf_screen.dart  # Surah browser + ayah list
│   ├── quran/                   # Models (Ayah, Word, Surah) + QuranService
│   ├── recitation/              # Core recitation screen + Riverpod controller
│   └── scoring/                 # ScoringService + ResultsScreen
└── shared/widgets/              # ScoreRing, GoldButton
```

## Phase 2 Roadmap
- [ ] Whisper on-device scoring (`whisper.cpp` via FFI)
- [ ] Tarteel API integration as cloud fallback
- [ ] Real-time word highlighting during playback
- [ ] Hifz (memorization) mode
- [ ] Tajweed color coding on text
- [ ] Progress tracking with Hive persistence
- [ ] Notifications / spaced repetition reminders
