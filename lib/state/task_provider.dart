import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../data/models/task.dart';
import '../data/local/hive_boxes.dart';
import '../services/notification_service.dart';
import '../services/reliable_reminder.dart';

class TaskNotifier extends StateNotifier<List<Task>> {
  TaskNotifier() : super([]) {
    loadTasks();
  }

  // ---------- LOAD ----------
  void loadTasks() {
    final box = HiveBoxes.taskBox();
    state = box.values.toList();
  }

  // ---------- CREATE ----------
  void addTask(Task task) {
    final box = HiveBoxes.taskBox();
    box.add(task);
    box.flush();
    loadTasks();
  }

  // ---------- FOCUS LOGIC (STEP 19) ----------

  bool canAddFocus() {
    return state
            .where(
              (t) => t.isFocus && t.status == TaskStatus.pending,
            )
            .length <
        3;
  }

  void promoteToFocus(Task task) {
    if (!canAddFocus()) return;
    task.isFocus = true;
    task.save();
    loadTasks();
  }

  void demoteFromFocus(Task task) {
    task.isFocus = false;
    task.save();
    loadTasks();
  }

  // ---------- STATUS ACTIONS (STEP 21) ----------

  Future<void> complete(Task task) async {
    task.status = TaskStatus.completed;
    task.isFocus = false;

    if (task.reminderId != null) {
      await NotificationService.cancel(task.reminderId!);
      task.reminderId = null;
    }

    await task.save();
    loadTasks();
  }

  Future<void> skip(Task task) async {
    task.status = TaskStatus.skipped;
    task.isFocus = false;

    if (task.reminderId != null) {
      await NotificationService.cancel(task.reminderId!);
      task.reminderId = null;
    }

    await task.save();
    loadTasks();
  }

  // ---------- REMINDERS ----------

  Future<void> setReminder(Task task, DateTime when) async {
  // Schedule reliable offline reminder via native Android
  await ReliableReminder.schedule(
    title: task.title,
    when: when,
  );

  // Persist reminder info locally
  task.reminderTime = when;
  await task.save();

  // Force UI refresh
  loadTasks();
}


  // ---------- CLEAR ALL ----------

  Future<void> clearAll() async {
    final box = HiveBoxes.taskBox();
    await box.clear();
    state = [];
  }
}

final taskProvider =
    StateNotifierProvider<TaskNotifier, List<Task>>((ref) {
  return TaskNotifier();
});
