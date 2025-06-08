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

  /// Calculate compatibility score with user preferences (0-100)
  int calculateCompatibility({
    String? preferredZodiac,
    String? preferredBloodType,
    int? preferredMinIQ,
    int? preferredMaxAge,
    bool? preferMature,
  }) {
    int score = 50; // Base compatibility
    
    // Zodiac compatibility
    if (preferredZodiac != null) {
      if (zodiac.toLowerCase() == preferredZodiac.toLowerCase()) {
        score += 20;
      } else if (_isCompatibleZodiac(zodiac, preferredZodiac)) {
        score += 10;
      }
    }
    
    // Blood type compatibility  
    if (preferredBloodType != null) {
      if (bloodtype.toLowerCase().contains(preferredBloodType.toLowerCase())) {
        score += 15;
      }
    }
    
    // IQ preference
    if (preferredMinIQ != null) {
      if (iq >= preferredMinIQ) {
        score += 15;
      } else {
        score -= 10;
      }
    }
    
    // Age preference
    if (preferredMaxAge != null) {
      if (age <= preferredMaxAge) {
        score += 10;
      } else {
        score -= 5;
      }
    }
    
    // Maturity preference
    if (preferMature != null) {
      if (isMature == preferMature) {
        score += 10;
      }
    }
    
    // Bonus for high IQ trees
    if (iq > 140) score += 5;
    if (iq > 120) score += 3;
    
    // Clamp between 0 and 100
    return score.clamp(0, 100);
  }

  bool _isCompatibleZodiac(String zodiac1, String zodiac2) {
    // Simple zodiac compatibility (simplified for demo)
    final compatible = {
      'aries': ['leo', 'sagittarius', 'gemini', 'aquarius'],
      'taurus': ['virgo', 'capricorn', 'cancer', 'pisces'],
      'gemini': ['libra', 'aquarius', 'aries', 'leo'],
      'cancer': ['scorpio', 'pisces', 'taurus', 'virgo'],
      'leo': ['aries', 'sagittarius', 'gemini', 'libra'],
      'virgo': ['taurus', 'capricorn', 'cancer', 'scorpio'],
      'libra': ['gemini', 'aquarius', 'leo', 'sagittarius'],
      'scorpio': ['cancer', 'pisces', 'virgo', 'capricorn'],
      'sagittarius': ['aries', 'leo', 'libra', 'aquarius'],
      'capricorn': ['taurus', 'virgo', 'scorpio', 'pisces'],
      'aquarius': ['gemini', 'libra', 'aries', 'sagittarius'],
      'pisces': ['cancer', 'scorpio', 'taurus', 'capricorn'],
    };
    
    final z1 = zodiac1.toLowerCase();
    final z2 = zodiac2.toLowerCase();
    
    return compatible[z1]?.contains(z2) ?? false;
  }

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
