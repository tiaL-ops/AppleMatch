// lib/widgets/tree_card.dart

import 'package:flutter/material.dart';
import '../models/tree_model.dart';

class TreeCard extends StatelessWidget {
  final Tree tree;

  const TreeCard({Key? key, required this.tree}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              tree.name,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('Planted: ${tree.plantedDate}'),
            const SizedBox(height: 4),
            Text('Maturity: ${tree.maturityDays} days'),
          ],
        ),
      ),
    );
  }
}