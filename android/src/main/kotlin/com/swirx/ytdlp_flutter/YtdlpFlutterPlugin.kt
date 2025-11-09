package com.swirx.ytdlp_flutter

import androidx.annotation.NonNull
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

// chaquopy
import com.chaquo.python.Python
import com.chaquo.python.android.AndroidPlatform

/** YtdlpFlutterPlugin */
class YtdlpFlutterPlugin: FlutterPlugin, MethodCallHandler {
  /// The MethodChannel that will the communication between Flutter and native Android
  ///
  /// This local reference serves to register the plugin with the Flutter Engine and unregister it
  /// when the Flutter Engine is detached from the Activity
  private lateinit var channel : MethodChannel

  override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
      channel = MethodChannel(flutterPluginBinding.binaryMessenger, "ytdlp_flutter")
      channel.setMethodCallHandler(this)

      if (!Python.isStarted()) {
          Python.start(AndroidPlatform(flutterPluginBinding.applicationContext))
      }
  }

  override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "getAudioStream" -> {
                val videoId = call.argument<String>("videoId")
                try {
                    val py = Python.getInstance()
                    val pyModule = py.getModule("youtube_extractor")
                    val url = pyModule.callAttr("get_best_audio_stream", videoId).toString()
                    result.success(url)
                } catch (e: Exception) {
                    result.error("PYTHON_ERROR", e.message, null)
                }
            }
            else -> result.notImplemented()
        }
    }

  override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
    channel.setMethodCallHandler(null)
  }
}
