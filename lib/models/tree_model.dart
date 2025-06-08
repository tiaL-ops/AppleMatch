// lib/models/tree_model.dart

import 'package:flutter/foundation.dart';

@immutable
class Tree {
  final String id;
  final String name;
  final double latitude;
  final double longitude;
  final String plantedDate;
  final int maturityDays;
  DateTime get plantedDateTime => DateTime.parse(plantedDate);

  DateTime get maturityDate => plantedDateTime.add(Duration(days: maturityDays));

  int get daysUntilMature => maturityDate.difference(DateTime.now()).inDays;


  bool get isMature => daysUntilMature <= 0;

  const Tree({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.plantedDate,
    required this.maturityDays,
  });

  // A "factory constructor" that creates a Tree instance from a JSON map.
  factory Tree.fromJson(Map<String, dynamic> json) {
    return Tree(
      id: json['id'] as String,
      name: json['name'] as String,
      latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
      plantedDate: json['planted_date'] as String,
      maturityDays: json['maturity_days'] as int,
    );
  }
}