import 'package:hive/hive.dart';
import '../../core/constants/app_modes.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
enum TaskStatus {
  @HiveField(0)
  pending,
  @HiveField(1)
  completed,
  @HiveField(2)
  skipped,
}

@HiveType(typeId: 1)
class Task extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  DateTime createdAt;

  @HiveField(3)
  DateTime assignedDay;

  @HiveField(4)
  AppMode mode;

  @HiveField(5)
  bool isFocus;

  @HiveField(6)
  TaskStatus status;

  @HiveField(7)
  DateTime? reminderTime;

  // ✅ NEW (APPEND ONLY)
  @HiveField(8)
  int? reminderId;

  Task({
    required this.id,
    required this.title,
    required this.createdAt,
    required this.assignedDay,
    required this.mode,
    this.isFocus = false,
    this.status = TaskStatus.pending,
    this.reminderTime,
    this.reminderId,
  });
}
