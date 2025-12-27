package com.joel.dayly

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent

class ReminderAlarmReceiver : BroadcastReceiver() {
    override fun onReceive(context: Context, intent: Intent) {
        val serviceIntent = Intent(context, ReminderForegroundService::class.java)
        serviceIntent.putExtras(intent.extras!!)
        context.startForegroundService(serviceIntent)
    }
}
