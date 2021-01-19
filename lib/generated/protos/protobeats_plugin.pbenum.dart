///
//  Generated code. Do not modify.
//  source: protos/protobeats_plugin.proto
//
// @dart = 2.7
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class Playback_Mode extends $pb.ProtobufEnum {
  static const Playback_Mode score = Playback_Mode._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'score');
  static const Playback_Mode section = Playback_Mode._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'section');

  static const $core.List<Playback_Mode> values = <Playback_Mode> [
    score,
    section,
  ];

  static final $core.Map<$core.int, Playback_Mode> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Playback_Mode valueOf($core.int value) => _byValue[value];

  const Playback_Mode._($core.int v, $core.String n) : super(v, n);
}

