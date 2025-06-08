// lib/features/maturity/upcoming_maturity_page.dart

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../data/tree_repository.dart';
import '../../models/tree_model.dart';

class UpcomingMaturityPage extends StatefulWidget {
  const UpcomingMaturityPage({Key? key}) : super(key: key);

  @override
  State<UpcomingMaturityPage> createState() => _UpcomingMaturityPageState();
}

class _UpcomingMaturityPageState extends State<UpcomingMaturityPage> {
  final TreeRepository _repo = TreeRepository();
  late Future<List<Tree>> _futureTrees;

  @override
  void initState() {
    super.initState();
    _futureTrees = _loadUpcoming();
  }

  Future<List<Tree>> _loadUpcoming() async {
    final allTrees = await _repo.getTrees();
    final upcoming = allTrees
        .where((t) => !t.isMature)
        .toList()
      ..sort((a, b) => a.maturityDate.compareTo(b.maturityDate));
    return upcoming;
  }

  String _formatDate(DateTime date) => DateFormat.yMMMd().format(date);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Soon to Mature'),
      ),
      body: FutureBuilder<List<Tree>>(
        future: _futureTrees,
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final trees = snapshot.data ?? <Tree>[];
          if (trees.isEmpty) {
            return const Center(child: Text('No trees approaching maturity.'));
          }
          return ListView.builder(
            itemCount: trees.length,
            itemBuilder: (context, index) {
              final tree = trees[index];
              final days = tree.daysUntilMature;
              final dueDate = _formatDate(tree.maturityDate);
              final subtitle = days > 0
                  ? '$days days until maturity (on $dueDate)'
                  : 'Matures today!';
              return ListTile(
                title: Text(tree.name),
                subtitle: Text(subtitle),
                onTap: () {
                  Navigator.of(context).pop();
                },
              );
            },
          );
        },
      ),
    );
  }
}
