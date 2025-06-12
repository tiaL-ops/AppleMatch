
# AppleMatch

Find the right tree to summon the genius in you - **Hackathon Project**

Ever dreamt of becoming the next Newton?

Well, today's your day! We're thrilled to introduce an app that will guide you to the secret locations where some of the biggest ideas of all time originated... apple trees.

> It's scientifically proven that a falling apple to the head sparks genius!

AppleMatch helps you find the perfect apple tree near you.

Swipe to discover trees that match your preferences: girth, length, age—we've got you covered. Swipe and let our magic work, boosting your chances of becoming a genius to 120%!

## Core Features

1.  **Map View**: See all the apple trees around you, complete with important data (age, girth, IQ, etc.).
2.  **View and Swipe Profile**: ;)
3.  **Favorites**: Save your favorite apple trees, just like some parents have a favorite child.
4.  **Mock Tree Dataset**: We've faked the data, much like we fake social media.

---

## Tech Stack:

* Flutter
* Flutter's Google Maps package (for location)
* Flutter's local notifications plugin (for notifications)
* ChatGPT-generated data



## Quick Start

### Prerequisites
- **Flutter SDK**: [Install Flutter](https://docs.flutter.dev/get-started/install)
- **Xcode**: Latest version (for iOS development)
- **CocoaPods**: `brew install cocoapods`

### Setup Instructions

1. **Clone and install dependencies**:
   ```bash
   git clone https://github.com/tiaL-ops/AppleMatch.git
   cd AppleMatch
   flutter pub get
   ```

2. **iOS Setup**:
   ```bash
   cd ios
   pod install
   cd ..
   ```

3. **Run the app**:
   ```bash
   # iOS Simulator
   flutter run
   
   # Physical iPhone (requires Xcode setup)
   flutter run -d <device-id>
   ```

**Note**: Google Maps API key is already configured for this hackathon project!

## Development

### Bundle Identifier
The app uses `com.applematch.newton` as the bundle identifier. For physical device testing, you may need to:
1. Open `ios/Runner.xcworkspace` in Xcode
2. Set up your development team in Signing & Capabilities
3. Trust the developer certificate on your device

### Platform Support
- ✅ iOS (Primary platform)
- ✅ Web (Limited - Maps/Location don't work)
- ✅ macOS (Development testing)

## 🔧 Common Issues

**Flutter framework codesigning errors**: Try building directly in Xcode first, then use `flutter run`

**Permission errors**: Location permissions are required for core functionality

---

**Note**: This app is designed for mobile with location services and Google Maps integration.

## Future Features

Honestly, I need to sit under a tree to think of more.
