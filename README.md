# Dayly

An offline-first daily focus app designed to help you stay productive without distractions.

## Features

- **Offline-First**: Works completely offline with local data storage
- **Daily Focus**: Track and complete daily tasks with focus mode
- **Reliable Reminders**: Native Android alarm integration for dependable notifications
- **No Accounts**: No login required - your data stays on your device
- **No Tracking**: Privacy-focused with no analytics or cloud sync
- **Clean UI**: Minimal Material Design 3 interface

## Tech Stack

- **Flutter**: Cross-platform mobile app framework
- **Riverpod**: State management
- **Hive**: Local NoSQL database for offline storage
- **Native Android**: Reliable reminder system with foreground services

## Getting Started

### Installation

#### Option 1: Download APK (Recommended)

1. Download the latest APK from the [Releases](https://github.com/Joel-Shibu/dayly/releases) page
2. Enable "Install from unknown sources" in your Android settings
3. Install the APK and enjoy the app!

#### Option 2: Build from Source (Developers)

**Prerequisites:**
- Flutter SDK (>= 3.0)
- Android SDK for development
- Physical Android device for testing reminders

**Steps:**
1. Clone the repository:
```bash
git clone https://github.com/Joel-Shibu/dayly.git
cd dayly
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

### Building for Release

```bash
flutter build apk --release
```

The APK will be generated at `build/app/outputs/flutter-apk/app-release.apk`.

## App Architecture

- **Features**: Modular feature-based organization
- **State Management**: Riverpod providers for reactive state
- **Data Models**: Hive-adapted models with code generation
- **Services**: Background notification and reminder handling
- **Native Integration**: Android-specific alarm and notification services

## Privacy & Data

- All data stored locally using Hive database
- No network requests or cloud synchronization
- No user analytics or tracking
- Full control over your data

## License

This project is open source and available under the MIT License.
