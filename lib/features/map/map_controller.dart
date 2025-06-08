// lib/features/map/map_controller.dart

import 'dart:async';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import '../../data/tree_repository.dart';
import '../../models/tree_model.dart';
import '../../services/notification_service.dart';

class MapController {
  final TreeRepository _treeRepository = TreeRepository();
  final NotificationService _notificationService = NotificationService();
  final Set<String> _notifiedTreeIds = {};
  StreamSubscription<Position>? _positionStreamSubscription;

  /// Must be called once (e.g. in initState) to set up local notifications
  Future<void> initialize() async {
    await _notificationService.initialize();
  }

  /// Returns the specific [PermissionStatus] for location.
  Future<PermissionStatus> requestLocationPermission() async {
    // Skip background location on web
    if (kIsWeb) {
      var status = await Permission.location.status;
      if (status.isDenied) {
        status = await Permission.location.request();
      }
      return status;
    }

    // 1. Check foreground permission
    var status = await Permission.location.status;
    if (status.isDenied) {
      status = await Permission.location.request();
    }
    // If permanently denied, return immediately
    if (status.isPermanentlyDenied) {
      debugPrint('Location permission permanently denied.');
      return status;
    }
    // If not granted, return
    if (!status.isGranted) {
      debugPrint('Location permission denied.');
      return status;
    }

    // 2. If foreground is granted, check background permission (iOS/Android only)
    try {
      var bgStatus = await Permission.locationAlways.status;
      if (bgStatus.isDenied) {
        bgStatus = await Permission.locationAlways.request();
      }
      if (bgStatus.isPermanentlyDenied) {
        debugPrint('Background location permission permanently denied.');
      }
      return bgStatus;
    } catch (e) {
      debugPrint('Background location not supported on this platform: $e');
      return status; // Return the foreground permission status
    }
  }

  /// Starts streaming location updates every ~100m
  void startProximityMonitoring() {
    if (_positionStreamSubscription != null) return;

    const settings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );

    _positionStreamSubscription = Geolocator.getPositionStream(
            locationSettings: settings)
        .listen((position) {
      debugPrint('Current user location: $position');
      _checkProximity(position);
    });
  }

  void stopProximityMonitoring() {
    _positionStreamSubscription?.cancel();
    _positionStreamSubscription = null;
  }

  Future<void> _checkProximity(Position userPosition) async {
    final trees = await _treeRepository.getTrees();
    const threshold = 4828.0; // ~3 miles in meters

    for (final tree in trees) {
      final distance = Geolocator.distanceBetween(
        userPosition.latitude,
        userPosition.longitude,
        tree.latitude,
        tree.longitude,
      );
      debugPrint('Distance to ${tree.name}: $distance m');

      if (distance <= threshold && !_notifiedTreeIds.contains(tree.id)) {
        debugPrint('--- Proximity Alert near ${tree.name} ---');
        _notificationService.showProximityAlert(tree);
        _notifiedTreeIds.add(tree.id);
      }
    }
  }
}