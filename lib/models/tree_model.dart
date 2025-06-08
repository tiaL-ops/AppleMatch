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
  final String zodiac;
  final int age;
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
    required this.zodiac,
    required this.bloodtype,
    required this.length,
    required this.age,
    required this.girth,
    required this.iq,
  });

  /// Creates a Tree instance from a JSON map.
  factory Tree.fromJson(Map<String, dynamic> json) {
    return Tree(
      id: json['id'] as String,
      name: json['name'] as String,
     latitude: json['latitude'] as double,
      longitude: json['longitude'] as double,
      plantedDate: json['planted_date'] as String,
      maturityDays: json['maturity_days'] as int,
      zodiac :json['zodiac'] as String,
      bloodtype: json['bloodtype'] as String,
      length: json['length'] as int,
      age: json['age'] as int,
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
        'zodiac':zodiac,
        'bloodtype': bloodtype,
        'length': length,
        'girth': girth,
        'iq': iq,
      };
}
