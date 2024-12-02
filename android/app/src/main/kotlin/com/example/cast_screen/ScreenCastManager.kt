package com.example.cast_screen

import android.content.Context
import android.content.Intent
import android.media.projection.MediaProjection
import android.media.projection.MediaProjectionManager
import android.util.Log

class ScreenCastManager(private val context: Context) {
    private var mediaProjection: MediaProjection? = null
    private val mediaProjectionManager =
        context.getSystemService(Context.MEDIA_PROJECTION_SERVICE) as MediaProjectionManager

    fun startCasting(projectionIntent: Intent) {
        mediaProjection = mediaProjectionManager.getMediaProjection(-1, projectionIntent)
        Log.d("ScreenCastManager", "Casting started")
    }

    fun pauseCasting() {
        mediaProjection?.stop()
        Log.d("ScreenCastManager", "Casting paused")
    }

    fun stopCasting() {
        mediaProjection?.stop()
        mediaProjection = null
        Log.d("ScreenCastManager", "Casting stopped")
    }
}
