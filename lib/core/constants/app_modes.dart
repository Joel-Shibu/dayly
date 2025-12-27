import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'app_modes.g.dart';

@HiveType(typeId: 10)
enum AppMode {
  @HiveField(0)
  student,
  @HiveField(1)
  work,
  @HiveField(2)
  exam,
  @HiveField(3)
  personal,
}

enum UiDensity { compact, medium, relaxed }

class ModeConfig {
  final Color accent;
  final UiDensity density;
  final TimeOfDay defaultReminderTime;

  const ModeConfig({
    required this.accent,
    required this.density,
    required this.defaultReminderTime,
  });
}

final Map<AppMode, ModeConfig> modeConfigs = {
  AppMode.student: const ModeConfig(
    accent: Colors.blue,
    density: UiDensity.medium,
    defaultReminderTime: TimeOfDay(hour: 7, minute: 0),
  ),
  AppMode.work: const ModeConfig(
    accent: Colors.green,
    density: UiDensity.compact,
    defaultReminderTime: TimeOfDay(hour: 9, minute: 0),
  ),
  AppMode.exam: const ModeConfig(
    accent: Colors.red,
    density: UiDensity.compact,
    defaultReminderTime: TimeOfDay(hour: 6, minute: 0),
  ),
  AppMode.personal: const ModeConfig(
    accent: Colors.purple,
    density: UiDensity.relaxed,
    defaultReminderTime: TimeOfDay(hour: 20, minute: 0),
  ),
};
