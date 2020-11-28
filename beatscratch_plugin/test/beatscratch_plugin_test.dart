import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:beatscratch_plugin/beatscratch_plugin.dart';

void main() {
  const MethodChannel channel = MethodChannel('BeatScratchPlugin');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await BeatScratchPlugin.platformVersion, '42');
  });
}
