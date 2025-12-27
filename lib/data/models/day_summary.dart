import 'package:hive/hive.dart';

part 'day_summary.g.dart';

@HiveType(typeId: 2)
enum DayStatus {
  @HiveField(0)
  complete,
  @HiveField(1)
  partial,
  @HiveField(2)
  skipped,
}

@HiveType(typeId: 3)
class DaySummary extends HiveObject {
  @HiveField(0)
  DateTime date;

  @HiveField(1)
  int totalTasks;

  @HiveField(2)
  int focusTasks;

  @HiveField(3)
  int completedTasks;

  @HiveField(4)
  int skippedTasks;

  @HiveField(5)
  DayStatus status;

  DaySummary({
    required this.date,
    required this.totalTasks,
    required this.focusTasks,
    required this.completedTasks,
    required this.skippedTasks,
    required this.status,
  });
}
