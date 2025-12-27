import 'package:flutter/services.dart';

class ReliableReminder {
  static const _channel = MethodChannel('dayly/reminder');

  static Future<void> schedule({
    required String title,
    required DateTime when,
  }) async {
    await _channel.invokeMethod('scheduleReliableReminder', {
      'title': title,
      'triggerAt': when.millisecondsSinceEpoch,
    });
  }
}
