import 'package:hive/hive.dart';
import '../models/task.dart';
import '../models/day_summary.dart';

class HiveBoxes {
  static Box<Task> taskBox() => Hive.box<Task>('tasks');
  static Box<DaySummary> summaryBox() => Hive.box<DaySummary>('summaries');
}
