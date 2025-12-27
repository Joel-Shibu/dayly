package com.joel.dayly

import android.app.*
import android.content.Intent
import android.os.Build
import android.os.IBinder
import androidx.core.app.NotificationCompat
import kotlinx.coroutines.*
import java.util.concurrent.TimeUnit

class ReminderForegroundService : Service() {

    private val scope = CoroutineScope(Dispatchers.Main + Job())

    override fun onStartCommand(intent: Intent, flags: Int, startId: Int): Int {
        val title = intent.getStringExtra("title") ?: "Reminder"
        val triggerAt = intent.getLongExtra("triggerAt", 0L)

        startForeground(1, buildPreparingNotification())

        scope.launch {
            val delayMs = triggerAt - System.currentTimeMillis()
            if (delayMs > 0) delay(delayMs)

            showReminder(title)
            stopSelf()
        }

        return START_NOT_STICKY
    }

    private fun buildPreparingNotification(): Notification {
        val channelId = "dayly_prepare"

        if (Build.VERSION.SDK_INT >= 26) {
            val channel = NotificationChannel(
                channelId,
                "Preparing Reminder",
                NotificationManager.IMPORTANCE_LOW
            )
            getSystemService(NotificationManager::class.java)
                .createNotificationChannel(channel)
        }

        return NotificationCompat.Builder(this, channelId)
            .setContentTitle("Preparing reminder…")
            .setSmallIcon(R.mipmap.ic_launcher)
            .setSilent(true)
            .build()
    }

    private fun showReminder(title: String) {
        val channelId = "dayly_reminder"

        if (Build.VERSION.SDK_INT >= 26) {
            val channel = NotificationChannel(
                channelId,
                "Dayly Reminders",
                NotificationManager.IMPORTANCE_HIGH
            )
            getSystemService(NotificationManager::class.java)
                .createNotificationChannel(channel)
        }

        val notification = NotificationCompat.Builder(this, channelId)
            .setContentTitle(title)
            .setContentText("Reminder")
            .setSmallIcon(R.mipmap.ic_launcher)
            .setAutoCancel(true)
            .build()

        getSystemService(NotificationManager::class.java)
            .notify(System.currentTimeMillis().toInt(), notification)
    }

    override fun onBind(intent: Intent?): IBinder? = null
}
