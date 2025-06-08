import 'package:flutter/material.dart';
import '../../models/tree_model.dart';

class FavoritesScreen extends StatelessWidget {
  final List<Tree> favorites;
  const FavoritesScreen({ Key? key, required this.favorites }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Your Favorites')),
      body: favorites.isEmpty
        ? const Center(child: Text('No favorites yet'))
        : ListView.builder(
            itemCount: favorites.length,
            itemBuilder: (_, i) {
              final tree = favorites[i];
              return ListTile(
                title: Text(tree.name),
                subtitle: Text('Planted: ${tree.plantedDate}'),
              );
            },
          ),
    );
  }
}
