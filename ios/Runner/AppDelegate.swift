// newTon/ios/Runner/AppDelegate.swift

import UIKit
import Flutter
import GoogleMaps

@main
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    // Google Maps API key for AppleMatch hackathon project
    GMSServices.provideAPIKey("AIzaSyA-YN2OdH-a7w0ta12NcVIrAtxPPsGCIPs") 

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}