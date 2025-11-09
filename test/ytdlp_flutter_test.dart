import 'package:flutter_test/flutter_test.dart';
import 'package:ytdlp_flutter/ytdlp_flutter.dart';
import 'package:ytdlp_flutter/ytdlp_flutter_platform_interface.dart';
import 'package:ytdlp_flutter/ytdlp_flutter_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockYtdlpFlutterPlatform
    with MockPlatformInterfaceMixin
    implements YtdlpFlutterPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final YtdlpFlutterPlatform initialPlatform = YtdlpFlutterPlatform.instance;

  test('$MethodChannelYtdlpFlutter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelYtdlpFlutter>());
  });

  test('getPlatformVersion', () async {
    YtdlpFlutter ytdlpFlutterPlugin = YtdlpFlutter();
    MockYtdlpFlutterPlatform fakePlatform = MockYtdlpFlutterPlatform();
    YtdlpFlutterPlatform.instance = fakePlatform;

    expect(await ytdlpFlutterPlugin.getPlatformVersion(), '42');
  });
}
