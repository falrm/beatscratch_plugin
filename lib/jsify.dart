import 'package:protobuf/protobuf.dart';

import 'fake_js.dart'
if(dart.library.js) 'dart:js';

extension Jsify on GeneratedMessage {
  dynamic jsify() => JsObject.jsify(clone().toProto3Json());
}