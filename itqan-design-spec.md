# Itqan — Design & UX Specification
## UI/UX Design System v1.0

> **See the interactive style guide**: Open `itqan-design-system.html` for live color swatches, components, phone mockups, and animations.

---

## 1. Design Philosophy: Sacred Minimalism

Itqan's design language is rooted in one principle: **the Quran text is always the hero**. Every UI element exists to serve the sacred text — never competing, always elevating. We draw from two traditions simultaneously: the reverence and geometric precision of Islamic manuscript art, and the clean restraint of modern luxury product design.

**Four pillars guide every design decision:**

**Reverence** — The Quran occupies the visual center of every screen. UI chrome recedes to the edges. No element should distract from the text during recitation.

**Calm** — Deep breathing room between elements. No visual noise, no competing colors, no cluttered toolbars. The app should feel like entering a quiet study room.

**Precision** — Every pixel is intentional. Spacing follows an 8px grid. Colors have purpose. Animations have meaning. This mirrors the concept of itqan itself — mastery through attention to detail.

**Warmth** — Despite the dark palette, the app should feel inviting and encouraging, never cold or clinical. Gold accents radiate warmth. Feedback is gentle, never judgmental. A wrong pronunciation is a learning moment, not a failure.

---

## 2. Visual Identity

### 2.1 The Name & Mark

"Itqan" (إتقان) means mastery, perfection, or doing something with excellence. The Prophet Muhammad (peace be upon him) said: "Allah loves that when one of you does something, he does it with itqan." This perfectly captures the app's mission.

The logotype uses the Amiri typeface for the Latin wordmark paired with traditional Arabic calligraphy. The mark is intentionally typographic — no icon, no symbol — letting the word itself carry the meaning. A subtle geometric pattern derived from Islamic art can accompany the mark as a background texture, never as the primary identity.

### 2.2 Color System: Ink & Gold

The palette is inspired by illuminated Quran manuscripts — dark ink backgrounds with gold leaf accents.

#### Dark Canvas (Neutral Scale)
The background uses a spectrum of near-black to dark blue-grey, creating depth without pure black (which feels dead on OLED screens).

| Token | Hex | Usage |
|---|---|---|
| Void | `#0A0A0F` | App background, deepest layer |
| Obsidian | `#111118` | Secondary background, bottom nav |
| Onyx | `#1A1A24` | Card backgrounds, elevated surfaces |
| Charcoal | `#252530` | Borders, dividers, track backgrounds |
| Slate | `#3A3A4A` | Disabled states, subtle borders |
| Mist | `#6B6B80` | Tertiary text, captions, timestamps |
| Silver | `#9B9BB0` | Secondary text, body copy |
| Cloud | `#CDCDE0` | Primary-secondary text |
| Snow | `#EEEEF5` | Primary text, high emphasis |
| White | `#FAFAFF` | Maximum emphasis (scores, headings) |

**Why not pure black/white?** Pure `#000000` creates harsh contrast that causes eye strain during long reading sessions. Pure `#FFFFFF` is too bright on OLED. Our scale has a slight blue-violet undertone that feels richer and more calming.

#### Sacred Gold (Primary Accent)
Gold is used sparingly and with purpose — it marks interactive elements, achievements, and the active state. It evokes the tradition of gold leaf in Quran illumination.

| Token | Hex | Usage |
|---|---|---|
| Gold Deep | `#8B6914` | Pressed states, dark accent |
| Gold | `#C9982E` | Primary accent, buttons, active elements |
| Gold Light | `#E8C066` | Gradient end, highlights |
| Gold Glow | `rgba(201,152,46, 0.15)` | Background glow, active word highlight |
| Gold Shimmer | `rgba(201,152,46, 0.08)` | Subtle hover states |

#### Feedback Colors
Pronunciation feedback uses a traffic-light system that's intuitive and accessible.

| Token | Hex | Usage |
|---|---|---|
| Correct | `#34D399` | Correct pronunciation, high scores |
| Warning | `#FBBF24` | Minor issues, tajweed notes |
| Error | `#F87171` | Wrong word/letter, recording state |
| Info | `#60A5FA` | Tips, informational highlights |

Each feedback color has a corresponding `glow` variant at 15% opacity for background highlights.

#### Tajweed Color Coding
Each tajweed rule category gets a distinct color, consistent with existing Quran color-coding standards used in printed tajweed mushafs.

| Rule | Color | Hex |
|---|---|---|
| Idgham | Indigo | `#818CF8` |
| Ikhfa | Purple | `#A78BFA` |
| Iqlab | Pink | `#F472B6` |
| Izhar | Green | `#34D399` |
| Madd | Blue | `#60A5FA` |
| Qalqalah | Yellow | `#FBBF24` |
| Ghunnah | Orange | `#FB923C` |

### 2.3 Light Mode (Phase 2): Parchment & Ink

The dark mode is primary. Light mode will be offered for outdoor use and preference.

| Token | Hex | Usage |
|---|---|---|
| Parchment | `#FDFBF7` | Main background — warm, not sterile white |
| Linen | `#F5F0E8` | Card backgrounds |
| Sand | `#E8E0D4` | Borders, dividers |
| Ink | `#1C1810` | Primary text — warm black, not pure |

Light mode keeps the same gold accent. Tajweed and feedback colors are slightly darkened for contrast on light backgrounds.

---

## 3. Typography

### 3.1 Font Stack

| Role | Font | Fallback | Why |
|---|---|---|---|
| Quran text | KFGQPC Uthmani Hafs | Noto Naskh Arabic | The standard Uthmani script font used in printed Mushafs. Users recognize it instantly. |
| Arabic UI | Noto Naskh Arabic | Amiri | Clean, legible at all sizes, excellent Unicode support for tashkeel. |
| Latin UI | Inter | SF Pro, system sans | Designed for screens, excellent at small sizes, pairs well with Arabic Naskh. |
| Display / Decorative | Amiri | Georgia | Elegant serif that echoes Arabic manuscript traditions for headers and branding. |

### 3.2 Type Scale

#### Latin (Interface)

| Style | Size | Weight | Line Height | Usage |
|---|---|---|---|---|
| Display | 48px | 300 (Light) | 1.2 | Onboarding screens, empty states |
| H1 | 32px | 600 (SemiBold) | 1.3 | Screen titles, score numbers |
| H2 | 24px | 500 (Medium) | 1.4 | Section headers |
| H3 | 18px | 600 (SemiBold) | 1.4 | Card titles |
| Body | 16px | 400 (Regular) | 1.7 | Descriptions, explanations |
| Body Small | 14px | 400 (Regular) | 1.6 | Secondary information |
| Caption | 13px | 400 (Regular) | 1.5 | Timestamps, metadata |
| Overline | 11px | 600, uppercase | 1.0 | Labels, categories, letter-spacing: 2px |

#### Arabic (Quran & UI)

| Style | Size | Weight | Line Height | Usage |
|---|---|---|---|---|
| Quran Display | 42px | 400 | 2.4 | Full ayah display during recitation |
| Quran Reading | 28px | 400 | 2.2 | Mushaf reading mode |
| Arabic UI Large | 24px | 500 | 2.0 | Surah names, prominent Arabic |
| Arabic UI | 20px | 400 | 2.0 | Arabic interface text |
| Arabic Caption | 16px | 400 | 1.8 | Secondary Arabic text |

**Critical rule**: Arabic text always gets at minimum 2.0× line height. Arabic script with tashkeel (diacritical marks) extends significantly above and below the baseline. Anything less than 2.0× causes overlapping diacritics that are illegible and disrespectful to the text.

### 3.3 Typography Rules

- Never truncate Quran text. If it doesn't fit, scroll or resize.
- Quran text is always right-to-left, even in LTR interface contexts.
- Tashkeel must always be visible on Quran text (never stripped).
- Interface text can be bilingual — Arabic label above, English below (or vice versa based on user language).
- No bold weight on Quran text — the script has its own emphasis through diacritics.

---

## 4. Layout & Spacing

### 4.1 Grid System

All spacing uses an **8px base grid**. Component dimensions snap to 4px for precision.

| Token | Value | Usage |
|---|---|---|
| xs | 4px | Icon gaps, inline spacing |
| sm | 8px | Tight component spacing |
| md | 16px | Default padding, margins, screen edges |
| lg | 24px | Card padding, section gaps |
| xl | 32px | Major section spacing |
| 2xl | 48px | Page-level breathing room |
| 3xl | 64px | Hero sections, major separators |

### 4.2 Screen Layout Rules

- **Screen edge padding**: 16px (both sides)
- **Bottom navigation height**: 56px + safe area inset
- **Status bar clearance**: 44px (iOS Dynamic Island), 24px (Android)
- **Minimum touch target**: 44×44px (per Apple HIG) / 48×48dp (per Material)
- **Maximum content width**: 100% on mobile (no internal max-width needed)
- **Card border-radius**: 12–16px (larger for prominent cards)
- **Button border-radius**: 9999px (always pill-shaped)

### 4.3 The Quran Text Zone

When displaying Quran text for recitation, the text occupies a **sacred zone** — a container with special treatment:
- Generous padding (24px horizontal, 20px vertical minimum)
- Subtle gradient background: `linear-gradient(135deg, var(--onyx), rgba(201,152,46, 0.03))`
- 1px border in `var(--charcoal)` with rounded corners (16px)
- Text centered horizontally
- The only interactive elements inside this zone are the words themselves
- No buttons, icons, or UI chrome inside the Quran text zone

---

## 5. Component Library

### 5.1 Buttons

All buttons are pill-shaped (border-radius: 9999px) for a soft, modern feel.

| Variant | Background | Text Color | Usage |
|---|---|---|---|
| Primary | Gold gradient (135deg, Gold → Gold Light) | Void (#0A0A0F) | Primary CTA: "Start Reciting", "Retry" |
| Secondary | Charcoal + 1px Slate border | Snow | Secondary actions: "Listen First", "Skip" |
| Ghost | Transparent + 1px Gold 30% border | Gold | Tertiary: "View Details", "Learn More" |
| Icon | Varies by context | — | Circular, 48px, for play/pause/mic/etc. |

**States**: Hover lifts 1px (translateY) + shadow increase. Pressed darkens 10%. Disabled at 40% opacity.

### 5.2 Cards

Cards are the primary container for grouped information.

| Variant | Background | Border | Usage |
|---|---|---|---|
| Default | Onyx | 1px Charcoal | Surah cards, info cards |
| Gold | Onyx → Gold 5% gradient | 1px Gold 20% | Featured content, today's goal |
| Glass | Onyx 70% + blur(20px) | 1px White 6% | Overlays, floating cards |

Hover: border brightens to Slate, +2px translateY, card shadow appears.

### 5.3 Record Button

The microphone button is the most important interactive element.

**Ready state**: 72px circle, gold gradient, microphone icon in Void color, gold shadow glow.

**Recording state**: 72px circle, solid Error red (#F87171), stop-square icon in white, pulsing red glow animation (1.5s infinite). A subtle radial pulse ring expands outward, reinforcing that recording is active.

**Animation**: Transition between states is 300ms with a slight scale bounce (1.0 → 1.05 → 1.0).

### 5.4 Score Ring

The circular score display is the emotional payoff of each session.

- 140px SVG circle with 8px stroke
- Track: Charcoal
- Fill: Gold, animated from 0 to score value over 1.5s with ease-out
- Center: Score number (36px, bold, white) counts up from 0 simultaneously
- Below: "Overall Score" label in Mist, 11px uppercase

### 5.5 Score Breakdown Bars

Horizontal progress bars showing sub-scores.

- Track height: 6px, Charcoal background, full border-radius
- Fill color varies by score: ≥90 = Correct green, 70-89 = Gold, <70 = Warning yellow
- Label (left): Score name in Silver, 13px
- Value (right): Score number in White, 13px bold
- Fill animates from 0 to value over 1s, staggered by 100ms per bar

### 5.6 Ayah Word Tokens

Individual words in the Quran display are interactive tokens.

| State | Style | When |
|---|---|---|
| Default | White text, no background | Before recitation |
| Active (current) | Gold Light text, Gold Glow background | Currently being recited |
| Upcoming | Slate text (dimmed) | Not yet reached |
| Correct | Correct green text, Correct Glow background | Pronounced correctly |
| Warning | Warning yellow text, Warning Glow background, gold underline | Minor issue (tajweed) |
| Error | Error red text, Error Glow background | Wrong pronunciation |

Tap on any scored word → bottom sheet slides up with phoneme-level detail.

### 5.7 Bottom Navigation

5-tab navigation bar, flush to bottom with safe area inset.

| Tab | Icon | Label |
|---|---|---|
| Home | House | Home |
| Quran | Book | Quran |
| Record | Large gold circle (elevated) | — (no label) |
| Progress | Chart | Progress |
| Settings | Gear | Settings |

The center Record tab is larger (elevated by 8px), gold-filled, serving as the persistent CTA.

Active tab: Gold color. Inactive: Mist color. No background fills on tabs (clean).

### 5.8 Waveform Visualizer

Real-time audio visualization during recording.

- 16 vertical bars, 3px wide, 2px gap
- Color: Gold
- Height animates between 8px–32px based on audio amplitude
- Bars animate with staggered delays (creating wave effect)
- When not recording: static at 8px height, 40% opacity

### 5.9 Activity Heatmap

GitHub-style contribution graph for practice tracking.

- 7-column grid (days of week) × 4 rows (weeks)
- Cell size: equal squares with 3px gap
- Intensity levels: Empty (Charcoal) → L1 (Gold 15%) → L2 (Gold 30%) → L3 (Gold 50%) → L4 (Solid Gold)
- Corner radius: 3px per cell

### 5.10 Streak Badge

Inline pill showing current streak.

- Background: Gold Shimmer
- Border: 1px Gold 25%
- Border-radius: 9999px
- Content: Fire emoji + number + "day streak" in Gold Light

---

## 6. Screen Specifications

### 6.1 Home Screen

The home screen is the user's daily dashboard. It answers three questions immediately:

1. **"What should I do now?"** → Continue card with last ayah
2. **"How am I doing?"** → Today's progress + streak
3. **"What else can I do?"** → Practice mode grid

**Layout (top to bottom):**
- Status bar clearance (44px)
- Greeting: "Assalamu Alaikum" (Mist, 13px) + user name (White, 22px semibold)
- Today's Progress card (Gold variant): Goal fraction (3/5, large), streak badge, progress bar
- "Continue" section: Card with surah name, ayah number, play button
- "Practice" section: 2×2 grid of mode cards (Read, Memorize, Listen, Progress)
- Bottom nav

**Empty state (first launch)**: Replace Continue section with a warm onboarding card: "Let's begin your journey" + "Start with Al-Fatiha" gold button.

### 6.2 Recitation Screen

The most important screen. Everything serves the Quran text and the recording interaction.

**Layout:**
- Compact header: Back arrow (left), Surah name in Gold (center), overflow menu (right)
- Ayah number badge: Small rotated square with number, centered
- Quran Text Zone: Full-width sacred container with ayah text (see 4.3)
- Waveform visualizer: Centered below text zone
- Record button: Large, centered, with state indication
- Recording timer: "● Recording 0:03" in Error red below button
- Control row: Listen / Retry / Next — three circular icon buttons with labels
- Bottom nav

**During recording**: The Quran text words light up one by one in Gold Glow as the user recites, providing real-time visual tracking. Words not yet reached are dimmed to Slate.

**After recording**: Words transition to their feedback colors (green/yellow/red) with a cascade animation, left-to-right (or right-to-left for Arabic), 100ms stagger per word.

### 6.3 Results Screen

The emotional payoff. Score presentation must feel celebratory for high scores and encouraging for low ones.

**Layout:**
- Surah + Ayah reference (centered, Mist)
- Score ring (animated draw-on, see 5.4)
- Score breakdown card with 4-5 bars (Word, Letter, Tajweed, Fluency)
- Mistake detail cards: One per significant mistake, with:
  - Left border color-coded (Warning or Error)
  - Tajweed rule name as overline
  - The Arabic word in large text
  - Explanation in Silver body text
  - "Hear correct" and "My audio" chip buttons
- Action row: "Retry Ayah" (Primary gold) + "Next →" (Secondary)

**Score ≥ 90**: Subtle gold particle/shimmer animation behind the score ring. Congratulatory micro-copy: "Excellent! Ma sha Allah"

**Score 70-89**: Encouraging: "Good progress! Keep practicing"

**Score < 70**: Gentle: "Let's work on this together" — emphasis on specific improvements

### 6.4 Mushaf (Quran Reader) Screen

Full Quran reading experience, mimicking a physical Mushaf.

- Full-screen Quran text with minimal chrome
- Top: Surah name + Juz/Hizb info (fades on scroll)
- Bottom: Page number, audio controls (fade on scroll)
- Swipe left/right for page turning (with subtle page-turn animation)
- Long-press any word → popup with translation, transliteration, tajweed rule
- Tajweed color overlay toggle in top-right

### 6.5 Progress/Analytics Screen

- Weekly summary card: Sessions, total time, average score, streak
- Activity heatmap (4 weeks visible)
- Per-surah mastery chart: Horizontal bars showing mastery % per practiced surah
- Weak spots section: Cards for the 3 most common error patterns, with "Practice this" buttons
- Tajweed mastery radar chart: Pentagon/hexagon showing proficiency per rule category

### 6.6 Settings Screen

Clean list layout with grouped sections:
- **Profile**: Name, level, daily goal
- **Quran Display**: Script (Uthmani/Indo-Pak), font size slider, tajweed colors toggle, translation language
- **Audio**: Default qari selection, playback speed
- **Scoring**: Difficulty level (Beginner/Intermediate/Advanced), score weight customization
- **App**: Theme (Dark/Light/Auto), language, notifications
- **About**: Version, open source info, credits, donate

---

## 7. Animation & Motion Spec

### 7.1 Principles

Motion in Itqan is **calm and purposeful**. No bouncy playfulness — instead, smooth, confident movements that feel premium.

- Prefer ease-out (fast start, gentle stop) for entering elements
- Prefer ease-in (gentle start, fast exit) for leaving elements
- Never use linear easing (feels mechanical)
- Duration scales with distance: small movements are faster, large movements are slower

### 7.2 Easing Curves

| Name | Curve | Usage |
|---|---|---|
| Standard | `cubic-bezier(0.25, 0.46, 0.45, 0.94)` | General transitions |
| Enter | `cubic-bezier(0.0, 0.0, 0.2, 1.0)` | Elements appearing |
| Exit | `cubic-bezier(0.4, 0.0, 1.0, 1.0)` | Elements disappearing |
| Bounce | `cubic-bezier(0.34, 1.56, 0.64, 1)` | Celebrations only |

### 7.3 Duration Scale

| Token | Duration | Usage |
|---|---|---|
| Instant | 100ms | Button press, toggle, checkbox |
| Quick | 200ms | Card hover, word highlight transition |
| Standard | 300ms | Page transitions, bottom sheet slide |
| Slow | 500ms | Score ring draw, counter roll-up |
| Dramatic | 800ms+ | Milestone celebrations, first-time reveals |

### 7.4 Key Animations

**Word Highlight Sweep**: During real-time recitation, the active word highlight moves with a 200ms transition. A subtle gold glow "bleeds" slightly into adjacent words to create a smooth sweep effect rather than a hard jump.

**Score Counter Roll-up**: The score number counts from 0 to final value over 800ms with easing. Each digit rolls independently (like a mechanical counter) for a premium feel.

**Score Ring Draw-on**: The circular progress ring draws clockwise from 12 o'clock position over 1.5s. Starts slow, accelerates, then decelerates at the end.

**Record Button Pulse**: When recording, a concentric ring expands from the button's edge outward, fading from Error red 40% opacity to 0% over 1.5s. Infinite loop. Creates a "breathing" effect.

**Page Turn**: In Mushaf mode, swiping triggers a subtle 3D perspective rotation (5-10°) with a shadow on the turning edge. Duration: 400ms. Respects RTL — pages turn right-to-left.

**Feedback Cascade**: After recitation scoring, word colors transition from neutral to feedback colors in sequence (right-to-left for Arabic text), 80ms stagger per word. Creates a satisfying "reveal" moment.

**Bottom Sheet**: Slides up from bottom with 300ms enter transition. Background dims to Void 50% opacity. Content fades in 100ms after sheet reaches position.

**Milestone Celebration**: When completing a surah or achieving a streak milestone, a subtle gold particle effect rises from the bottom of the screen. Particles are small gold circles (2-4px) with varying opacity and speed. Lasts 2 seconds. Tasteful, not gamified.

---

## 8. Iconography

### 8.1 Style

- **Stroke-based** icons (not filled) for consistency with the minimal aesthetic
- **1.5px stroke weight** at 24px size
- **Rounded caps and joins** for warmth
- **24×24px** default size, 20×20 for compact contexts
- Color inherits from context (Mist for inactive, Gold for active, Snow for emphasis)

### 8.2 Icon Set

Use Lucide Icons (open-source, MIT) as the base set, customized where needed:
- Microphone, Stop, Play, Pause, Skip Forward, Skip Back
- Book, BookOpen, Bookmark
- BarChart3, TrendingUp, Target
- Home, Settings, ChevronLeft, ChevronRight
- Volume2, VolumeX
- Clock, Calendar, Flame (streak)
- CheckCircle, AlertCircle, XCircle
- Eye, EyeOff (for hide/show text in Hifz mode)

### 8.3 Custom Icons Needed
- Sajdah marker
- Rub el Hizb (quarter-hizb marker)
- Bismillah ornament divider
- Ayah end marker (traditional ۝ style)

---

## 9. Accessibility

### 9.1 Color Contrast

All text meets WCAG 2.1 AA standards:
- Snow (#EEEEF5) on Void (#0A0A0F) = 17.6:1 ratio (AAA)
- Silver (#9B9BB0) on Onyx (#1A1A24) = 5.2:1 ratio (AA)
- Gold (#C9982E) on Void (#0A0A0F) = 7.8:1 ratio (AAA)
- Feedback colors on Onyx backgrounds all exceed 4.5:1

### 9.2 VoiceOver / TalkBack

- All Quran text is properly tagged with Arabic language attributes
- Score announcements: "Your overall score is 87 out of 100"
- Feedback states: "Word bismillah, pronounced correctly"
- Recording state: "Recording in progress. Double tap to stop."
- Custom actions for word detail drill-down

### 9.3 Dynamic Type / Font Scaling

- All interface text respects system font size settings
- Quran text has its own independent size slider in settings
- Minimum Quran text size: 20px (even at smallest system setting)
- Layout reflows gracefully at 200% text size

### 9.4 Reduced Motion

When system "Reduce Motion" is enabled:
- Replace all slide/scale transitions with simple fade (200ms)
- Disable waveform animation (show static bars)
- Disable record button pulse (show solid red)
- Disable score roll-up (show final number immediately)
- Disable page turn 3D effect (use simple crossfade)

---

## 10. Design Tokens — Flutter Implementation

```dart
// ── Colors ──
class ItqanColors {
  // Neutral Scale
  static const void_ = Color(0xFF0A0A0F);
  static const obsidian = Color(0xFF111118);
  static const onyx = Color(0xFF1A1A24);
  static const charcoal = Color(0xFF252530);
  static const slate = Color(0xFF3A3A4A);
  static const mist = Color(0xFF6B6B80);
  static const silver = Color(0xFF9B9BB0);
  static const cloud = Color(0xFFCDCDE0);
  static const snow = Color(0xFFEEEEF5);
  static const white = Color(0xFFFAFAFF);

  // Sacred Gold
  static const goldDeep = Color(0xFF8B6914);
  static const gold = Color(0xFFC9982E);
  static const goldLight = Color(0xFFE8C066);
  static const goldGlow = Color(0x26C9982E); // 15%
  static const goldShimmer = Color(0x14C9982E); // 8%

  // Feedback
  static const correct = Color(0xFF34D399);
  static const warning = Color(0xFFFBBF24);
  static const error = Color(0xFFF87171);
  static const info = Color(0xFF60A5FA);

  // Tajweed
  static const tajweedIdgham = Color(0xFF818CF8);
  static const tajweedIkhfa = Color(0xFFA78BFA);
  static const tajweedIqlab = Color(0xFFF472B6);
  static const tajweedIzhar = Color(0xFF34D399);
  static const tajweedMadd = Color(0xFF60A5FA);
  static const tajweedQalqalah = Color(0xFFFBBF24);
  static const tajweedGhunnah = Color(0xFFFB923C);
}

// ── Spacing ──
class ItqanSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;
  static const double xxxl = 64;
}

// ── Border Radius ──
class ItqanRadius {
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 24;
  static const double full = 9999;
}

// ── Animation Durations ──
class ItqanDuration {
  static const instant = Duration(milliseconds: 100);
  static const quick = Duration(milliseconds: 200);
  static const standard = Duration(milliseconds: 300);
  static const slow = Duration(milliseconds: 500);
  static const dramatic = Duration(milliseconds: 800);
}

// ── Animation Curves ──
class ItqanCurves {
  static const standard = Cubic(0.25, 0.46, 0.45, 0.94);
  static const enter = Cubic(0.0, 0.0, 0.2, 1.0);
  static const exit = Cubic(0.4, 0.0, 1.0, 1.0);
  static const bounce = Cubic(0.34, 1.56, 0.64, 1.0);
}
```

---

## 11. Design File Organization

```
design/
├── tokens/
│   ├── colors.dart          # Color definitions
│   ├── typography.dart       # Text styles
│   ├── spacing.dart          # Spacing scale
│   ├── radius.dart           # Border radii
│   └── animations.dart       # Duration + curve constants
├── theme/
│   ├── dark_theme.dart       # Dark mode ThemeData
│   ├── light_theme.dart      # Light mode ThemeData (Phase 2)
│   └── theme_provider.dart   # Theme switching logic
├── components/
│   ├── buttons/
│   ├── cards/
│   ├── score_ring/
│   ├── score_bars/
│   ├── ayah_display/
│   ├── record_button/
│   ├── waveform/
│   ├── bottom_nav/
│   └── heatmap/
├── screens/
│   ├── home/
│   ├── recitation/
│   ├── results/
│   ├── mushaf/
│   ├── progress/
│   └── settings/
└── assets/
    ├── fonts/
    │   ├── KFGQPCUthmanicScriptHAFS.ttf
    │   ├── NotoNaskhArabic-*.ttf
    │   ├── Inter-*.ttf
    │   └── Amiri-*.ttf
    ├── icons/                # Custom SVG icons
    └── patterns/             # Geometric pattern SVGs
```

---

*Document version: 1.0*
*Last updated: March 1, 2026*
*Author: Imad Marouf*
*Companion file: itqan-design-system.html (interactive style guide)*
