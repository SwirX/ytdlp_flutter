import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'ytdlp_flutter_method_channel.dart';

abstract class YtdlpFlutterPlatform extends PlatformInterface {
  /// Constructs a YtdlpFlutterPlatform.
  YtdlpFlutterPlatform() : super(token: _token);

  static final Object _token = Object();

  static YtdlpFlutterPlatform _instance = MethodChannelYtdlpFlutter();

  /// The default instance of [YtdlpFlutterPlatform] to use.
  ///
  /// Defaults to [MethodChannelYtdlpFlutter].
  static YtdlpFlutterPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [YtdlpFlutterPlatform] when
  /// they register themselves.
  static set instance(YtdlpFlutterPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getBestAudioUrl(String videoId) {
    throw UnimplementedError('getBestAudio(videoId) has not been implemented.');
  }
}
