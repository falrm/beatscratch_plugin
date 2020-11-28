///
//  Generated code. Do not modify.
//  source: protos/music.proto
//
// @dart = 2.12
// ignore_for_file: annotate_overrides,camel_case_types,unnecessary_const,non_constant_identifier_names,library_prefixes,unused_import,unused_shown_name,return_of_invalid_type,unnecessary_this,prefer_final_fields

import 'dart:core' as $core;

import 'package:protobuf/protobuf.dart' as $pb;

import 'music.pbenum.dart';

export 'music.pbenum.dart';

class NoteName extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'NoteName', createEmptyInstance: create)
    ..e<NoteLetter>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'noteLetter', $pb.PbFieldType.OE, defaultOrMaker: NoteLetter.C, valueOf: NoteLetter.valueOf, enumValues: NoteLetter.values)
    ..e<NoteSign>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'noteSign', $pb.PbFieldType.OE, defaultOrMaker: NoteSign.natural, valueOf: NoteSign.valueOf, enumValues: NoteSign.values)
    ..hasRequiredFields = false
  ;

  NoteName._() : super();
  factory NoteName() => create();
  factory NoteName.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory NoteName.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  NoteName clone() => NoteName()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  NoteName copyWith(void Function(NoteName) updates) => super.copyWith((message) => updates(message as NoteName)) as NoteName; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static NoteName create() => NoteName._();
  NoteName createEmptyInstance() => create();
  static $pb.PbList<NoteName> createRepeated() => $pb.PbList<NoteName>();
  @$core.pragma('dart2js:noInline')
  static NoteName getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<NoteName>(create);
  static NoteName? _defaultInstance;

  @$pb.TagNumber(1)
  NoteLetter get noteLetter => $_getN(0);
  @$pb.TagNumber(1)
  set noteLetter(NoteLetter v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasNoteLetter() => $_has(0);
  @$pb.TagNumber(1)
  void clearNoteLetter() => clearField(1);

  @$pb.TagNumber(2)
  NoteSign get noteSign => $_getN(1);
  @$pb.TagNumber(2)
  set noteSign(NoteSign v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasNoteSign() => $_has(1);
  @$pb.TagNumber(2)
  void clearNoteSign() => clearField(2);
}

class Chord extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Chord', createEmptyInstance: create)
    ..aOM<NoteName>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'rootNote', subBuilder: NoteName.create)
    ..aOM<NoteName>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bassNote', subBuilder: NoteName.create)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'chroma', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  Chord._() : super();
  factory Chord() => create();
  factory Chord.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Chord.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Chord clone() => Chord()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Chord copyWith(void Function(Chord) updates) => super.copyWith((message) => updates(message as Chord)) as Chord; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Chord create() => Chord._();
  Chord createEmptyInstance() => create();
  static $pb.PbList<Chord> createRepeated() => $pb.PbList<Chord>();
  @$core.pragma('dart2js:noInline')
  static Chord getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Chord>(create);
  static Chord? _defaultInstance;

  @$pb.TagNumber(1)
  NoteName get rootNote => $_getN(0);
  @$pb.TagNumber(1)
  set rootNote(NoteName v) { setField(1, v); }
  @$pb.TagNumber(1)
  $core.bool hasRootNote() => $_has(0);
  @$pb.TagNumber(1)
  void clearRootNote() => clearField(1);
  @$pb.TagNumber(1)
  NoteName ensureRootNote() => $_ensure(0);

  @$pb.TagNumber(2)
  NoteName get bassNote => $_getN(1);
  @$pb.TagNumber(2)
  set bassNote(NoteName v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasBassNote() => $_has(1);
  @$pb.TagNumber(2)
  void clearBassNote() => clearField(2);
  @$pb.TagNumber(2)
  NoteName ensureBassNote() => $_ensure(1);

  @$pb.TagNumber(3)
  $core.int get chroma => $_getIZ(2);
  @$pb.TagNumber(3)
  set chroma($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasChroma() => $_has(2);
  @$pb.TagNumber(3)
  void clearChroma() => clearField(3);
}

class Tempo extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Tempo', createEmptyInstance: create)
    ..a<$core.double>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'bpm', $pb.PbFieldType.OF)
    ..e<Tempo_Transition>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'transition', $pb.PbFieldType.OE, defaultOrMaker: Tempo_Transition.a_tempo, valueOf: Tempo_Transition.valueOf, enumValues: Tempo_Transition.values)
    ..hasRequiredFields = false
  ;

  Tempo._() : super();
  factory Tempo() => create();
  factory Tempo.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Tempo.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Tempo clone() => Tempo()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Tempo copyWith(void Function(Tempo) updates) => super.copyWith((message) => updates(message as Tempo)) as Tempo; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Tempo create() => Tempo._();
  Tempo createEmptyInstance() => create();
  static $pb.PbList<Tempo> createRepeated() => $pb.PbList<Tempo>();
  @$core.pragma('dart2js:noInline')
  static Tempo getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Tempo>(create);
  static Tempo? _defaultInstance;

  @$pb.TagNumber(1)
  $core.double get bpm => $_getN(0);
  @$pb.TagNumber(1)
  set bpm($core.double v) { $_setFloat(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasBpm() => $_has(0);
  @$pb.TagNumber(1)
  void clearBpm() => clearField(1);

  @$pb.TagNumber(2)
  Tempo_Transition get transition => $_getN(1);
  @$pb.TagNumber(2)
  set transition(Tempo_Transition v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasTransition() => $_has(1);
  @$pb.TagNumber(2)
  void clearTransition() => clearField(2);
}

class Meter extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Meter', createEmptyInstance: create)
    ..a<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'defaultBeatsPerMeasure', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  Meter._() : super();
  factory Meter() => create();
  factory Meter.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Meter.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Meter clone() => Meter()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Meter copyWith(void Function(Meter) updates) => super.copyWith((message) => updates(message as Meter)) as Meter; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Meter create() => Meter._();
  Meter createEmptyInstance() => create();
  static $pb.PbList<Meter> createRepeated() => $pb.PbList<Meter>();
  @$core.pragma('dart2js:noInline')
  static Meter getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Meter>(create);
  static Meter? _defaultInstance;

  @$pb.TagNumber(1)
  $core.int get defaultBeatsPerMeasure => $_getIZ(0);
  @$pb.TagNumber(1)
  set defaultBeatsPerMeasure($core.int v) { $_setUnsignedInt32(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasDefaultBeatsPerMeasure() => $_has(0);
  @$pb.TagNumber(1)
  void clearDefaultBeatsPerMeasure() => clearField(1);
}

class Harmony extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Harmony', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..a<$core.int>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'subdivisionsPerBeat', $pb.PbFieldType.OU3)
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'length', $pb.PbFieldType.OU3)
    ..m<$core.int, Chord>(100, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'data', entryClassName: 'Harmony.DataEntry', keyFieldType: $pb.PbFieldType.OS3, valueFieldType: $pb.PbFieldType.OM, valueCreator: Chord.create)
    ..hasRequiredFields = false
  ;

  Harmony._() : super();
  factory Harmony() => create();
  factory Harmony.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Harmony.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Harmony clone() => Harmony()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Harmony copyWith(void Function(Harmony) updates) => super.copyWith((message) => updates(message as Harmony)) as Harmony; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Harmony create() => Harmony._();
  Harmony createEmptyInstance() => create();
  static $pb.PbList<Harmony> createRepeated() => $pb.PbList<Harmony>();
  @$core.pragma('dart2js:noInline')
  static Harmony getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Harmony>(create);
  static Harmony? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.int get subdivisionsPerBeat => $_getIZ(1);
  @$pb.TagNumber(2)
  set subdivisionsPerBeat($core.int v) { $_setUnsignedInt32(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasSubdivisionsPerBeat() => $_has(1);
  @$pb.TagNumber(2)
  void clearSubdivisionsPerBeat() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get length => $_getIZ(2);
  @$pb.TagNumber(3)
  set length($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasLength() => $_has(2);
  @$pb.TagNumber(3)
  void clearLength() => clearField(3);

  @$pb.TagNumber(100)
  $core.Map<$core.int, Chord> get data => $_getMap(3);
}

enum Melody_Data {
  midiData, 
  notSet
}

class Melody extends $pb.GeneratedMessage {
  static const $core.Map<$core.int, Melody_Data> _Melody_DataByTag = {
    101 : Melody_Data.midiData,
    0 : Melody_Data.notSet
  };
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Melody', createEmptyInstance: create)
    ..oo(0, [101])
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..a<$core.int>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'subdivisionsPerBeat', $pb.PbFieldType.OU3)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'length', $pb.PbFieldType.OU3)
    ..e<MelodyType>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type', $pb.PbFieldType.OE, defaultOrMaker: MelodyType.midi, valueOf: MelodyType.valueOf, enumValues: MelodyType.values)
    ..e<InstrumentType>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'instrumentType', $pb.PbFieldType.OE, defaultOrMaker: InstrumentType.harmonic, valueOf: InstrumentType.valueOf, enumValues: InstrumentType.values)
    ..e<MelodyInterpretationType>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'interpretationType', $pb.PbFieldType.OE, defaultOrMaker: MelodyInterpretationType.fixed_nonadaptive, valueOf: MelodyInterpretationType.valueOf, enumValues: MelodyInterpretationType.values)
    ..aOM<MidiData>(101, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'midiData', subBuilder: MidiData.create)
    ..hasRequiredFields = false
  ;

  Melody._() : super();
  factory Melody() => create();
  factory Melody.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Melody.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Melody clone() => Melody()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Melody copyWith(void Function(Melody) updates) => super.copyWith((message) => updates(message as Melody)) as Melody; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Melody create() => Melody._();
  Melody createEmptyInstance() => create();
  static $pb.PbList<Melody> createRepeated() => $pb.PbList<Melody>();
  @$core.pragma('dart2js:noInline')
  static Melody getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Melody>(create);
  static Melody? _defaultInstance;

  Melody_Data whichData() => _Melody_DataByTag[$_whichOneof(0)]!;
  void clearData() => clearField($_whichOneof(0));

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);

  @$pb.TagNumber(3)
  $core.int get subdivisionsPerBeat => $_getIZ(2);
  @$pb.TagNumber(3)
  set subdivisionsPerBeat($core.int v) { $_setUnsignedInt32(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasSubdivisionsPerBeat() => $_has(2);
  @$pb.TagNumber(3)
  void clearSubdivisionsPerBeat() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get length => $_getIZ(3);
  @$pb.TagNumber(4)
  set length($core.int v) { $_setUnsignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasLength() => $_has(3);
  @$pb.TagNumber(4)
  void clearLength() => clearField(4);

  @$pb.TagNumber(5)
  MelodyType get type => $_getN(4);
  @$pb.TagNumber(5)
  set type(MelodyType v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasType() => $_has(4);
  @$pb.TagNumber(5)
  void clearType() => clearField(5);

  @$pb.TagNumber(6)
  InstrumentType get instrumentType => $_getN(5);
  @$pb.TagNumber(6)
  set instrumentType(InstrumentType v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasInstrumentType() => $_has(5);
  @$pb.TagNumber(6)
  void clearInstrumentType() => clearField(6);

  @$pb.TagNumber(7)
  MelodyInterpretationType get interpretationType => $_getN(6);
  @$pb.TagNumber(7)
  set interpretationType(MelodyInterpretationType v) { setField(7, v); }
  @$pb.TagNumber(7)
  $core.bool hasInterpretationType() => $_has(6);
  @$pb.TagNumber(7)
  void clearInterpretationType() => clearField(7);

  @$pb.TagNumber(101)
  MidiData get midiData => $_getN(7);
  @$pb.TagNumber(101)
  set midiData(MidiData v) { setField(101, v); }
  @$pb.TagNumber(101)
  $core.bool hasMidiData() => $_has(7);
  @$pb.TagNumber(101)
  void clearMidiData() => clearField(101);
  @$pb.TagNumber(101)
  MidiData ensureMidiData() => $_ensure(7);
}

class MidiData extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MidiData', createEmptyInstance: create)
    ..m<$core.int, MidiChange>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'data', entryClassName: 'MidiData.DataEntry', keyFieldType: $pb.PbFieldType.OS3, valueFieldType: $pb.PbFieldType.OM, valueCreator: MidiChange.create)
    ..hasRequiredFields = false
  ;

  MidiData._() : super();
  factory MidiData() => create();
  factory MidiData.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MidiData.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MidiData clone() => MidiData()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MidiData copyWith(void Function(MidiData) updates) => super.copyWith((message) => updates(message as MidiData)) as MidiData; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MidiData create() => MidiData._();
  MidiData createEmptyInstance() => create();
  static $pb.PbList<MidiData> createRepeated() => $pb.PbList<MidiData>();
  @$core.pragma('dart2js:noInline')
  static MidiData getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MidiData>(create);
  static MidiData? _defaultInstance;

  @$pb.TagNumber(1)
  $core.Map<$core.int, MidiChange> get data => $_getMap(0);
}

class MelodicAttack extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MelodicAttack', createEmptyInstance: create)
    ..p<$core.int>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'tones', $pb.PbFieldType.PS3)
    ..a<$core.double>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'velocity', $pb.PbFieldType.OF)
    ..hasRequiredFields = false
  ;

  MelodicAttack._() : super();
  factory MelodicAttack() => create();
  factory MelodicAttack.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MelodicAttack.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MelodicAttack clone() => MelodicAttack()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MelodicAttack copyWith(void Function(MelodicAttack) updates) => super.copyWith((message) => updates(message as MelodicAttack)) as MelodicAttack; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MelodicAttack create() => MelodicAttack._();
  MelodicAttack createEmptyInstance() => create();
  static $pb.PbList<MelodicAttack> createRepeated() => $pb.PbList<MelodicAttack>();
  @$core.pragma('dart2js:noInline')
  static MelodicAttack getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MelodicAttack>(create);
  static MelodicAttack? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get tones => $_getList(0);

  @$pb.TagNumber(2)
  $core.double get velocity => $_getN(1);
  @$pb.TagNumber(2)
  set velocity($core.double v) { $_setFloat(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasVelocity() => $_has(1);
  @$pb.TagNumber(2)
  void clearVelocity() => clearField(2);
}

class MidiChange extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MidiChange', createEmptyInstance: create)
    ..a<$core.List<$core.int>>(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'data', $pb.PbFieldType.OY)
    ..hasRequiredFields = false
  ;

  MidiChange._() : super();
  factory MidiChange() => create();
  factory MidiChange.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MidiChange.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MidiChange clone() => MidiChange()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MidiChange copyWith(void Function(MidiChange) updates) => super.copyWith((message) => updates(message as MidiChange)) as MidiChange; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MidiChange create() => MidiChange._();
  MidiChange createEmptyInstance() => create();
  static $pb.PbList<MidiChange> createRepeated() => $pb.PbList<MidiChange>();
  @$core.pragma('dart2js:noInline')
  static MidiChange getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MidiChange>(create);
  static MidiChange? _defaultInstance;

  @$pb.TagNumber(1)
  $core.List<$core.int> get data => $_getN(0);
  @$pb.TagNumber(1)
  set data($core.List<$core.int> v) { $_setBytes(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasData() => $_has(0);
  @$pb.TagNumber(1)
  void clearData() => clearField(1);
}

class Instrument extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Instrument', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..e<InstrumentType>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'type', $pb.PbFieldType.OE, defaultOrMaker: InstrumentType.harmonic, valueOf: InstrumentType.valueOf, enumValues: InstrumentType.values)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'volume', $pb.PbFieldType.OF)
    ..a<$core.int>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'midiChannel', $pb.PbFieldType.OU3)
    ..a<$core.int>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'midiInstrument', $pb.PbFieldType.OU3)
    ..a<$core.int>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'midiGm2Msb', $pb.PbFieldType.OU3)
    ..a<$core.int>(7, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'midiGm2Lsb', $pb.PbFieldType.OU3)
    ..hasRequiredFields = false
  ;

  Instrument._() : super();
  factory Instrument() => create();
  factory Instrument.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Instrument.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Instrument clone() => Instrument()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Instrument copyWith(void Function(Instrument) updates) => super.copyWith((message) => updates(message as Instrument)) as Instrument; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Instrument create() => Instrument._();
  Instrument createEmptyInstance() => create();
  static $pb.PbList<Instrument> createRepeated() => $pb.PbList<Instrument>();
  @$core.pragma('dart2js:noInline')
  static Instrument getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Instrument>(create);
  static Instrument? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get name => $_getSZ(0);
  @$pb.TagNumber(1)
  set name($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasName() => $_has(0);
  @$pb.TagNumber(1)
  void clearName() => clearField(1);

  @$pb.TagNumber(2)
  InstrumentType get type => $_getN(1);
  @$pb.TagNumber(2)
  set type(InstrumentType v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasType() => $_has(1);
  @$pb.TagNumber(2)
  void clearType() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get volume => $_getN(2);
  @$pb.TagNumber(3)
  set volume($core.double v) { $_setFloat(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasVolume() => $_has(2);
  @$pb.TagNumber(3)
  void clearVolume() => clearField(3);

  @$pb.TagNumber(4)
  $core.int get midiChannel => $_getIZ(3);
  @$pb.TagNumber(4)
  set midiChannel($core.int v) { $_setUnsignedInt32(3, v); }
  @$pb.TagNumber(4)
  $core.bool hasMidiChannel() => $_has(3);
  @$pb.TagNumber(4)
  void clearMidiChannel() => clearField(4);

  @$pb.TagNumber(5)
  $core.int get midiInstrument => $_getIZ(4);
  @$pb.TagNumber(5)
  set midiInstrument($core.int v) { $_setUnsignedInt32(4, v); }
  @$pb.TagNumber(5)
  $core.bool hasMidiInstrument() => $_has(4);
  @$pb.TagNumber(5)
  void clearMidiInstrument() => clearField(5);

  @$pb.TagNumber(6)
  $core.int get midiGm2Msb => $_getIZ(5);
  @$pb.TagNumber(6)
  set midiGm2Msb($core.int v) { $_setUnsignedInt32(5, v); }
  @$pb.TagNumber(6)
  $core.bool hasMidiGm2Msb() => $_has(5);
  @$pb.TagNumber(6)
  void clearMidiGm2Msb() => clearField(6);

  @$pb.TagNumber(7)
  $core.int get midiGm2Lsb => $_getIZ(6);
  @$pb.TagNumber(7)
  set midiGm2Lsb($core.int v) { $_setUnsignedInt32(6, v); }
  @$pb.TagNumber(7)
  $core.bool hasMidiGm2Lsb() => $_has(6);
  @$pb.TagNumber(7)
  void clearMidiGm2Lsb() => clearField(7);
}

class Part extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Part', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOM<Instrument>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'instrument', subBuilder: Instrument.create)
    ..pc<Melody>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'melodies', $pb.PbFieldType.PM, subBuilder: Melody.create)
    ..hasRequiredFields = false
  ;

  Part._() : super();
  factory Part() => create();
  factory Part.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Part.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Part clone() => Part()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Part copyWith(void Function(Part) updates) => super.copyWith((message) => updates(message as Part)) as Part; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Part create() => Part._();
  Part createEmptyInstance() => create();
  static $pb.PbList<Part> createRepeated() => $pb.PbList<Part>();
  @$core.pragma('dart2js:noInline')
  static Part getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Part>(create);
  static Part? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(3)
  Instrument get instrument => $_getN(1);
  @$pb.TagNumber(3)
  set instrument(Instrument v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasInstrument() => $_has(1);
  @$pb.TagNumber(3)
  void clearInstrument() => clearField(3);
  @$pb.TagNumber(3)
  Instrument ensureInstrument() => $_ensure(1);

  @$pb.TagNumber(4)
  $core.List<Melody> get melodies => $_getList(2);
}

class MelodyReference extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'MelodyReference', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'melodyId')
    ..e<MelodyReference_PlaybackType>(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'playbackType', $pb.PbFieldType.OE, defaultOrMaker: MelodyReference_PlaybackType.disabled, valueOf: MelodyReference_PlaybackType.valueOf, enumValues: MelodyReference_PlaybackType.values)
    ..a<$core.double>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'volume', $pb.PbFieldType.OF)
    ..hasRequiredFields = false
  ;

  MelodyReference._() : super();
  factory MelodyReference() => create();
  factory MelodyReference.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory MelodyReference.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  MelodyReference clone() => MelodyReference()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  MelodyReference copyWith(void Function(MelodyReference) updates) => super.copyWith((message) => updates(message as MelodyReference)) as MelodyReference; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static MelodyReference create() => MelodyReference._();
  MelodyReference createEmptyInstance() => create();
  static $pb.PbList<MelodyReference> createRepeated() => $pb.PbList<MelodyReference>();
  @$core.pragma('dart2js:noInline')
  static MelodyReference getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<MelodyReference>(create);
  static MelodyReference? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get melodyId => $_getSZ(0);
  @$pb.TagNumber(1)
  set melodyId($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasMelodyId() => $_has(0);
  @$pb.TagNumber(1)
  void clearMelodyId() => clearField(1);

  @$pb.TagNumber(2)
  MelodyReference_PlaybackType get playbackType => $_getN(1);
  @$pb.TagNumber(2)
  set playbackType(MelodyReference_PlaybackType v) { setField(2, v); }
  @$pb.TagNumber(2)
  $core.bool hasPlaybackType() => $_has(1);
  @$pb.TagNumber(2)
  void clearPlaybackType() => clearField(2);

  @$pb.TagNumber(3)
  $core.double get volume => $_getN(2);
  @$pb.TagNumber(3)
  set volume($core.double v) { $_setFloat(2, v); }
  @$pb.TagNumber(3)
  $core.bool hasVolume() => $_has(2);
  @$pb.TagNumber(3)
  void clearVolume() => clearField(3);
}

class Section extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Section', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..aOM<Harmony>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'harmony', subBuilder: Harmony.create)
    ..aOM<Meter>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'meter', subBuilder: Meter.create)
    ..aOM<Tempo>(5, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'tempo', subBuilder: Tempo.create)
    ..aOM<NoteName>(6, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'key', subBuilder: NoteName.create)
    ..pc<MelodyReference>(100, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'melodies', $pb.PbFieldType.PM, subBuilder: MelodyReference.create)
    ..hasRequiredFields = false
  ;

  Section._() : super();
  factory Section() => create();
  factory Section.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Section.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Section clone() => Section()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Section copyWith(void Function(Section) updates) => super.copyWith((message) => updates(message as Section)) as Section; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Section create() => Section._();
  Section createEmptyInstance() => create();
  static $pb.PbList<Section> createRepeated() => $pb.PbList<Section>();
  @$core.pragma('dart2js:noInline')
  static Section getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Section>(create);
  static Section? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);

  @$pb.TagNumber(3)
  Harmony get harmony => $_getN(2);
  @$pb.TagNumber(3)
  set harmony(Harmony v) { setField(3, v); }
  @$pb.TagNumber(3)
  $core.bool hasHarmony() => $_has(2);
  @$pb.TagNumber(3)
  void clearHarmony() => clearField(3);
  @$pb.TagNumber(3)
  Harmony ensureHarmony() => $_ensure(2);

  @$pb.TagNumber(4)
  Meter get meter => $_getN(3);
  @$pb.TagNumber(4)
  set meter(Meter v) { setField(4, v); }
  @$pb.TagNumber(4)
  $core.bool hasMeter() => $_has(3);
  @$pb.TagNumber(4)
  void clearMeter() => clearField(4);
  @$pb.TagNumber(4)
  Meter ensureMeter() => $_ensure(3);

  @$pb.TagNumber(5)
  Tempo get tempo => $_getN(4);
  @$pb.TagNumber(5)
  set tempo(Tempo v) { setField(5, v); }
  @$pb.TagNumber(5)
  $core.bool hasTempo() => $_has(4);
  @$pb.TagNumber(5)
  void clearTempo() => clearField(5);
  @$pb.TagNumber(5)
  Tempo ensureTempo() => $_ensure(4);

  @$pb.TagNumber(6)
  NoteName get key => $_getN(5);
  @$pb.TagNumber(6)
  set key(NoteName v) { setField(6, v); }
  @$pb.TagNumber(6)
  $core.bool hasKey() => $_has(5);
  @$pb.TagNumber(6)
  void clearKey() => clearField(6);
  @$pb.TagNumber(6)
  NoteName ensureKey() => $_ensure(5);

  @$pb.TagNumber(100)
  $core.List<MelodyReference> get melodies => $_getList(6);
}

class Score extends $pb.GeneratedMessage {
  static final $pb.BuilderInfo _i = $pb.BuilderInfo(const $core.bool.fromEnvironment('protobuf.omit_message_names') ? '' : 'Score', createEmptyInstance: create)
    ..aOS(1, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'id')
    ..aOS(2, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'name')
    ..pc<Part>(3, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'parts', $pb.PbFieldType.PM, subBuilder: Part.create)
    ..pc<Section>(4, const $core.bool.fromEnvironment('protobuf.omit_field_names') ? '' : 'sections', $pb.PbFieldType.PM, subBuilder: Section.create)
    ..hasRequiredFields = false
  ;

  Score._() : super();
  factory Score() => create();
  factory Score.fromBuffer($core.List<$core.int> i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromBuffer(i, r);
  factory Score.fromJson($core.String i, [$pb.ExtensionRegistry r = $pb.ExtensionRegistry.EMPTY]) => create()..mergeFromJson(i, r);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.deepCopy] instead. '
  'Will be removed in next major version')
  Score clone() => Score()..mergeFromMessage(this);
  @$core.Deprecated(
  'Using this can add significant overhead to your binary. '
  'Use [GeneratedMessageGenericExtensions.rebuild] instead. '
  'Will be removed in next major version')
  Score copyWith(void Function(Score) updates) => super.copyWith((message) => updates(message as Score)) as Score; // ignore: deprecated_member_use
  $pb.BuilderInfo get info_ => _i;
  @$core.pragma('dart2js:noInline')
  static Score create() => Score._();
  Score createEmptyInstance() => create();
  static $pb.PbList<Score> createRepeated() => $pb.PbList<Score>();
  @$core.pragma('dart2js:noInline')
  static Score getDefault() => _defaultInstance ??= $pb.GeneratedMessage.$_defaultFor<Score>(create);
  static Score? _defaultInstance;

  @$pb.TagNumber(1)
  $core.String get id => $_getSZ(0);
  @$pb.TagNumber(1)
  set id($core.String v) { $_setString(0, v); }
  @$pb.TagNumber(1)
  $core.bool hasId() => $_has(0);
  @$pb.TagNumber(1)
  void clearId() => clearField(1);

  @$pb.TagNumber(2)
  $core.String get name => $_getSZ(1);
  @$pb.TagNumber(2)
  set name($core.String v) { $_setString(1, v); }
  @$pb.TagNumber(2)
  $core.bool hasName() => $_has(1);
  @$pb.TagNumber(2)
  void clearName() => clearField(2);

  @$pb.TagNumber(3)
  $core.List<Part> get parts => $_getList(2);

  @$pb.TagNumber(4)
  $core.List<Section> get sections => $_getList(3);
}

