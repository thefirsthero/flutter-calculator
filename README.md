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
