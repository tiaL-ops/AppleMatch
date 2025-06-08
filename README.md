# AppleMatch 🍎🌳

Find the right tree for you - **Hackathon Project**

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

## 🤝 Contributing

1. Create a feature branch
2. Make your changes
3. Test on physical device if possible
4. Submit a pull request

---

**Note**: This app is designed for mobile with location services and Google Maps integration.

# Core features
Answer the question , 


# MVP

 - [x] Show map with mock apple trees
 - [x] Tap tree → see metadata (age, maturity)
 - [ ] Proximity alert (within 3 miles)
- [x]Save as favorite
 - [x]A page to have the maturity
- [ ] Set reminder for maturity

- [ ] have pages that display question to answer
- [ ] add more data type info the tree
- [ ] matches the top tree for you