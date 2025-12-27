package com.joel.dayly

import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import android.app.AlarmManager
import android.app.PendingIntent
import android.content.Context
import android.content.Intent
import java.util.concurrent.TimeUnit

class MainActivity : FlutterActivity() {
    private val CHANNEL = "dayly/reminder"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            CHANNEL
        ).setMethodCallHandler { call, result ->
            if (call.method == "scheduleReliableReminder") {
                val title = call.argument<String>("title")!!
                val triggerAt = call.argument<Long>("triggerAt")!!
                scheduleAlarm(title, triggerAt)
                result.success(null)
            } else {
                result.notImplemented()
            }
        }
    }

    private fun scheduleAlarm(title: String, triggerAt: Long) {
        val intent = Intent(this, ReminderAlarmReceiver::class.java)
        intent.putExtra("title", title)
        intent.putExtra("triggerAt", triggerAt)

        val pendingIntent = PendingIntent.getBroadcast(
            this,
            triggerAt.toInt(),
            intent,
            PendingIntent.FLAG_UPDATE_CURRENT or PendingIntent.FLAG_IMMUTABLE
        )

        val alarmManager = getSystemService(ALARM_SERVICE) as AlarmManager
        val preWakeTime = triggerAt - TimeUnit.MINUTES.toMillis(5)

        alarmManager.setExactAndAllowWhileIdle(
            AlarmManager.RTC_WAKEUP,
            preWakeTime,
            pendingIntent
        )
    }
}

