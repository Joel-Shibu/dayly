import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../services/reminder_health.dart';
import '../settings/reminder_permission_screen.dart';

import '../../state/task_provider.dart';
import '../../state/mode_provider.dart';
import '../../data/models/task.dart';
import '../../core/constants/app_modes.dart';

class AddTaskSheet extends ConsumerStatefulWidget {
  const AddTaskSheet({super.key});

  @override
  ConsumerState<AddTaskSheet> createState() => _AddTaskSheetState();
}

class _AddTaskSheetState extends ConsumerState<AddTaskSheet> {
  final TextEditingController _controller = TextEditingController();

  bool _hasReminder = false;
  TimeOfDay? _time;

  Future<void> _pickTime() async {
    final picked = await showTimePicker(
      context: context,
      initialTime: _time ?? TimeOfDay.now(),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() => _time = picked);
    }
  }

  Future<void> _save() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    final now = DateTime.now();
    final mode = ref.read(modeProvider);

    final task = Task(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      title: text,
      createdAt: now,
      assignedDay: DateTime(now.year, now.month, now.day),
      mode: mode,
    );

    Navigator.pop(context); // ✅ close sheet first

    final notifier = ref.read(taskProvider.notifier);
    notifier.addTask(task);

    if (_hasReminder && _time != null) {
      DateTime reminderTime = DateTime(
        now.year,
        now.month,
        now.day,
        _time!.hour,
        _time!.minute,
      );

      // 🔴 never schedule past time
      if (reminderTime.isBefore(now)) {
        reminderTime = reminderTime.add(const Duration(days: 1));
      }

      await notifier.setReminder(task, reminderTime);
    }
  }

  @override
  Widget build(BuildContext context) {
    final mode = ref.watch(modeProvider);
    final defaultTime = modeConfigs[mode]!.defaultReminderTime;

    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _controller,
              autofocus: true,
              decoration:
                  const InputDecoration(hintText: 'What do you need to do?'),
            ),
            const SizedBox(height: 12),

           SwitchListTile(
  title: const Text('Add reminder'),
  value: _hasReminder,
  onChanged: (v) async {
    if (v) {
      final ok = await ReminderHealth.isAcknowledged();
      if (!ok && context.mounted) {
        await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const ReminderPermissionScreen(),
          ),
        );
      }
    }

    final acknowledged = await ReminderHealth.isAcknowledged();
    if (!acknowledged) return;

    setState(() {
      _hasReminder = v;
      if (v && _time == null) {
        _time = defaultTime;
      }
    });
  },
),

            if (_hasReminder)
              ListTile(
                title: Text('Reminder at ${_time!.format(context)}'),
                trailing: const Icon(Icons.schedule),
                onTap: _pickTime,
              ),

            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: _save,
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
