# Itqan — Quran Pronunciation & Memorization App
## Product Specification Document v1.0

> **"Itqan" (إتقان)** — Arabic for "mastery" or "perfection", reflecting the app's goal of helping users perfect their Quran recitation.

---

## 1. Executive Summary

Itqan is a **free, open-source** mobile application (iOS & Android) that helps Muslims learn, recite, and memorize the Quran with **AI-powered pronunciation feedback at the phoneme and tajweed level**. Unlike existing apps that detect mistakes only at the word level (like Tarteel), Itqan provides granular feedback on individual letter pronunciation, harakat (diacritics), and tajweed rule compliance — functioning as a virtual Quran teacher available 24/7.

### Why This Matters

Traditional Quran learning requires a qualified teacher (mu'allim/mu'allima) who listens, corrects, and certifies. Access to such teachers is limited by geography, cost, and availability. While apps like Tarteel have made progress, their word-level detection misses the subtle pronunciation errors that matter most in Quranic recitation — confusing emphatic letters (ص vs س), incorrect madd lengths, missing ghunnah, etc. Itqan closes this gap.

### Core Differentiators

| Feature | Tarteel | HifzPath | Quranly | **Itqan** |
|---|---|---|---|---|
| Word-level detection | ✅ (Premium) | ✅ (Basic) | ✅ | ✅ |
| Phoneme-level pronunciation | ❌ | ❌ | ❌ | **✅** |
| Tajweed rule detection | ❌ | ❌ | ❌ | **✅** |
| Free & open source | ❌ | ✅ (PWA) | Partial | **✅** |
| On-device processing | ❌ | ✅ (browser) | ❌ | **✅** |
| Adaptive skill levels | ❌ | ❌ | ❌ | **✅** |
| Native mobile app | ✅ | ❌ (PWA) | ✅ | **✅** |

---

## 2. Target Users & Personas

### Persona 1: The Beginner (Noor)
- **Profile**: Non-Arabic speaker, 25, recently started learning to read Quran
- **Needs**: Letter pronunciation guidance, transliteration, slow-paced practice, basic tajweed introduction
- **Pain point**: No access to a local teacher, embarrassed to recite in front of others
- **Goal**: Read Surah Al-Fatiha correctly within 2 weeks

### Persona 2: The Intermediate Learner (Ahmed)
- **Profile**: Can read Arabic, 30, wants to improve tajweed
- **Needs**: Tajweed rule feedback, pronunciation refinement, comparison with qari recordings
- **Pain point**: Reads fluently but unsure if tajweed is correct
- **Goal**: Recite with proper tajweed for daily prayers

### Persona 3: The Hifz Student (Fatima)
- **Profile**: Memorizing Quran, 18, has a teacher but needs daily solo practice
- **Needs**: Recite-from-memory mode, mistake detection, revision scheduling, progress tracking
- **Pain point**: Teacher available only 2x/week, needs feedback during solo revision
- **Goal**: Complete memorization of Juz 30 with minimal errors

---

## 3. Feature Specification

### 3.1 Core Features (MVP — Phase 1)

#### 3.1.1 Recitation Mode with Real-Time Feedback
- User selects a surah/ayah and recites aloud
- App displays the Quran text (Uthmani script) with word-by-word highlighting as the user recites
- **Three levels of feedback:**
  - 🟢 **Word-level**: Correct/incorrect/skipped word detection (baseline, like Tarteel)
  - 🟡 **Phoneme-level**: Individual letter pronunciation scoring
    - Detects confusion between similar letters (e.g., ح vs ه, ض vs ظ, ص vs س, ق vs ك)
    - Detects missing or incorrect tashkeel (fatha, kasra, damma, sukun, tanween)
    - Detects incorrect letter articulation points (makhaarij)
  - 🔴 **Tajweed-level**: Rule compliance checking
    - Nun sakinah & tanween rules (Idgham, Ikhfa, Iqlab, Izhar)
    - Meem sakinah rules (Idgham Shafawi, Ikhfa Shafawi, Izhar Shafawi)
    - Madd rules (natural madd, connected madd, required madd — length validation)
    - Qalqalah detection
    - Ghunnah detection and duration
    - Lam rules (Lam Shamsiyyah/Qamariyyah)

#### 3.1.2 Pronunciation Score System
Each recitation session produces a multi-dimensional score:

```
Overall Score: 87/100

Breakdown:
├── Word Accuracy:      95/100  (correct words / total words)
├── Letter Accuracy:    85/100  (correct phonemes / total phonemes)
├── Tashkeel Accuracy:  82/100  (correct diacritics / total diacritics)
├── Tajweed Compliance: 78/100  (rules applied correctly / rules encountered)
│   ├── Nun Sakinah:    90/100
│   ├── Madd Rules:     70/100
│   ├── Qalqalah:       75/100
│   └── Ghunnah:        80/100
└── Fluency:            92/100  (pace, pauses, hesitations)
```

**Scoring Algorithm:**
```
overall_score = (
    word_accuracy * 0.25 +
    letter_accuracy * 0.25 +
    tashkeel_accuracy * 0.20 +
    tajweed_compliance * 0.20 +
    fluency_score * 0.10
)
```

Weights are adjustable per skill level:
- **Beginner**: Word accuracy weighted higher (0.40), tajweed lower (0.10)
- **Intermediate**: Balanced weights
- **Advanced**: Tajweed weighted higher (0.30), word accuracy lower (0.15)

#### 3.1.3 Ayah-by-Ayah Practice Mode
- Isolate individual ayahs for focused practice
- Listen to reference qari audio before attempting
- Record, score, compare, and retry
- Visual diff between user's recitation and correct recitation

#### 3.1.4 Quran Mushaf View
- Full Quran text in Uthmani script (Madani or Indo-Pak)
- Ayah-by-ayah audio playback from multiple qaris
- Tajweed color-coding overlay (optional)
- Translation in multiple languages
- Transliteration toggle for beginners

### 3.2 Extended Features (Phase 2)

#### 3.2.1 Memorization (Hifz) Mode
- Recite from memory (text hidden or progressively hidden)
- "Peek" mode — tap to reveal forgotten words
- Spaced repetition scheduling for revision
- Mistake history — track which ayahs/words are consistently problematic
- Daily/weekly revision plans

#### 3.2.2 Adaptive Skill Assessment
- Initial placement test (recite a set of ayahs covering common tajweed scenarios)
- Dynamic difficulty adjustment based on performance
- Personalized practice recommendations
- Skill progression map showing mastery per surah/juz

#### 3.2.3 Learning Modules
- Interactive tajweed lessons with audio examples
- Letter pronunciation drills (makhaarij al-huroof)
- Minimal pair exercises (e.g., ص vs س in context)
- Tajweed rule quizzes

#### 3.2.4 Progress & Analytics Dashboard
- Daily streak tracking
- Heatmap of practice activity
- Per-surah mastery scores
- Tajweed rule mastery breakdown
- Historical score trends
- Weak spots identification

### 3.3 Future Features (Phase 3)

- Community features (leaderboards, study groups)
- Teacher mode (teacher can review student recordings asynchronously)
- Ijazah tracking (certification chain)
- Multiple qira'at support (Hafs, Warsh, etc.)
- Offline mode with on-device inference

---

## 4. Technical Architecture

### 4.1 High-Level Architecture

```
┌──────────────────────────────────────────────────────────┐
│                    Mobile App (Flutter)                    │
│  ┌─────────┐  ┌──────────┐  ┌────────────┐  ┌─────────┐ │
│  │ Mushaf   │  │ Audio    │  │ Recitation │  │Progress │ │
│  │ Viewer   │  │ Player   │  │ Recorder   │  │Tracker  │ │
│  └─────────┘  └──────────┘  └─────┬──────┘  └─────────┘ │
│                                    │                      │
│  ┌─────────────────────────────────▼──────────────────┐  │
│  │           On-Device ML Pipeline                     │  │
│  │  ┌──────────┐  ┌────────────┐  ┌────────────────┐ │  │
│  │  │ Whisper  │  │ Forced     │  │ Tajweed Rule   │ │  │
│  │  │ ASR      │→ │ Alignment  │→ │ Engine         │ │  │
│  │  │ (ONNX)   │  │ Engine     │  │ (Rule-based)   │ │  │
│  │  └──────────┘  └────────────┘  └────────────────┘ │  │
│  └────────────────────────────────────────────────────┘  │
│                                    │                      │
│  ┌─────────────────────────────────▼──────────────────┐  │
│  │           Scoring Engine                            │  │
│  │  Word Score + Phoneme Score + Tajweed Score         │  │
│  └────────────────────────────────────────────────────┘  │
│                                    │                      │
│  ┌─────────────────────────────────▼──────────────────┐  │
│  │           Local Database (SQLite/Hive)              │  │
│  │  User progress, scores, settings, Quran data       │  │
│  └────────────────────────────────────────────────────┘  │
└──────────────────────────────────────────────────────────┘
              │ (Optional sync)
              ▼
┌──────────────────────────────────────────────────────────┐
│              Backend (Optional, Phase 2+)                 │
│  ┌──────────┐  ┌────────────┐  ┌────────────────────┐   │
│  │ Auth     │  │ Cloud      │  │ Community          │   │
│  │ Service  │  │ Sync       │  │ Features           │   │
│  └──────────┘  └────────────┘  └────────────────────┘   │
└──────────────────────────────────────────────────────────┘
```

### 4.2 ML Pipeline — The Core Engine

This is the heart of the app. The pipeline processes audio in 4 stages:

#### Stage 1: Audio Preprocessing
```
Raw Audio (16kHz, mono)
    → Noise reduction (RNNoise or similar)
    → Voice Activity Detection (remove silence)
    → Segmentation (split by ayah boundaries if needed)
    → Normalized audio buffer
```

#### Stage 2: Speech-to-Text with Diacritics (ASR)
- **Model**: Fine-tuned Whisper (base or small) for Quranic Arabic
  - Use `tarteel-ai/whisper-base-ar-quran` as starting point
  - Further fine-tune with diacritic-aware dataset for tashkeel prediction
  - Quantize to INT8 for mobile (ONNX Runtime Mobile or whisper.cpp)
- **Output**: Full Arabic text with tashkeel (e.g., بِسْمِ اللَّهِ الرَّحْمَـٰنِ الرَّحِيمِ)
- **Performance target**: <2s latency per ayah on mid-range phone, WER <6%

#### Stage 3: Forced Alignment & Phoneme Comparison
- **Forced alignment** maps the audio to the known correct text at the word and phoneme level
  - Use CTC-based forced alignment (from Whisper's attention weights or a separate model)
  - Libraries: `torchaudio.functional.forced_align` or Montreal Forced Aligner (adapted)
- **Phoneme comparison**:
  - Convert both the user's transcription and the correct text to phoneme sequences using Buckwalter transliteration or IPA mapping
  - Run edit distance (Levenshtein) at the phoneme level
  - Classify errors: substitution (wrong letter), deletion (missing letter), insertion (extra letter)
  - Map to specific makhaarij errors (e.g., "you said /s/ but should be /sˤ/ (ص)")

#### Stage 4: Tajweed Rule Engine
- **Rule-based system** operating on the aligned phoneme sequence + timing data
- Each tajweed rule is a detector function:

```python
# Pseudocode for tajweed rule detection
class TajweedEngine:
    def detect_idgham(self, phoneme_sequence, timing):
        """Detect if noon sakinah/tanween followed by يرملون
        letters is properly merged."""
        # Find noon sakinah positions
        # Check if next letter is in {ي, ر, م, ل, و, ن}
        # Verify merger in audio (no gap, ghunnah if applicable)
        # Return: rule_found, correctly_applied, confidence

    def detect_madd(self, phoneme_sequence, timing):
        """Detect madd rules and validate elongation duration."""
        # Find madd letter (ا, و, ي) positions
        # Classify madd type (tabee'i = 2 counts, muttasil = 4-5, etc.)
        # Measure actual duration from timing data
        # Compare to required duration
        # Return: rule_found, duration_correct, actual_vs_expected

    def detect_qalqalah(self, phoneme_sequence, timing):
        """Detect qalqalah on قطب جد letters when sakin."""
        # ...

    # ... more rule detectors
```

- Rules are composable and extensible — community can contribute new rule detectors
- Confidence thresholds prevent false positives (only flag when >80% confident of error)

### 4.3 Tech Stack

| Component | Technology | Rationale |
|---|---|---|
| **Mobile Framework** | Flutter (Dart) | Single codebase for iOS & Android, great performance, strong community, rich UI toolkit |
| **ML Inference** | ONNX Runtime Mobile / whisper.cpp | On-device inference, no server needed, privacy-preserving |
| **ASR Model** | Whisper (base/small) fine-tuned | Best open-source ASR, Quran-specific fine-tunes available |
| **Audio Processing** | flutter_sound + custom native plugins | Recording, playback, audio feature extraction |
| **Forced Alignment** | Custom CTC alignment (Dart/C++) | Map audio to text at word/phoneme level |
| **Tajweed Engine** | Dart (rule-based) | Deterministic, fast, explainable, no ML needed |
| **Local Database** | Hive or Isar (Flutter) | Fast, lightweight, no SQL overhead, offline-first |
| **Quran Data** | Tanzil.net dataset + quran.com API | Complete Quran text with tashkeel, translations, audio |
| **State Management** | Riverpod or BLoC | Scalable, testable state management |
| **CI/CD** | GitHub Actions | Automated builds, tests, releases |
| **Backend (Phase 2)** | Supabase (open source) | Auth, sync, storage — all open source |

### 4.4 On-Device vs Cloud Processing

**Phase 1: 100% On-Device**
- Whisper base model quantized to INT8: ~40MB
- All processing local — zero server costs
- Works offline
- Full privacy (voice never leaves device)

**Phase 2: Optional Cloud for Heavy Models**
- Whisper medium/large for higher accuracy (too big for mobile)
- User can opt-in to cloud processing for better results
- Self-hostable backend (Docker) so community can run their own

### 4.5 Model Size & Performance Estimates

| Model | Size (INT8) | Latency (per ayah) | WER | Device |
|---|---|---|---|---|
| Whisper tiny | ~15MB | ~0.5s | ~12% | Low-end phones |
| Whisper base | ~40MB | ~1.2s | ~6% | Mid-range phones |
| Whisper small | ~120MB | ~3s | ~4% | Flagship phones |
| Whisper medium | ~400MB | Cloud only | ~3% | Server |

Recommended default: **Whisper base** (best balance of size/accuracy/speed)

---

## 5. Data Requirements

### 5.1 Quran Text Data
- **Source**: Tanzil.net (freely available, multiple editions)
- **Format**: XML/JSON with full tashkeel, ayah boundaries, page/juz/hizb metadata
- **Scripts**: Uthmani (Madani), Indo-Pak (optional)
- **License**: Public domain (Quran text is not copyrightable)

### 5.2 Reference Audio
- **Source**: quran.ksu.edu.sa, everyayah.com
- **Qaris**: Mishari Rashid al-Afasy, Abdul Basit, Al-Husary (multiple styles)
- **Format**: MP3/OGG, per-ayah segmented
- **License**: Freely distributable for Quran learning

### 5.3 Training Data for ML Model
- **Existing datasets**:
  - Tarteel dataset (if publicly available portions)
  - Common Voice Arabic subset
  - quran.ksu.edu.sa — 446K ayah recordings from multiple reciters
  - ARBML datasets catalogue (500+ Arabic speech datasets)
- **Custom data collection** (Phase 2):
  - Record volunteers at various skill levels
  - Annotate with phoneme-level error labels
  - Build tajweed-annotated dataset
  - This is the hardest part — consider partnering with Islamic universities

### 5.4 Phoneme Inventory
The app needs a complete phoneme inventory for Quranic Arabic:

```
Consonants (28 base + variants):
  ء ب ت ث ج ح خ د ذ ر ز س ش ص ض ط ظ ع غ ف ق ك ل م ن ه و ي

Vowels (short):
  َ  (fatha /a/)
  ِ  (kasra /i/)
  ُ  (damma /u/)

Vowels (long):
  ا  (alif madd /aː/)
  و  (waw madd /uː/)
  ي  (ya madd /iː/)

Tanween:
  ً  (fathatayn /an/)
  ٍ  (kasratayn /in/)
  ٌ  (dammatayn /un/)

Special:
  ّ  (shadda — gemination)
  ْ  (sukun — no vowel)
  ٰ  (dagger alif)
```

---

## 6. Scoring System — Deep Dive

### 6.1 Word Accuracy Score
```
Method: Sequence alignment between ASR output and ground truth
Algorithm: Levenshtein distance at word level
Score: (1 - (substitutions + deletions + insertions) / total_words) × 100

Example:
  Ground truth: بِسْمِ اللَّهِ الرَّحْمَـٰنِ الرَّحِيمِ
  User recited: بِسْمِ اللَّهِ الرَّحِيمِ   (skipped الرَّحْمَـٰنِ)
  Score: (1 - 1/4) × 100 = 75
```

### 6.2 Phoneme Accuracy Score
```
Method: Forced alignment → phoneme sequence extraction → comparison
Algorithm: Phoneme-level edit distance with confusion matrix weighting

Confusion weights (0-1, higher = more severe):
  ص↔س: 0.9  (common, important distinction)
  ح↔ه: 0.8  (common confusion for non-Arabic speakers)
  ض↔ظ: 0.7  (historically merged in some dialects)
  ق↔ك: 0.8  (critical in Quranic Arabic)
  ع↔ء: 0.9  (very common for non-native speakers)
  ث↔س: 0.6  (less critical)

Score: weighted_correct_phonemes / total_phonemes × 100
```

### 6.3 Tajweed Compliance Score
```
Method: Rule detector scans aligned output for applicable rules

For each tajweed rule instance found:
  - Was the rule correctly applied? (+1 correct)
  - Was the rule violated? (+1 violation)
  - Was it ambiguous? (skip, don't penalize)

Score: correct_applications / (correct + violations) × 100

Breakdown by rule category:
  - Nun Sakinah & Tanween: X/100
  - Meem Sakinah: X/100
  - Madd (elongation): X/100
  - Qalqalah: X/100
  - Ghunnah: X/100
  - Other: X/100
```

### 6.4 Fluency Score
```
Factors:
  - Pace: words-per-minute vs reference qari (within acceptable range)
  - Pauses: appropriate waqf (stopping) vs hesitation pauses
  - Consistency: steady pace without sudden speedups/slowdowns

Score: composite of pace, pause, and consistency sub-scores
```

### 6.5 Adaptive Scoring Profiles

| Metric | Beginner Weight | Intermediate Weight | Advanced Weight |
|---|---|---|---|
| Word Accuracy | 0.40 | 0.25 | 0.15 |
| Phoneme Accuracy | 0.25 | 0.25 | 0.25 |
| Tashkeel Accuracy | 0.15 | 0.20 | 0.20 |
| Tajweed Compliance | 0.10 | 0.20 | 0.30 |
| Fluency | 0.10 | 0.10 | 0.10 |

---

## 7. User Experience Flow

### 7.1 Onboarding
```
1. Welcome screen → Language selection
2. "What's your experience level?"
   → Beginner / Intermediate / Advanced
3. Placement test (optional):
   → Recite Al-Fatiha
   → App scores and suggests level
4. Set goals:
   → "I want to read correctly" / "I want to memorize" / "Both"
5. Daily practice target: 10/20/30 minutes
```

### 7.2 Main Practice Flow
```
1. Select Surah/Ayah (or continue from last session)
2. Choose mode:
   a. "Listen First" — hear reference qari
   b. "Read Along" — text visible, recite with highlighting
   c. "From Memory" — text hidden, recite from memory
3. Tap record → Recite → Tap stop (or auto-detect silence)
4. Results screen:
   a. Overall score (large, prominent)
   b. Text with color-coded highlights:
      - Green = correct
      - Yellow = minor issues (tashkeel, tajweed)
      - Red = wrong word/letter
   c. Tap any word → detailed phoneme breakdown
   d. Tap any tajweed highlight → rule explanation + correct audio
5. "Retry" / "Next Ayah" / "Review Mistakes"
```

### 7.3 Mistake Review Flow
```
1. Tap highlighted word
2. See side-by-side:
   - What you said (with phoneme transcription)
   - What is correct (with phoneme transcription)
   - Audio comparison (your recording vs qari)
3. For tajweed errors:
   - Rule name and explanation
   - Visual diagram of articulation point
   - Practice drill for that specific rule
4. Add to "weak spots" for targeted practice
```

---

## 8. Development Roadmap

### Phase 1: MVP (3-4 months)
**Goal**: Core recitation with word-level + basic phoneme feedback

| Week | Milestone |
|---|---|
| 1-2 | Project setup, Flutter scaffold, Quran data integration |
| 3-4 | Mushaf viewer with ayah audio playback |
| 5-6 | Audio recording pipeline + Whisper integration (ONNX) |
| 7-8 | Word-level alignment and scoring |
| 9-10 | Basic phoneme comparison engine |
| 11-12 | Scoring UI, results screen, basic progress tracking |
| 13-14 | Testing, polish, beta release |

**MVP Deliverables:**
- Read Quran with audio
- Record recitation
- Get word-level + basic phoneme feedback
- See scores and highlighted mistakes
- Works offline

### Phase 2: Tajweed Engine (2-3 months)
- Implement tajweed rule detectors (start with 5 most common rules)
- Tajweed-highlighted Quran view
- Rule-specific practice drills
- Adaptive skill level system
- Progress analytics dashboard

### Phase 3: Memorization & Community (2-3 months)
- Hifz mode with hidden text
- Spaced repetition scheduling
- Mistake history and weak spot analysis
- Cloud sync (optional, Supabase)
- Teacher/student mode

### Phase 4: Polish & Scale (ongoing)
- More tajweed rules
- Multiple qira'at
- Community contributions
- Model improvements with user data (opt-in, anonymized)
- Localization (UI in 20+ languages)

---

## 9. Open Source Strategy

### 9.1 License
- **App code**: MIT License (maximum permissibility)
- **ML models**: Apache 2.0 (standard for ML)
- **Quran data**: Public domain
- **Audio assets**: CC-BY or as per source license

### 9.2 Repository Structure
```
itqan/
├── app/                      # Flutter mobile app
│   ├── lib/
│   │   ├── core/             # Shared utilities, theme, localization
│   │   ├── features/
│   │   │   ├── mushaf/       # Quran viewer
│   │   │   ├── recitation/   # Recording & playback
│   │   │   ├── scoring/      # Score calculation & display
│   │   │   ├── tajweed/      # Tajweed engine & UI
│   │   │   ├── hifz/         # Memorization mode
│   │   │   └── progress/     # Analytics & tracking
│   │   └── ml/               # ML pipeline interface
│   └── assets/               # Quran data, audio, fonts
├── ml/                       # ML models & training scripts
│   ├── whisper-finetune/     # Whisper fine-tuning code
│   ├── alignment/            # Forced alignment module
│   ├── phoneme/              # Phoneme comparison engine
│   └── models/               # Pre-trained model weights
├── tajweed-engine/           # Standalone tajweed rule library
│   ├── rules/                # Individual rule implementations
│   └── tests/                # Rule-specific test cases
├── data/                     # Data processing scripts
│   ├── quran-text/           # Quran text processing
│   ├── audio/                # Audio dataset scripts
│   └── phoneme-maps/         # Letter-to-phoneme mappings
├── docs/                     # Documentation
├── .github/                  # CI/CD workflows
└── README.md
```

### 9.3 Contribution Model
- **Code contributions**: Standard GitHub PR workflow
- **Tajweed rule contributions**: Template for adding new rules with test cases
- **Translation contributions**: Crowdsourced via Weblate or similar
- **Audio contributions**: Volunteers record recitations at various skill levels
- **Scholarly review**: Islamic scholars verify tajweed rule implementations

### 9.4 Funding Model (100% Free)
- **No ads, no subscriptions, no in-app purchases**
- Revenue/sustainability options:
  - Islamic endowments (waqf) and charitable donations
  - Open Collective or GitHub Sponsors
  - Grants from Islamic foundations
  - Partnership with Islamic universities
  - Sadaqah Jariyah (ongoing charity) framing for individual donors

---

## 10. Technical Risks & Mitigations

| Risk | Severity | Mitigation |
|---|---|---|
| Phoneme-level detection accuracy too low | High | Start with word-level (proven), incrementally add phoneme detection. Use confidence thresholds to avoid false positives. |
| Whisper model too large for mobile | Medium | Use Whisper tiny/base with INT8 quantization. whisper.cpp achieves <1s on iPhone 13. Offer cloud fallback. |
| Tajweed rules too complex to automate | Medium | Start with 5 most common rules. Rule-based (not ML) means easier to debug and validate with scholars. |
| Training data scarcity for phoneme errors | High | Partner with Islamic universities for annotated data. Use data augmentation (pitch shift, speed change, noise). Collect opt-in user recordings. |
| Flutter audio recording quality varies | Medium | Use platform-native recording via method channels. Test extensively on low-end devices. |
| On-device inference drains battery | Medium | Process only during active recitation. Use efficient quantized models. Batch processing where possible. |
| Scholarly accuracy concerns | High | Advisory board of qualified Quran teachers. Published methodology. Community review process. Version tajweed rules. |

---

## 11. Success Metrics

### User Metrics
- **DAU/MAU ratio** > 30% (strong daily engagement)
- **Average session length** > 10 minutes
- **7-day retention** > 40%
- **30-day retention** > 20%

### Quality Metrics
- **Word-level accuracy** > 95% (vs human annotation)
- **Phoneme detection precision** > 85% (minimize false positives)
- **Phoneme detection recall** > 75% (catch most real errors)
- **Tajweed rule detection accuracy** > 80%
- **User satisfaction score** > 4.5/5

### Community Metrics
- **GitHub stars** > 1,000 in first year
- **Contributors** > 20 active contributors
- **Translations** > 10 languages

---

## 12. Getting Started — Developer Quick Start

### Prerequisites
- Flutter SDK 3.x+
- Python 3.10+ (for ML scripts)
- Xcode (iOS) / Android Studio (Android)
- ~2GB disk space for models and data

### First Steps
```bash
# Clone the repo
git clone https://github.com/[your-username]/itqan.git
cd itqan

# Setup Flutter app
cd app
flutter pub get
flutter run

# Setup ML environment
cd ../ml
python -m venv venv
source venv/bin/activate
pip install -r requirements.txt

# Download pre-trained model
python scripts/download_model.py --model whisper-base-ar-quran

# Run tests
cd ../app
flutter test
cd ../tajweed-engine
dart test
```

---

## Appendix A: Tajweed Rules Reference

| Rule | Arabic Name | When It Applies | What to Detect |
|---|---|---|---|
| Clear pronunciation | إظهار | Noon sakinah/tanween + throat letters | No merging occurs |
| Merging | إدغام | Noon sakinah/tanween + يرملون | Letters merge with/without ghunnah |
| Conversion | إقلاب | Noon sakinah/tanween + ب | Noon becomes meem sound |
| Hiding | إخفاء | Noon sakinah/tanween + remaining letters | Partial hiding with ghunnah |
| Natural elongation | مد طبيعي | Madd letter with no cause | Exactly 2 counts |
| Connected elongation | مد متصل | Madd letter + hamza in same word | 4-5 counts |
| Separated elongation | مد منفصل | Madd letter + hamza in next word | 4-5 counts (Hafs) |
| Bouncing | قلقلة | قطب جد letters with sukun | Slight bounce/echo |
| Nasalization | غنة | Noon/meem with shadda | 2-count nasal sound |

## Appendix B: Competitive Analysis Summary

| App | Downloads | Pricing | Word Detection | Phoneme Detection | Tajweed | Open Source |
|---|---|---|---|---|---|---|
| Tarteel | 10M+ | Freemium ($9.99/mo) | ✅ (Premium) | ❌ | ❌ | Partial (model only) |
| HifzPath | ~10K | Free | ✅ (Basic) | ❌ | ❌ | ✅ (PWA) |
| Quranly | ~100K | Free | ✅ | ❌ | ❌ | ❌ |
| Huffaz | ~50K | Freemium | ✅ | ❌ | ❌ | ❌ |
| Quran Tutor | ~1M | Free + Ads | ✅ | Partial | Partial | ❌ |
| **Itqan** | — | **Free** | **✅** | **✅** | **✅** | **✅** |

---

*Document version: 1.0*
*Last updated: March 1, 2026*
*Author: Imad Marouf*
