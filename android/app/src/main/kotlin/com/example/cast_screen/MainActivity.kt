package com.example.cast_screen


import android.app.Activity
import android.content.Context
import android.content.Intent
import android.media.projection.MediaProjectionManager
import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.plugin.common.MethodChannel

import androidx.annotation.NonNull
import io.flutter.embedding.engine.FlutterEngine

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.example.castapp/cast"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "startCasting") {
                startCasting()
                result.success("Casting started")
            } else if (call.method == "stopCasting") {
                stopCasting()
                result.success("Casting stopped")
            } else {
                result.notImplemented()
            }
        }
    }

    private fun startCasting() {
        // Start screen casting logic using Google Cast SDK
    }

    private fun stopCasting() {
        // Stop screen casting logic
    }
}


/*class MainActivity : FlutterActivity() {
    private val SCREEN_CAST_REQUEST_CODE = 1001
    private lateinit var screenCastManager: ScreenCastManager
    private var projectionIntent: Intent? = null

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        screenCastManager = ScreenCastManager(this)

        flutterEngine?.dartExecutor?.binaryMessenger?.let {
            MethodChannel(it, "screen_cast_channel")
                .setMethodCallHandler { call, result ->
                    when (call.method) {
                        "startCasting" -> {
                            if (projectionIntent != null) {
                                screenCastManager.startCasting(projectionIntent!!)
                                result.success(null)
                            } else {
                                requestScreenCapturePermission()
                            }
                        }

                        "pauseCasting" -> {
                            screenCastManager.pauseCasting()
                            result.success(null)
                        }

                        "stopCasting" -> {
                            screenCastManager.stopCasting()
                            result.success(null)
                        }

                        else -> result.notImplemented()
                    }
                }
        }
    }

    private fun requestScreenCapturePermission() {
        val mediaProjectionManager =
            getSystemService(Context.MEDIA_PROJECTION_SERVICE) as MediaProjectionManager
        startActivityForResult(
            mediaProjectionManager.createScreenCaptureIntent(),
            SCREEN_CAST_REQUEST_CODE
        )
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        if (requestCode == SCREEN_CAST_REQUEST_CODE && resultCode == Activity.RESULT_OK && data != null) {
            projectionIntent = data
            screenCastManager.startCasting(projectionIntent!!)
        }
    }
}*/


