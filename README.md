
# AppleMatch 🍎🌳

Find the right tree to summon the genius in you - **Hackathon Project**

## 🚀 Quick Start

### Prerequisites
- **Flutter SDK**: [Install Flutter](https://docs.flutter.dev/get-started/install)
- **Xcode**: Latest version (for iOS development)
- **CocoaPods**: `brew install cocoapods`

### Setup Instructions

1. **Clone and install dependencies**:
   ```bash
   git clone <repository-url>
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

## 📱 Development

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

# AppleMatch
Have you ever wanted to become the next Newton?
AppleMatch match you the perfect tree that can bring the genius out of you.

Swipe to find your fav tree , walk near them, get notified, save favorites, and get reminders when trees have apple that will likely fall on its own so that you can have 120% of chance to become a genius.

# Core Features
Map View: Shows all the apple trees with important metadata (age, type, and how much more mature it is than you).
Swipe View: Stand vy your standarts and follow your tree
Proximity Alerts: Withing 3 miles it will show you all the possible tree that may save you from your useless cs degree
Mock Tree Dataset: We faked the data like we fake social media.
Favorites: you can save your favorites apple tree like some parent have favorite child.
Wise Alerts: It will have alert you when an apple is about to fall for the following week so you can run there
Data storage:For the depth and wise and very scalable aspect of this project we are going to use a very big data structure: array.


# MVP

 - [x] Show map with mock apple trees
 - [x] Tap tree → see metadata (age, maturity)
 - [ ] Proximity alert (within 3 miles)
- [x] Save as favorite
- [x] A page to have the maturity
- [ ] Set reminder for maturity

- [ ] have pages that display question to answer
- [ ] add more data type info the tree
- [ ] matches the top tree for you