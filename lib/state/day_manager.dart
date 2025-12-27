import 'package:hive/hive.dart';
import '../data/models/task.dart';
import '../data/models/day_summary.dart';

class DayManager {
  static const _metaBox = 'meta';
  static const _lastDateKey = 'lastActiveDate';

  static Future<void> handleRollover() async {
    final meta = await Hive.openBox(_metaBox);

    final today = _dateOnly(DateTime.now());
    final last = meta.get(_lastDateKey) as DateTime?;

    if (last == null) {
      await meta.put(_lastDateKey, today);
      return;
    }

    if (last.isBefore(today)) {
      await _closeDay(last);
      await meta.put(_lastDateKey, today);
    }
  }

  static Future<void> _closeDay(DateTime day) async {
    final taskBox = Hive.box<Task>('tasks');
    final summaryBox = Hive.box<DaySummary>('summaries');

    final tasksOfDay = taskBox.values
        .where((t) => _dateOnly(t.assignedDay) == day)
        .toList();

    final focusTasks = tasksOfDay.where((t) => t.isFocus).toList();
    final completedFocus =
        focusTasks.where((t) => t.status == TaskStatus.completed).length;

    DayStatus status;
    if (completedFocus == focusTasks.length && focusTasks.isNotEmpty) {
      status = DayStatus.complete;
    } else if (completedFocus > 0) {
      status = DayStatus.partial;
    } else {
      status = DayStatus.skipped;
    }

    // Roll forward pending tasks
    for (final t in tasksOfDay) {
      if (t.status == TaskStatus.pending) {
        t.assignedDay = _dateOnly(DateTime.now());
        t.isFocus = false;
        await t.save();
      }
    }

    final summary = DaySummary(
      date: day,
      totalTasks: tasksOfDay.length,
      focusTasks: focusTasks.length,
      completedTasks:
          tasksOfDay.where((t) => t.status == TaskStatus.completed).length,
      skippedTasks:
          tasksOfDay.where((t) => t.status == TaskStatus.skipped).length,
      status: status,
    );

    await summaryBox.put(day.toIso8601String(), summary);
    await summaryBox.flush();
  }

  static DateTime _dateOnly(DateTime d) =>
      DateTime(d.year, d.month, d.day);
}
