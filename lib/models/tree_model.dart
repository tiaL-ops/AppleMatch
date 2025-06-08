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
  final String starsign;
  final String bloodtype;
  final int length;
  final int girth;
  final int iq;

  DateTime get plantedDateTime => DateTime.parse(plantedDate);

  DateTime get maturityDate =>
      plantedDateTime.add(Duration(days: maturityDays));

  int get daysUntilMature =>
      maturityDate.difference(DateTime.now()).inDays;

  bool get isMature => daysUntilMature <= 0;

  const Tree({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.plantedDate,
    required this.maturityDays,
    required this.starsign,
    required this.bloodtype,
    required this.length,
    required this.girth,
    required this.iq,
  });

  /// Creates a Tree instance from a JSON map.
  factory Tree.fromJson(Map<String, dynamic> json) {
    return Tree(
      id: json['id'] as String,
      name: json['name'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      plantedDate: json['planted_date'] as String,
      maturityDays: json['maturity_days'] as int,
      starsign: json['starsign'] as String,
      bloodtype: json['bloodtype'] as String,
      length: json['length'] as int,
      girth: json['girth'] as int,
      iq: json['iq'] as int,
    );
  }

  /// Converts this Tree back into a JSON map.
  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'latitude': latitude,
        'longitude': longitude,
        'planted_date': plantedDate,
        'maturity_days': maturityDays,
        'starsign': starsign,
        'bloodtype': bloodtype,
        'length': length,
        'girth': girth,
        'iq': iq,
      };
}
