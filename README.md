# ಮುದ್ದುರಾಮನ ಮನಸು — Android App

Flutter Android app for [MuRa Web App](https://hangyoicream.github.io/MuRa-Web-App/)

**Simple Verses, Profound Truths.** — by K. C. Shivappa

---

## Features

- 📖 **20 Kannada Verses** with transliterations and English translations
- 🌙 **Dark Mode** — warm amber tones for night reading  
- ❤️ **Favorites** — save your cherished verses (persisted locally)
- 📂 **Category Filter** — browse by Life, Philosophy, Mind, Courage, Love, Wisdom
- 📄 **Verse Detail** — swipe between verses, toggle English translation
- 📋 **Copy** — copy any verse to clipboard
- 📤 **Share** — share verses to any app
- ℹ️ **About** — author bio and app info

---

## Setup Instructions

### Prerequisites
- Flutter SDK ≥ 3.2.0 ([Install Flutter](https://flutter.dev/docs/get-started/install))
- Android Studio with Android SDK
- Java 8+

### Steps

```bash
# 1. Open terminal in project folder
cd mura_app

# 2. Install dependencies
flutter pub get

# 3. Run on connected Android device / emulator
flutter run

# 4. Build release APK
flutter build apk --release
# Output: build/app/outputs/flutter-apk/app-release.apk
```

---

## Project Structure

```
lib/
├── main.dart               # App entry point
├── data/
│   └── verses.dart         # All 20 Kannada verses data
├── models/
│   └── app_theme.dart      # Light/dark theme config
├── providers/
│   └── app_provider.dart   # State management (dark mode, favorites, category)
├── screens/
│   ├── splash_screen.dart  # Splash with 🪔 diya animation
│   ├── home_screen.dart    # Bottom navigation shell
│   ├── verses_screen.dart  # Main verses list + category filter
│   ├── verse_detail_screen.dart  # Full verse view, swipe navigation
│   ├── favorites_screen.dart     # Saved favorites
│   └── about_screen.dart        # Author info, settings
└── widgets/
    ├── verse_card.dart     # Verse list card widget
    └── category_filter.dart # Horizontal category chips
```

---

## Tech Stack

| Tool | Purpose |
|------|---------|
| Flutter 3.x | UI framework |
| Provider | State management |
| Google Fonts (Tiro Kannada) | Kannada typography |
| SharedPreferences | Persist favorites & dark mode |
| share_plus | Share verses |
| url_launcher | Open web links |

---

## Web App
https://hangyoicream.github.io/MuRa-Web-App/

---

*ಕನ್ನಡಕ್ಕಾಗಿ ವಿನ್ಯಾಸಗೊಳಿಸಲಾಗಿದೆ — Designed for Kannada ❤️*
