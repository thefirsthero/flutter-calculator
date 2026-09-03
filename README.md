# Flutter Calculator

A clean, feature-rich calculator built with Flutter. It uses a Material 3 design with light/dark theme support, live result preview, calculation history, and haptic feedback — and ships to the Google Play Store via automated CI/CD.

## Features

- ✨ Material 3 design with light/dark theme toggle
- 🔢 Basic arithmetic (+, −, ×, ÷) with a working percentage (%) key
- 👁️ Live result preview while typing
- 🕘 Calculation history (tap an entry to reuse it)
- 💾 ANS button to reuse the previous result
- 📳 Haptic feedback and button press animations
- 📱 Responsive, device-agnostic layout that respects system insets
- ⚡ Accurate evaluation with the math_expressions parser

## Screenshots

<!-- Add screenshots here -->

## Tech Stack

- **Flutter** — cross-platform framework
- **ChangeNotifier** — built-in state management (no third-party state library)
- **math_expressions** — mathematical expression parsing and evaluation
- **Fastlane + GitHub Actions** — automated Play Store releases
- **flutter_launcher_icons** — app icon generation

## Requirements

- Flutter 3.47+ / Dart 3+
- Android Studio / VS Code with the Flutter extension
- Android: minimum SDK 24 (Flutter default)
- iOS: macOS + Xcode required (deployment target per Flutter defaults)

## Installation

1. **Clone the repository:**

   ```bash
   git clone <repository-url>
   cd flutter_calculator
   ```

2. **Navigate to the project directory:**

   ```bash
   cd flutter_calculator
   ```

3. **Install dependencies:**

   ```bash
   flutter pub get
   ```

4. **Run the app:**
   ```bash
   flutter run
   ```

## Running on Different Platforms

### Android

```bash
flutter run -d android
```

### iOS (macOS only)

```bash
flutter run -d ios
```

### Web

```bash
flutter run -d chrome
```

### Windows

```bash
flutter run -d windows
```

### Linux

```bash
flutter run -d linux
```

### macOS

```bash
flutter run -d macos
```

## Building for Release

### Android APK

```bash
flutter build apk --release
```

### Android App Bundle (for Play Store)

```bash
flutter build appbundle --release
```

### iOS (requires macOS and Xcode)

```bash
flutter build ios --release
```

## Releasing to Google Play Store

Releases are fully automated with GitHub Actions + Fastlane. Pushing a version tag builds a signed App Bundle and publishes it straight to the **production** track.

### 1. Bump the version

In `pubspec.yaml`, increment the version code (the `+N` part — it must always be higher than the current release):

```yaml
version: 2.0.1+6
```

- `2.0.1` — version name (shown to users)
- `+6` — version code (internal; must increase each release)

### 2. Tag and push

```bash
git tag v2.0.1
git push origin v2.0.1
```

The workflow (`.github/workflows/release.yml`) builds, signs, and uploads to production. Monitor it under **Actions → Publish to Google Play**.

### Manual trigger

To run without creating a tag: **Actions → Publish to Google Play → Run workflow**.

### Rollback / review

- To review before going live, change `release_status: "completed"` to `"draft"` in `android/fastlane/Fastfile`.
- To halt a rollout: **Play Console → Production → Halt rollout**.

### Troubleshooting

- **Version code error** — make sure the `+N` in `pubspec.yaml` is higher than the current release.
- **Signing error** — check the keystore secrets in GitHub: **Settings → Secrets and variables → Actions** (`KEYSTORE_BASE64`, `STORE_PASSWORD`, `KEY_PASSWORD`, `KEY_ALIAS`).
- **Permission error (403)** — grant the Play service account **Admin (all permissions)** in Play Console → Users and permissions.
- **"Target SDK too low"** — bump `targetSdk` in `android/app/build.gradle` (Google raises this minimum each year).

## Project Structure

```
lib/
├── main.dart                      # App entry point
├── app.dart                       # Root widget + controllers
├── controller/
│   ├── calculate_controller.dart  # Calculator state + history (ChangeNotifier)
│   └── theme_controller.dart      # Light/dark mode (ChangeNotifier)
├── models/
│   └── history_entry.dart         # History entry model
├── screens/
│   └── calculator_screen.dart     # Main Material 3 screen
├── theme/
│   └── app_theme.dart             # Material 3 light/dark themes
└── widgets/
    └── calculator_button.dart     # Circular key with ripple + haptics
```

## How It Works

1. **State Management**: Uses Flutter's built-in `ChangeNotifier` — no third-party state library
2. **Expression Parsing**: Uses `math_expressions` to parse and evaluate expressions, with a live preview as you type
3. **Theme System**: Material 3 `ColorScheme` with light/dark themes generated from a seed color
4. **Responsive Layout**: Expanded rows/columns scale the keypad to any screen, and `SafeArea` keeps content clear of system bars

## Key Features Explained

### Basic Operations

- Addition (+)
- Subtraction (−)
- Multiplication (×)
- Division (÷)
- Percentage (%)

### Special Buttons

- **C**: Clear all input and output
- **DEL**: Delete the last character
- **%**: Percentage — `200 + 10%` = `220` (iPhone-style); plain `50%` = `0.5`
- **ANS**: Use the result from the previous calculation
- **=**: Calculate the result

### History & Live Preview

- The running result is shown dimmed above the answer as you type
- Tap the 🕘 icon to view history, tap an entry to reuse it, or clear the list

## Development

### Generating App Icons

The project uses `flutter_launcher_icons` for generating app icons:

```bash
dart run flutter_launcher_icons
```

Make sure to place your app icon at `assets/app_logo.png`

### Code Style

This project follows Flutter's official style guide and uses `flutter_lints` for linting.

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## License

See [LICENSE.md](LICENSE.md) for details.

## Contact

For any queries or support, please open an issue in the repository.

## Acknowledgments

- Built with Flutter
- Mathematical expression parsing by the math_expressions package
