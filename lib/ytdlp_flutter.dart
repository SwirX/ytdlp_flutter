import 'ytdlp_flutter_platform_interface.dart';

class YtdlpFlutter {
  Future<String?> getBestAudio(String videoId) {
    return YtdlpFlutterPlatform.instance.getBestAudioUrl(videoId);
  }
}
