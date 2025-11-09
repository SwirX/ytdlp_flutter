import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'ytdlp_flutter_platform_interface.dart';

/// An implementation of [YtdlpFlutterPlatform] that uses method channels.
class MethodChannelYtdlpFlutter extends YtdlpFlutterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  static const MethodChannel methodChannel = const MethodChannel(
    'ytdlp_flutter',
  );

  @override
  Future<String?> getBestAudioUrl(String videoId) async {
    final url = await methodChannel.invokeMethod('getAudioStream', {
      'videoId': videoId,
    });
    return url;
  }
}
