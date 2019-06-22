import 'package:flutter/services.dart';

class AppSettings {
  static MethodChannel _channel = const MethodChannel('eq_settings');

  static Future<void> openEqualizer() async {
    try {
      await _channel.invokeMethod('equalizer');
    } on PlatformException catch (e) {
      print("equalizer " + e.message);
    }
  }
}
