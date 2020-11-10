package com.example.native_platform_channel

import android.os.Build
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {
    private val CHANNEL = "com.example.flutter.dev/device_info"

    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "getDeviceInfo") {
                val deviceInfo = getDeviceInfo();

                if (Build.MODEL != null) {
                    result.success(deviceInfo)
                } else {
                    result.error("UNAVAILABLE", "Device information cannot available for this device", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }

    private fun getDeviceInfo(): HashMap<String, Any> {
        val model = Build.MODEL
        val versionRelease = Build.VERSION.RELEASE
        val result: HashMap<String, Any> = HashMap()

        result["model"] = model
        result["systemVersion"] = versionRelease
        return result;
    }
}
