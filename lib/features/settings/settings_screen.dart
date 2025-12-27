import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import '../../services/notification_service.dart';
import '../../data/models/task.dart';
import '../../data/models/day_summary.dart';
import '../../state/theme_provider.dart';
import '../../state/task_provider.dart';
import 'reminder_permission_screen.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  Future<void> _clearAll(BuildContext context, WidgetRef ref) async {
    await NotificationService.cancelAll();

    // Clear tasks from state (updates UI instantly)
    await ref.read(taskProvider.notifier).clearAll();

    // Clear all Hive boxes
    await Hive.box<Task>('tasks').clear();
    await Hive.box<DaySummary>('summaries').clear();
    await Hive.box<String>('modeBox').clear();
    await Hive.box('themeBox').clear();
    await Hive.box('meta').clear();

    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('All data cleared')),
      );
      Navigator.of(context).popUntil((route) => route.isFirst);
    }
  }


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentTheme = ref.watch(themeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 8),
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Text(
              'Theme',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),

          RadioListTile<ThemeMode>(
            title: const Text('System default'),
            value: ThemeMode.system,
            groupValue: currentTheme,
            onChanged: (mode) {
              if (mode != null) {
                ref.read(themeProvider.notifier).setTheme(mode);
              }
            },
          ),

          RadioListTile<ThemeMode>(
            title: const Text('Light'),
            value: ThemeMode.light,
            groupValue: currentTheme,
            onChanged: (mode) {
              if (mode != null) {
                ref.read(themeProvider.notifier).setTheme(mode);
              }
            },
          ),

          RadioListTile<ThemeMode>(
            title: const Text('Dark'),
            value: ThemeMode.dark,
            groupValue: currentTheme,
            onChanged: (mode) {
              if (mode != null) {
                ref.read(themeProvider.notifier).setTheme(mode);
              }
            },
          ),

          const Divider(height: 32),

          ListTile(
            title: const Text('Clear all data'),
            subtitle: const Text('This cannot be undone'),
            trailing: const Icon(Icons.delete, color: Colors.red),
            onTap: () => _clearAll(context, ref),
          ),

          const Divider(height: 32),

          const ListTile(
            title: Text('About Dayly'),
            subtitle: Text(
              'Offline-first daily focus app\n'
              'No accounts • No tracking • No cloud',
            ),
          ),
          ListTile(
           title: const Text('Reminder reliability'),
           subtitle: const Text('Manage reminder permissions'),
           trailing: const Icon(Icons.notifications),
           onTap: () {
           Navigator.push(
             context,
             MaterialPageRoute(
               builder: (_) => ReminderPermissionScreen(),
             ),
           );
         },
        ),

        ],
      ),
    );
  }
}
