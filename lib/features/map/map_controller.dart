// lib/features/map/map_controller.dart

import 'dart:async';
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

  /// Returns true only if BOTH foreground & background location are granted.
  Future<bool> requestLocationPermission() async {
    // 1️⃣ Foreground (coarse/fine) for Android & "when in use" for iOS
    var status = await Permission.location.status;
    if (status.isDenied) {
      status = await Permission.location.request();
    }
    if (status.isPermanentlyDenied) {
      debugPrint('Location permission permanently denied.');
      return false;
    }
    if (!status.isGranted) {
      debugPrint('Location permission denied.');
      return false;
    }

    // 2️⃣ Background (always) – Android 10+ & iOS
    var bgStatus = await Permission.locationAlways.status;
    if (bgStatus.isDenied) {
      bgStatus = await Permission.locationAlways.request();
    }
    if (bgStatus.isPermanentlyDenied) {
      debugPrint('Background location permission permanently denied.');
      return false;
    }
    if (!bgStatus.isGranted) {
      debugPrint('Background location permission denied.');
      return false;
    }

    return true;
  }

  /// Starts streaming location updates every ~100m
  void startProximityMonitoring() {
    if (_positionStreamSubscription != null) return;

    const settings = LocationSettings(
      accuracy: LocationAccuracy.high,
      distanceFilter: 100,
    );

    _positionStreamSubscription = Geolocator
        .getPositionStream(locationSettings: settings)
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