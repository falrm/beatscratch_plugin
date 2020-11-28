
import 'dart:io';
import 'package:flutter/foundation.dart';

class MyPlatform {
  static final bool isWeb = kIsWeb;
  static final bool isNative = !kIsWeb;
  static final bool isIOS = !kIsWeb && Platform.isIOS;
  static final bool isMacOS = !kIsWeb && Platform.isMacOS;
  static final bool isAppleOS = isIOS || isMacOS;
  static final bool isAndroid = !kIsWeb && Platform.isAndroid;
  static final bool isMobile = isAndroid || isIOS;
  static final bool isDebug = kDebugMode;
}