import 'package:android_intent_plus/android_intent.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReminderHealth {
  static const _ackKey = 'reminder_permission_ack';

  /// Has user acknowledged reminder requirements?
  static Future<bool> isAcknowledged() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_ackKey) ?? false;
  }

  /// Mark that user accepted reminder limitations
  static Future<void> acknowledge() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_ackKey, true);
  }

  /// Open Exact Alarm permission screen (Android 12+)
  static void openExactAlarmSettings() {
    const intent = AndroidIntent(
      action: 'android.settings.REQUEST_SCHEDULE_EXACT_ALARM',
    );
    intent.launch();
  }

  /// Open Battery Optimization ignore screen
  static void openBatteryOptimizationSettings() {
    const intent = AndroidIntent(
      action: 'android.settings.IGNORE_BATTERY_OPTIMIZATION_SETTINGS',
    );
    intent.launch();
  }
}
