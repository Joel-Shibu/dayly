import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'app.dart';
import 'data/models/task.dart';
import 'data/models/day_summary.dart';
import 'core/constants/app_modes.dart';
import 'state/day_manager.dart';
import 'services/notification_service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(TaskStatusAdapter());
  Hive.registerAdapter(TaskAdapter());
  Hive.registerAdapter(DayStatusAdapter());
  Hive.registerAdapter(DaySummaryAdapter());
  Hive.registerAdapter(AppModeAdapter());

  await Hive.openBox<Task>('tasks');
  await Hive.openBox<DaySummary>('summaries');
  await Hive.openBox<String>('modeBox');
  await Hive.openBox('themeBox');
  await NotificationService.init();
  await DayManager.handleRollover();

  runApp(const ProviderScope(child: DaylyApp()));
}
