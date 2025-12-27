import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static final FlutterLocalNotificationsPlugin _plugin =
      FlutterLocalNotificationsPlugin();

  static Future<void> init() async {
    // 🔴 REQUIRED
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('Asia/Kolkata')); // adjust if needed

    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    const settings = InitializationSettings(android: androidSettings);

    await _plugin.initialize(settings);

    // 🔴 Android 13+ permission
    await _plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();

    // 🔴 HIGH importance channel
    const channel = AndroidNotificationChannel(
      'dayly_reminders',
      'Dayly Reminders',
      description: 'Task reminders',
      importance: Importance.max,
    );

    await _plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }

  static Future<void> schedule({
    required int id,
    required String title,
    required DateTime when,
  }) async {
    final scheduled = tz.TZDateTime.from(when, tz.local);

    const androidDetails = AndroidNotificationDetails(
      'dayly_reminders',
      'Dayly Reminders',
      channelDescription: 'Task reminders',
      importance: Importance.max,
      priority: Priority.max,
    );

    await _plugin.zonedSchedule(
      id,
      title,
      'Reminder',
      scheduled,
      const NotificationDetails(android: androidDetails),
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  static Future<void> cancel(int id) async {
    await _plugin.cancel(id);
  }

  static Future<void> cancelAll() async {
    await _plugin.cancelAll();
  }
}
