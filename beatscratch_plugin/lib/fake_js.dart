
var context = JsObject();

class JsObject {
  JsObject();
  callMethod(String name, List args) => throw "What did you do?";
  operator []=(Object property, Object value) => throw "What did you do?";
  dynamic operator [](Object property) => throw "What did you do?";
  factory JsObject.jsify(Object data) => throw "What did you do?";
}