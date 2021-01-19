import 'package:protobuf/protobuf.dart';

import 'fake_js.dart'
if(dart.library.js) 'dart:js';

extension JsifyProto on GeneratedMessage {
  dynamic jsifyProto() => JsObject.jsify(clone().toProto3Json());
}