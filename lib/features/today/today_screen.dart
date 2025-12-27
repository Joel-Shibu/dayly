import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../state/task_provider.dart';
import '../../state/mode_provider.dart';
import '../../data/models/task.dart';
import '../add_task/add_task_sheet.dart';
import '../mode/mode_selector.dart';
import '../history/history_screen.dart';
import '../settings/settings_screen.dart';

class TodayScreen extends ConsumerWidget {
  const TodayScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(taskProvider.notifier);
    final mode = ref.watch(modeProvider);

    final tasks = ref
        .watch(taskProvider)
        .where((t) => t.status == TaskStatus.pending)
        .toList();

    final focusTasks = tasks.where((t) => t.isFocus).toList();
    final laterTasks = tasks.where((t) => !t.isFocus).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Today • ${mode.name}'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const HistoryScreen(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const SettingsScreen(),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.tune),
            onPressed: () {
              showModalBottomSheet(
                context: context,
                builder: (_) => const ModeSelector(),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (_) => const AddTaskSheet(),
          );
        },
      ),
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: [
          const Text(
            'FOCUS (max 3)',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),

          if (focusTasks.isEmpty)
            const Text('No focus tasks')
          else
            ...focusTasks.map(
              (task) => ListTile(
                leading: const Icon(Icons.star, color: Colors.orange),
                title: Text(
                  task.title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                      ),
                      onPressed: () => notifier.complete(task),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.cancel,
                        color: Colors.red,
                      ),
                      onPressed: () => notifier.skip(task),
                    ),
                    IconButton(
                      icon: const Icon(Icons.arrow_downward),
                      onPressed: () => notifier.demoteFromFocus(task),
                    ),
                  ],
                ),
              ),
            ),

          const SizedBox(height: 24),
          const Text(
            'LATER',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),

          if (laterTasks.isEmpty)
            const Text('No later tasks')
          else
            ...laterTasks.map(
              (task) => ListTile(
                title: Text(task.title),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_upward),
                      onPressed: notifier.canAddFocus()
                          ? () => notifier.promoteToFocus(task)
                          : null,
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.check_circle,
                        color: Colors.green,
                      ),
                      onPressed: () => notifier.complete(task),
                    ),
                    IconButton(
                      icon: const Icon(
                        Icons.cancel,
                        color: Colors.red,
                      ),
                      onPressed: () => notifier.skip(task),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
