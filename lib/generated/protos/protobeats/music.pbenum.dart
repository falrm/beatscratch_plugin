///
//  Generated code. Do not modify.
//  source: protos/protobeats/music.proto
//
// @dart = 2.7
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

// ignore_for_file: UNDEFINED_SHOWN_NAME
import 'dart:core' as $core;
import 'package:protobuf/protobuf.dart' as $pb;

class NoteLetter extends $pb.ProtobufEnum {
  static const NoteLetter C = NoteLetter._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'C');
  static const NoteLetter D = NoteLetter._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'D');
  static const NoteLetter E = NoteLetter._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'E');
  static const NoteLetter F = NoteLetter._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'F');
  static const NoteLetter G = NoteLetter._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'G');
  static const NoteLetter A = NoteLetter._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'A');
  static const NoteLetter B = NoteLetter._(6, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'B');

  static const $core.List<NoteLetter> values = <NoteLetter> [
    C,
    D,
    E,
    F,
    G,
    A,
    B,
  ];

  static final $core.Map<$core.int, NoteLetter> _byValue = $pb.ProtobufEnum.initByValue(values);
  static NoteLetter valueOf($core.int value) => _byValue[value];

  const NoteLetter._($core.int v, $core.String n) : super(v, n);
}

class NoteSign extends $pb.ProtobufEnum {
  static const NoteSign natural = NoteSign._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'natural');
  static const NoteSign flat = NoteSign._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'flat');
  static const NoteSign double_flat = NoteSign._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'double_flat');
  static const NoteSign sharp = NoteSign._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'sharp');
  static const NoteSign double_sharp = NoteSign._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'double_sharp');

  static const $core.List<NoteSign> values = <NoteSign> [
    natural,
    flat,
    double_flat,
    sharp,
    double_sharp,
  ];

  static final $core.Map<$core.int, NoteSign> _byValue = $pb.ProtobufEnum.initByValue(values);
  static NoteSign valueOf($core.int value) => _byValue[value];

  const NoteSign._($core.int v, $core.String n) : super(v, n);
}

class InstrumentType extends $pb.ProtobufEnum {
  static const InstrumentType harmonic = InstrumentType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'harmonic');
  static const InstrumentType drum = InstrumentType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'drum');

  static const $core.List<InstrumentType> values = <InstrumentType> [
    harmonic,
    drum,
  ];

  static final $core.Map<$core.int, InstrumentType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static InstrumentType valueOf($core.int value) => _byValue[value];

  const InstrumentType._($core.int v, $core.String n) : super(v, n);
}

class MelodyType extends $pb.ProtobufEnum {
  static const MelodyType midi = MelodyType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'midi');
  static const MelodyType audio = MelodyType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'audio');

  static const $core.List<MelodyType> values = <MelodyType> [
    midi,
    audio,
  ];

  static final $core.Map<$core.int, MelodyType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static MelodyType valueOf($core.int value) => _byValue[value];

  const MelodyType._($core.int v, $core.String n) : super(v, n);
}

class MelodyInterpretationType extends $pb.ProtobufEnum {
  static const MelodyInterpretationType fixed_nonadaptive = MelodyInterpretationType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'fixed_nonadaptive');
  static const MelodyInterpretationType fixed = MelodyInterpretationType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'fixed');
  static const MelodyInterpretationType relative_to_c = MelodyInterpretationType._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'relative_to_c');
  static const MelodyInterpretationType relative_to_c_sharp = MelodyInterpretationType._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'relative_to_c_sharp');
  static const MelodyInterpretationType relative_to_d = MelodyInterpretationType._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'relative_to_d');
  static const MelodyInterpretationType relative_to_d_sharp = MelodyInterpretationType._(5, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'relative_to_d_sharp');
  static const MelodyInterpretationType relative_to_e = MelodyInterpretationType._(6, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'relative_to_e');
  static const MelodyInterpretationType relative_to_f = MelodyInterpretationType._(7, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'relative_to_f');
  static const MelodyInterpretationType relative_to_f_sharp = MelodyInterpretationType._(8, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'relative_to_f_sharp');
  static const MelodyInterpretationType relative_to_g = MelodyInterpretationType._(9, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'relative_to_g');
  static const MelodyInterpretationType relative_to_g_sharp = MelodyInterpretationType._(10, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'relative_to_g_sharp');
  static const MelodyInterpretationType relative_to_a = MelodyInterpretationType._(11, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'relative_to_a');
  static const MelodyInterpretationType relative_to_a_sharp = MelodyInterpretationType._(12, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'relative_to_a_sharp');
  static const MelodyInterpretationType relative_to_b = MelodyInterpretationType._(13, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'relative_to_b');

  static const $core.List<MelodyInterpretationType> values = <MelodyInterpretationType> [
    fixed_nonadaptive,
    fixed,
    relative_to_c,
    relative_to_c_sharp,
    relative_to_d,
    relative_to_d_sharp,
    relative_to_e,
    relative_to_f,
    relative_to_f_sharp,
    relative_to_g,
    relative_to_g_sharp,
    relative_to_a,
    relative_to_a_sharp,
    relative_to_b,
  ];

  static final $core.Map<$core.int, MelodyInterpretationType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static MelodyInterpretationType valueOf($core.int value) => _byValue[value];

  const MelodyInterpretationType._($core.int v, $core.String n) : super(v, n);
}

class Tempo_Transition extends $pb.ProtobufEnum {
  static const Tempo_Transition a_tempo = Tempo_Transition._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'a_tempo');
  static const Tempo_Transition linear = Tempo_Transition._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'linear');

  static const $core.List<Tempo_Transition> values = <Tempo_Transition> [
    a_tempo,
    linear,
  ];

  static final $core.Map<$core.int, Tempo_Transition> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Tempo_Transition valueOf($core.int value) => _byValue[value];

  const Tempo_Transition._($core.int v, $core.String n) : super(v, n);
}

class MelodyReference_PlaybackType extends $pb.ProtobufEnum {
  static const MelodyReference_PlaybackType disabled = MelodyReference_PlaybackType._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'disabled');
  static const MelodyReference_PlaybackType playback_indefinitely = MelodyReference_PlaybackType._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'playback_indefinitely');

  static const $core.List<MelodyReference_PlaybackType> values = <MelodyReference_PlaybackType> [
    disabled,
    playback_indefinitely,
  ];

  static final $core.Map<$core.int, MelodyReference_PlaybackType> _byValue = $pb.ProtobufEnum.initByValue(values);
  static MelodyReference_PlaybackType valueOf($core.int value) => _byValue[value];

  const MelodyReference_PlaybackType._($core.int v, $core.String n) : super(v, n);
}

class Section_Color extends $pb.ProtobufEnum {
  static const Section_Color major = Section_Color._(0, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'major');
  static const Section_Color minor = Section_Color._(1, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'minor');
  static const Section_Color dominant = Section_Color._(2, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'dominant');
  static const Section_Color augmented = Section_Color._(3, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'augmented');
  static const Section_Color diminished = Section_Color._(4, const $core.bool.fromEnvironment('protobuf.omit_enum_names') ? '' : 'diminished');

  static const $core.List<Section_Color> values = <Section_Color> [
    major,
    minor,
    dominant,
    augmented,
    diminished,
  ];

  static final $core.Map<$core.int, Section_Color> _byValue = $pb.ProtobufEnum.initByValue(values);
  static Section_Color valueOf($core.int value) => _byValue[value];

  const Section_Color._($core.int v, $core.String n) : super(v, n);
}

