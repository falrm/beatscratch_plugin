import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'my_platform.dart';

import 'fake_js.dart' if(dart.library.js) 'dart:js';
import 'jsify_proto.dart';
import 'generated/protos/protos.dart';
import 'package:dart_midi/dart_midi.dart';
// ignore: implementation_imports
import 'package:dart_midi/src/byte_writer.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'music_utils.dart';

/// The native platform side of the app is expected to maintain one [Score].
/// We can push [Part]s and [Melody]s to it. [createScore] should be the first thing called
/// by any part of the UI.
class BeatScratchPlugin {
  static final bool supportsPlayback = true;
  static final bool supportsStorage = !MyPlatform.isWeb || kDebugMode;
  static final bool supportsRecording = !MyPlatform.isWeb || kDebugMode;

  static MethodChannel _channel = MethodChannel('BeatScratchPlugin')
    ..setMethodCallHandler((call) {
      switch(call.method) {
        case "sendPressedMidiNotes":
          final Uint8List rawData = call.arguments;
          final MidiNotes response = MidiNotes.fromBuffer(rawData);
          pressedMidiControllerNotes.value = response.midiNotes.map((e) => e - 60).toSet();
//          print("dart: sendPressedMidiNotes: ${pressedMidiControllerNotes.value}");
//           onSynthesizerStatusChange?.call();

          return Future.value(null);
          break;
        case "notifyBeatScratchAudioAvailable":
          _isBeatScratchAudioAvailable = call.arguments;
          onSynthesizerStatusChange?.call();
          return Future.value(null);
          break;
        case "notifyPlayingBeat":
          _notifyPlayingBeat(call.arguments);
          return Future.value(null);
          break;
        case "notifyPaused":
          _notifyPaused();
          return Future.value(null);
          break;
        case "notifyCountInInitiated":
          _playing = false;
          onCountInInitiated?.call();
          return Future.value(null);
          break;
        case "notifyCurrentSection":
          _notifyCurrentSection(call.arguments);
          break;
        case "notifyStartedSection":
          _notifyStartedSection(call.arguments);
          break;
        case "notifyBpmMultiplier":
          _notifyBpmMultiplier(call.arguments);
          break;
        case "notifyUnmultipliedBpm":
          _notifyUnmultipliedBpm(call.arguments);
          break;
        case "notifyRecordedMelody":
          final Uint8List rawData = call.arguments;
          final Melody response = Melody.fromBuffer(rawData);
          if (response.separateNoteOnAndOffs()) {
            updateMelody(response);
          }
          onRecordingMelodyUpdated?.call(response);
          return Future.value(null);
          break;
        case "notifyMidiDevices":
          final Uint8List rawData = call.arguments;
          final MidiDevices response = MidiDevices.fromBuffer(rawData);
          _notifyMidiDevices(response);
          return Future.value(null);
          break;
        case "notifyScoreUrlOpened":
          _notifyScoreUrlOpened(call.arguments);
          return Future.value(null);
          break;
      }
      return Future.value(null);
    });

  static setupWebStuff() {
    if (MyPlatform.isWeb) {
      context["notifyPlayingBeat"] = _notifyPlayingBeat;
      context["notifyPaused"] = _notifyPaused;
      context["notifyCurrentSection"] = _notifyCurrentSection;
      context["notifyStartedSection"] = _notifyStartedSection;
      context["notifyBpmMultiplier"] = _notifyBpmMultiplier;
      context["notifyUnmultipliedBpm"] = _notifyUnmultipliedBpm;
      context["notifyMidiDevices"] = _notifyMidiDevices;
    }
  }

  static _notifyScoreUrlOpened(String url) {
    if (onLoadScoreFromLink != null) {
      onLoadScoreFromLink?.call(url);
    } else {
      Future.delayed(Duration(milliseconds: 500), () {
        _notifyScoreUrlOpened(url);
      });
    }
  }

  static _notifyMidiDevices(MidiDevices devices) {
    connectedControllers = List.from(devices.controllers
      .where((it) => !MyPlatform.isIOS || it.name != "Session 1"));
    _connectedSynthesizers = List.from(devices.synthesizers);
    onSynthesizerStatusChange?.call();
  }

  static _notifyCurrentSection(String sectionId) {
    onSectionSelected?.call(sectionId);
  }

  static _notifyStartedSection(String sectionId) {
    currentBeat.value = 0;
    onSectionSelected?.call(sectionId);
  }

  static _notifyPlayingBeat(int beat) {
    _playing = true;
    currentBeat.value = beat;
    onSynthesizerStatusChange?.call();
  }

  static _notifyPaused() {
    _playing = false;
    onSynthesizerStatusChange?.call();
  }

  static _notifyBpmMultiplier(double bpmMultiplier) {
    _bpmMultiplier = bpmMultiplier;
    onSynthesizerStatusChange?.call();
  }

  static _notifyUnmultipliedBpm(double unmultipliedBpm) {
    BeatScratchPlugin.unmultipliedBpm = unmultipliedBpm;
    onSynthesizerStatusChange?.call();
  }

  static bool _metronomeEnabled = true;
  static bool get metronomeEnabled => _metronomeEnabled;
  static set metronomeEnabled(bool value) {
    _metronomeEnabled = value;
    if(kIsWeb) {
      context.callMethod('setMetronomeEnabled', [value]);
    } else {
      _channel.invokeMethod('setMetronomeEnabled', value);
    }
  }
  static double _bpmMultiplier = 1.0;
  static double get bpmMultiplier => _bpmMultiplier;
  static set bpmMultiplier(double value) {
    _bpmMultiplier = value;
    try {
      if (kIsWeb) {
        context.callMethod('setBpmMultiplier', [value]);
      } else {
        _channel.invokeMethod('setBpmMultiplier', value);
      }
    } catch(any) {

    }
  }
  static double unmultipliedBpm = 123;
  static bool _playing;
  static bool get playing {
    if(_playing == null) {
      _setupSynthesizerStatusChangeLoop();
      _doSynthesizerStatusChangeLoop();
    }
    return _playing;
  }

  static final ValueNotifier<int> currentBeat = ValueNotifier(0);

  static bool _isBeatScratchAudioAvailable;
  static bool get isSynthesizerAvailable {
    if(_isBeatScratchAudioAvailable == null) {
      _setupSynthesizerStatusChangeLoop();
      _doSynthesizerStatusChangeLoop();
    }
    return _isBeatScratchAudioAvailable;
  }
  static VoidCallback onCountInInitiated;
  static VoidCallback onSynthesizerStatusChange;
  static Function(String) onLoadScoreFromLink;
  static Function(String) onSectionSelected;
  static Function(Melody) onRecordingMelodyUpdated;
  static _setupSynthesizerStatusChangeLoop() {
    _isBeatScratchAudioAvailable = false;
    _playing = false;
  }
  static _doSynthesizerStatusChangeLoop() {
    Future.delayed(Duration(seconds:5), () {
      _checkBeatScratchAudioStatus();
      getApps?.call();
      _doSynthesizerStatusChangeLoop();
    });
  }
  static final ValueNotifier<Iterable<int>> pressedMidiControllerNotes = ValueNotifier([]);


  static List<MidiController> connectedControllers = [];
  static List<MidiController> get midiControllers => [
    MidiController()
      ..id = "keyboard"
      ..name = "Keyboard"
      ..enabled = true
  ] + connectedControllers + [
    MidiController()
      ..id = "colorboard"
      ..name = "Colorboard"
      ..enabled = true
  ];

  static VoidCallback getApps;
  static List<MidiSynthesizer> _connectedSynthesizers = [];
  static List<MidiSynthesizer> get midiSynthesizers {
    final connected = _connectedSynthesizers;
    if (supportsSynthesizerConfig) {
      return connected;
    }
    return [
      MidiSynthesizer()
        ..id = "internal"
        ..name = "BeatScratch\nAudio System"
        ..enabled = true
    ] + connected
      .where((it) => MyPlatform.isAndroid || MyPlatform.isDebug)
      .toList();
  }

  static bool get _supportsSynthesizerConfig =>
    _connectedSynthesizers.isNotEmpty && _connectedSynthesizers[0].id == 'internal';

  /// To add support for a platform in debug mode, have it return an "internal" synthesizer.
  /// To add that support in release mode, hardcode the appropriate [MyPlatform] check here.
  static bool get supportsSynthesizerConfig =>
    MyPlatform.isAndroid || (MyPlatform.isAndroid && _supportsSynthesizerConfig);

  static void _checkBeatScratchAudioStatus() async {
    bool resultStatus;
    if(kIsWeb) {
      resultStatus = context.callMethod('checkBeatScratchAudioStatus', []);
    } else {
      resultStatus = await _channel.invokeMethod('checkBeatScratchAudioStatus');
    }
    if(resultStatus == null) {
      print("Failed to retrieve Synthesizer Status from JS/Platform Channel");
      resultStatus = false;
    }
    _isBeatScratchAudioAvailable = resultStatus;
    onSynthesizerStatusChange?.call();
  }

  static void resetAudioSystem() async {
    _isBeatScratchAudioAvailable = false;
    onSynthesizerStatusChange?.call();
    if(kIsWeb) {
    } else {
      _channel.invokeMethod('resetAudioSystem');
    }
  }

  static void createScore(Score score) async {
    _pushScore(score, 'createScore', includeParts: true, includeSections: true);
  }

  static void updateSections(Score score) async {
    _pushScore(score, 'updateSections', includeParts: false, includeSections: true);
  }

  static void _pushScore(Score score, String remoteMethod, {bool includeParts = true, includeSections = true}) async {
//    print("invoking $remoteMethod");
    if(!includeParts) {
      score = score.clone().copyWith((it) { it.parts.clear(); });
    }
    if(!includeSections) {
      score = score.clone().copyWith((it) { it.sections.clear(); });
    }
//    print("invoking $remoteMethod");
    if(kIsWeb) {
//      print("invoking $remoteMethod as JavaScript with context $context");
      context.callMethod(remoteMethod, [ score.jsifyProto() ]);
    } else {
//      print("invoking $remoteMethod through Platform Channel $_channel");
      _channel.invokeMethod(remoteMethod, score.clone().writeToBuffer());
    }
  }

  static void setPlaybackMode(Playback_Mode mode) {
    if(kIsWeb) {
      context.callMethod('setPlaybackMode', [ mode.name ]);
    } else {
      _channel.invokeMethod('setPlaybackMode', (Playback()..mode = mode).writeToBuffer());
    }
  }

  static void createPart(Part part) {
    _pushPart(part, "createPart");
  }

  static void updatePartConfiguration(Part part) {
    _pushPart(part, "updatePartConfiguration");
  }

  /// Pushes or updates the [Part].
  static void _pushPart(Part part, String methodName, {bool includeMelodies = false}) async {
    if(!includeMelodies) {
      part = part.clone().copyWith((it) { it.melodies.clear(); });
    }

    if(kIsWeb) {
      context.callMethod(methodName, [ part.jsifyProto() ]);
    } else {
      _channel.invokeMethod(methodName, part.clone().writeToBuffer());
    }
  }

  static void setCurrentSection(Section section) async {
    if(kIsWeb) {
      context.callMethod('setCurrentSection', [ section?.id ]);
    } else {
      _channel.invokeMethod('setCurrentSection', section?.id);
    }
  }

  /// Assigns all external MIDI controllers to the given part.
  static void setKeyboardPart(Part part) async {
    if(kIsWeb) {
      context.callMethod('setKeyboardPar', [ part?.id ]);
    } else {
      _channel.invokeMethod('setKeyboardPart', part?.id);
    }
  }

  static void deletePart(Part part) async {
    if(kIsWeb) {
      context.callMethod('deletePart', [part.id]);
    } else {
      _channel.invokeMethod('deletePart', part.id);
    }
  }

  static void createMelody(Part part, Melody melody) async {
    if(kIsWeb) {
      context.callMethod('createMelody', [part.id, melody.jsifyProto()]);
    } else {
      await _channel.invokeMethod('newMelody', melody.clone().writeToBuffer());
      _channel.invokeMethod('registerMelody',
        (RegisterMelody()..melodyId=melody.id..partId=part.id).writeToBuffer());
    }
  }

  static void updateMelody(Melody melody) async {
    if(kIsWeb) {
      context.callMethod('updateMelody', [melody.jsifyProto()]);
    } else {
      _channel.invokeMethod('updateMelody', melody.clone().writeToBuffer());
    }
  }

  static void deleteMelody(Melody melody) async {
    if(kIsWeb) {
      context.callMethod('deleteMelody', [melody.id]);
    } else {
      _channel.invokeMethod('deleteMelody', melody.id);
    }
  }

  /// When set to null, disables recording. When set to a melody,
  /// any notes played while playback is running are to be recorded into this
  /// [Melody]. Implementation-wise: this is just done by passing the [Melody.id].
  /// This applies to notes played either with a physical MIDI controller on
  /// the native side or from [sendMIDI] in the plugin.
  static void setRecordingMelody(Melody melody) async {
    if(kIsWeb) {
      context.callMethod('setRecordingMelody', [ melody?.id ]);
    } else {
      _channel.invokeMethod('setRecordingMelody', melody?.id);
    }
  }

  /// Starts the playback thread
  static void play() async {
    if(kIsWeb) {
      context.callMethod('play', []);
    } else {
      _channel.invokeMethod('play');
    }
    _playing = true;
    onSynthesizerStatusChange?.call();
  }

  static void stop() async {
    if(kIsWeb) {
      context.callMethod('stop', []);
    } else {
      _channel.invokeMethod('stop');
    }
    _playing = false;
    onSynthesizerStatusChange?.call();
  }
  static void pause() async {
    if(kIsWeb) {
      context.callMethod('pause', []);
    } else {
      _channel.invokeMethod('pause');
    }
    _playing = false;
    onSynthesizerStatusChange?.call();
  }

  static void setBeat(int beat) async {
    currentBeat.value = beat;
    if(kIsWeb) {
      context.callMethod('setBeat', [beat]);
    } else {
      _channel.invokeMethod('setBeat', beat);
    }
  }

  /// CountIn beat timings are used to establish a starting tempo. Once *two* [countIn] beats
  /// are sent within the minimum beat window (30bpm, or 2s), a tempo is established in the BE.
  /// It is expected to continue playback at this point, with additional [tickBeat] or [countIn] calls
  /// updating the underlying tempo. [countInBeat] is expected to be < 0. Once the playback thread reaches
  /// the point that [countInBeat] == 0 - either "effectively" due to playback starting, or through a user
  /// tap on [tickBeat] to signify that the current beat is 0
  static void countIn(int countInBeat) async {
    print("Invoked countIn");
    if(kIsWeb) {
      context.callMethod('countIn', [countInBeat]);
    } else {
      _channel.invokeMethod('countIn', countInBeat);
    }
  }

  static void tickBeat() async {
    if(kIsWeb) {
      context.callMethod('tickBeat', []);
    } else {
      _channel.invokeMethod('tickBeat');
    }
  }

  static void playNote(int tone, int velocity, Part part) {
    ByteWriter writer = ByteWriter();
    NoteOnEvent()
      ..noteNumber = tone + 60
      ..velocity = velocity
      ..channel = part.instrument.midiChannel
      ..writeEvent(writer);
    sendMIDI(writer.buffer);
  }

  static void stopNote(int tone, int velocity, Part part) {
    ByteWriter writer = ByteWriter();
    NoteOffEvent()
      ..noteNumber = tone + 60
      ..velocity = velocity
      ..channel = part.instrument.midiChannel
      ..writeEvent(writer);
    sendMIDI(writer.buffer);
  }

  static void sendMIDI(List<int> bytes) async {
//    print("invoking sendMIDI");
    if(kIsWeb) {
//      print("invoking sendMIDI as JavaScript with context $context");
      context.callMethod('sendMIDI', bytes);
    } else {
//      print("invoking sendMIDI through Platform Channel $_channel");
      _channel.invokeMethod('sendMIDI', Uint8List.fromList(bytes));
    }
  }

  static Future<String> getScoreId() async => _channel.invokeMethod<String>("getScoreId");

  static Future<Melody> get recordedMelody async {
    final Uint8List rawData = await _channel.invokeMethod('getRecordedMelody');
    final Melody melody = Melody.fromBuffer(rawData);
    return melody;
  }

  static updateSynthesizerConfig(MidiSynthesizer synthesizer) async {
    if (supportsSynthesizerConfig) {
//    print("invoking sendMIDI");
      if(kIsWeb) {
//      print("invoking sendMIDI as JavaScript with context $context");
        context.callMethod('updateSynthesizerConfig', synthesizer.jsifyProto());
      } else {
//      print("invoking sendMIDI through Platform Channel $_channel");
        _channel.invokeMethod('updateSynthesizerConfig', synthesizer.clone().writeToBuffer());
      }
    }
  }

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}


