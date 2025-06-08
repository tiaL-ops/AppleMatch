// lib/data/tree_repository.dart

import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/tree_model.dart'; 

class TreeRepository {
  // This function loads, decodes, and returns the list of trees.
  Future<List<Tree>> getTrees() async {
   
    final String jsonString = await rootBundle.loadString('assets/data/apple_trees.json');

    // Decode the JSON string into a List of dynamic objects
    final List<dynamic> jsonList = json.decode(jsonString) as List<dynamic>;

    // Map the list of dynamic objects to a list of Tree objects
    return jsonList.map((jsonItem) => Tree.fromJson(jsonItem as Map<String, dynamic>)).toList();
  }
}