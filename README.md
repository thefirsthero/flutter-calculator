# Flutter Calculator

A beautiful, feature-rich calculator application built with Flutter and GetX state management. This app features a modern neumorphic design with light/dark theme support and has been deployed to the Google Play Store.

## Features

- ✨ Clean and intuitive user interface
- 🌓 Light/Dark theme toggle with neumorphic design
- 🔢 Basic arithmetic operations (Addition, Subtraction, Multiplication, Division)
- 📱 Responsive design (works on phones and tablets)
- 🎨 Custom Google Fonts integration
- 🔒 Portrait mode only for optimal calculator experience
- 💾 ANS button to reuse previous results
- ⚡ Fast and accurate calculations using math expressions parser

## Screenshots

<!-- Add screenshots here -->

## Tech Stack

- **Flutter** - Cross-platform framework
- **GetX** - State management and dependency injection
- **math_expressions** - Mathematical expression parsing and evaluation
- **flutter_neumorphic** - Neumorphic UI components
- **google_fonts** - Custom font integration
- **flutter_advanced_switch** - Theme toggle switch

## Requirements

- Flutter SDK: >=2.17.0 <3.0.0
- Dart SDK: >=2.17.0 <3.0.0
- Android Studio / VS Code with Flutter extensions
- For Android: Minimum SDK version 21
- For iOS: iOS 11.0 or higher

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

This guide walks you through the process of releasing an updated version to the Google Play Store.

### Prerequisites

- Google Play Developer account
- Signing key configured in `android/key.properties`
- App already published on Play Store

### Step 1: Update Version Number

Update the version in `pubspec.yaml`:

```yaml
version: 1.0.1+4 # Format: major.minor.patch+buildNumber
```

Version format explanation:

- **1.0.1** - Version name (shown to users)
- **+4** - Version code (internal, must increment with each release)

### Step 2: Build the Release Bundle

Build the Android App Bundle (AAB) for Play Store:

```bash
flutter build appbundle --release
```

The build output will be located at:

```
build/app/outputs/bundle/release/app-release.aab
```

### Step 3: Test the Release Build (Optional but Recommended)

Build and test the release APK on a physical device:

```bash
# Build release APK
flutter build apk --release

# Install on connected device
adb install build/app/outputs/flutter-apk/app-release.apk
```

### Step 4: Upload to Play Console

1. **Access Play Console**

   - Go to [Google Play Console](https://play.google.com/console)
   - Sign in with your developer account
   - Select "Minimal Calculator" app

2. **Create New Release**

   - Navigate to **Production** (or **Testing** → **Internal testing** for testing first)
   - Click **Create new release**
   - Upload the AAB file from `build/app/outputs/bundle/release/app-release.aab`

3. **Add Release Notes**

   Example release notes:

   ```
   What's New in v1.0.1:
   - Updated to latest Android build system
   - Improved app stability and performance
   - Fixed UI rendering issues
   - Enhanced compatibility with newer Android versions
   - Updated dependencies for better security
   - Bug fixes and performance improvements
   ```

4. **Review Release**

   - Review the release summary
   - Check for any warnings or errors
   - Set rollout percentage:
     - **20-50%** for cautious rollout (monitor for issues)
     - **100%** for full immediate release

5. **Start Rollout**
   - Click **Review release**
   - Click **Start rollout to Production**

### Step 5: Post-Release

- Monitor crash reports and user feedback in Play Console
- Respond to user reviews
- Track app performance metrics
- Plan for next release based on feedback

### Rollback (if needed)

If issues are discovered after release:

1. Go to Play Console → Production
2. Click on the problematic release
3. Select **Halt rollout** or **Create rollback**

### Release Checklist

Before submitting:

- [ ] Version number incremented in `pubspec.yaml`
- [ ] Release notes prepared
- [ ] AAB built successfully without errors
- [ ] Tested release build on physical device
- [ ] Signing configuration verified in `android/key.properties`
- [ ] No debug code or console logs in production
- [ ] Screenshots updated (if UI changed)
- [ ] Store listing updated (if needed)

### Troubleshooting

**Build Fails:**

```bash
# Clean and rebuild
flutter clean
flutter pub get
flutter build appbundle --release
```

**Signing Issues:**
Verify `android/key.properties` contains:

```properties
storePassword=<your-store-password>
keyPassword=<your-key-password>
keyAlias=<your-key-alias>
storeFile=<path-to-keystore.jks>
```

**Version Code Error:**
Ensure the version code (+number) is higher than the previous release.

## Project Structure

```
lib/
├── main.dart                    # App entry point
├── bindings/
│   └── my_bindings.dart        # GetX dependency injection bindings
├── controller/
│   ├── calculate_controller.dart # Calculator logic controller
│   └── theme_controller.dart     # Theme management controller
├── screen/
│   └── main_screen.dart         # Main calculator screen
├── utils/
│   └── colors.dart              # Color definitions
└── widget/
    └── button.dart              # Custom button widget
```

## How It Works

1. **State Management**: Uses GetX for efficient state management and dependency injection
2. **Expression Parsing**: Utilizes `math_expressions` package to parse and evaluate mathematical expressions
3. **Theme System**: Implements custom light/dark theme with neumorphic design patterns
4. **Responsive Layout**: Adapts to different screen sizes with dynamic layouts for phones and tablets

## Key Features Explained

### Basic Operations

- Addition (+)
- Subtraction (-)
- Multiplication (x)
- Division (/)
- Percentage (%)

### Special Buttons

- **C**: Clear all input and output
- **DEL**: Delete last character
- **ANS**: Use the result from the previous calculation
- **=**: Calculate the result

## Development

### Generating App Icons

The project uses `flutter_launcher_icons` for generating app icons:

```bash
flutter pub run flutter_launcher_icons:main
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
- State management by GetX
- Mathematical expression parsing by math_expressions package
