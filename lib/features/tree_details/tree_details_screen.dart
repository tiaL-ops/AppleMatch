import 'package:flutter/material.dart';
import '../../models/tree_model.dart';
import '../../services/notification_service.dart';

class TreeDetailsScreen extends StatelessWidget {
  const TreeDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments;
    final Tree tree = args is Tree
        ? args
        : (throw Exception('TreeDetailsScreen requires a Tree argument'));

    final daysLeft = tree.daysUntilMature;
    final statusText = tree.isMature
        ? '🌳 Mature!'
        : '$daysLeft day${daysLeft == 1 ? '' : 's'} until mature';

    return Scaffold(
      appBar: AppBar(title: Text(tree.name)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Example: show planted date & maturity days
            Text(
              'Planted: ${tree.plantedDate}',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              'Matures in: ${tree.maturityDays} days',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            Text(
              statusText,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: tree.isMature
                  ? null
                  : () async {
                      await NotificationService.scheduleNotification(
                        id: tree.id.hashCode,
                        title: 'Your "${tree.name}" is mature!',
                        body: 'Tap to view your tree details.',
                        scheduledDate: tree.maturityDate,
                      );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Reminder set for ${tree.maturityDate.toLocal().toIso8601String().split("T").first}',
                          ),
                        ),
                      );
                    },
              child: Text(
                tree.isMature ? 'Already Mature' : 'Set Maturity Reminder',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
