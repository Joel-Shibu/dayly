import 'package:flutter/material.dart';
import '../../services/reminder_health.dart';

class ReminderPermissionScreen extends StatelessWidget {
  const ReminderPermissionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Enable Reminders')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Important',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              'Android may delay or block reminders to save battery.\n\n'
              'To deliver reminders reliably, Dayly needs permission to:\n'
              '• Use exact alarms\n'
              '• Run without battery restrictions\n\n'
              'Without this, reminders may be late or missed.',
            ),
            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: ReminderHealth.openExactAlarmSettings,
              child: const Text('Allow exact alarms'),
            ),
            const SizedBox(height: 12),

            ElevatedButton(
              onPressed: ReminderHealth.openBatteryOptimizationSettings,
              child: const Text('Disable battery optimization'),
            ),
            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: () async {
                await ReminderHealth.acknowledge();
                if (context.mounted) Navigator.pop(context);
              },
              child: const Text('I understand'),
            ),
          ],
        ),
      ),
    );
  }
}
