import 'package:unification/unification.dart';

import 'generated/protos/music.pb.dart';
import 'midi_theory.dart';
import 'util.dart';

extension NoteLetterTheory on NoteLetter {
  int get tone {
    switch (this) {
      case NoteLetter.C:
        {
          return 0;
        }
      case NoteLetter.D:
        {
          return 2;
        }
      case NoteLetter.E:
        {
          return 4;
        }
      case NoteLetter.F:
        {
          return 5;
        }
      case NoteLetter.G:
        {
          return 7;
        }
      case NoteLetter.A:
        {
          return 9;
        }
      case NoteLetter.B:
        {
          return 11;
        }
      default:
        {
          throw FormatException();
        }
    }
  }

  NoteLetter operator +(int increment) =>
    NoteLetter.values.firstWhere(
        (letter) => letter.value == (value + increment) % 7
    );
}

extension NoteSignTheory on NoteSign {
  int get toneOffset {
    switch (this) {
//      case NoteSign.none: { return 0; }
      case NoteSign.natural:
        return 0;
      case NoteSign.sharp:
        return 1;
      case NoteSign.flat:
        return -1;
      case NoteSign.double_sharp:
        return 2;
      case NoteSign.double_flat:
        return -2;
      default:
        throw FormatException();
    }
  }

  String get simpleString {
    switch (this) {
//      case NoteSign.none: { return 0; }
      case NoteSign.natural:
        return "";
      case NoteSign.sharp:
        return "#";
      case NoteSign.flat:
        return "b";
      case NoteSign.double_sharp:
        return "##";
      case NoteSign.double_flat:
        return "bb";
      default:
        throw FormatException();
    }
  }
}

extension NoteTheory on NoteName {
  int get tone => noteLetter.tone + noteSign.toneOffset;

  int get mod12 => tone.mod12;

  NoteLetter get letter => noteLetter;

  NoteSign get sign => noteSign;

  String get simpleString => "${letter.name}${sign.simpleString}";
}

extension NoteConversions on int {
  bool get isBlackKey => mod12 == 1 || mod12 == 3 || mod12 == 6 || mod12 == 8 || mod12 == 10;
  bool get isWhiteKey => !isBlackKey;
  int get mod12 {
    int result = this;
    result = result % 12;
    while (result < 0) {
      result += 12;
    }
    return result;
  }
  int get mod7 {
    int result = this;
    result = result % 7;
    while (result < 0) {
      result += 7;
    }
    return result;
  }
}

extension PatternIndexConversions on int {
  int convertPatternIndex({int fromSubdivisionsPerBeat, int toSubdivisionsPerBeat, int toLength = 1000000000}) {
    // In the storageContext of the "from" melody, in, say, sixteenth notes (subdivisionsPerBeat=4),
    // if this is 5, then currentBeat is 1.25.
    double fromBeat = this.toDouble() / fromSubdivisionsPerBeat;

    double toLengthBeats = toLength.toDouble() / toSubdivisionsPerBeat;
    double positionInToPattern = fromBeat % toLengthBeats;

    // This candidate for attack is the closest element index to the current tick
    int result = (positionInToPattern * toSubdivisionsPerBeat).floor();
    return result;
  }
}

extension ChordTheory on Chord {
  bool has(int halfStepsFromRoot) => containsTone(rootNote.tone + halfStepsFromRoot);
  bool get hasMin2 => has(1);
  bool get hasMaj2 => has(2);
  bool get hasAug2 => has(3) && hasMaj3;
  bool get hasMin3 => has(3) && !hasMaj3;
  bool get hasMaj3 => has(4);
  bool get hasPer4 => has(5);
  bool get hasAug4 => has(6) && !hasDim5;
  bool get hasDim5 => has(6) && !hasPer5 && (hasMin3 || hasMaj3 || hasPer4 || (hasMin2 && hasMin7));
  bool get hasPer5 => has(7);
  bool get hasAug5 => has(8) && !hasPer5 && (hasMaj6 || hasMaj3 || (!hasDim5 && hasMaj6));
  bool get hasMin6 => (has(8) && !hasAug5);
  bool get hasMaj6 => has(9) && !(hasDim5 && hasMin3);
  bool get hasDim7 => has(9) && (hasDim5 && hasMin3);
  bool get hasAug6 => has(10) && hasMaj7;
  bool get hasMin7 => has(10) && !hasMaj7;
  bool get hasMaj7 => has(11);


  /// Returns the nearest
  int closestTone(int tone) {
    int result;
    range(0, 11).forEach((i) {
      if (result == null) {
        if (containsTone(tone - i)) {
          result = tone - i;
        }
        if (containsTone(tone + i)) {
          result = tone + i;
        }
      }
    });
    if(chroma != 2047) {
//      print("closest to $tone for ${this.toString().replaceAll("\n", "")} is $result");
    }
    return result ?? rootNote.tone;
  }

  bool containsTone(int tone) {
    tone = tone.mod12;
    int root = rootNote.tone;
    if (root == tone) {
      return true;
    }
    int difference = (tone - root).mod12;
    if ((chroma >> 11 - difference) & 0x0001 == 1) {
      return true;
    }
    return false;
  }
}

extension HarmonyTheory on Harmony {
  int get beatCount => length ~/ subdivisionsPerBeat;
  double get realBeatCount => length.toDouble() / subdivisionsPerBeat;

  static final Map<ArgumentList, Chord> changeBeforeCache = Map();
  Chord changeBefore(int subdivision) {
    final key = ArgumentList([subdivision, id]);
    return changeBeforeCache.putIfAbsent(key, () => _changeBefore(subdivision));
  }
  Chord _changeBefore(int subdivision) {
    final int initialSubdivision = subdivision;
    Chord result = data[subdivision];
    while (result == null) {
      subdivision = subdivision - 1;
      if (subdivision < 0) {
        subdivision += length;
      }
      result = data[subdivision];
    }
    return result;
  }
}

extension MelodyTheory on Melody {
  int get beatCount => length ~/ subdivisionsPerBeat;
  double get realBeatCount => length.toDouble() / subdivisionsPerBeat;
  Iterable<int> get tones => (type == MelodyType.midi)
    ? midiData.data.values.expand((it) => it.noteOns.map((e) => e.noteNumber - 60))
    : [];
  static final Map<String, double> averageToneCache = Map();
  double get averageTone => averageToneCache.putIfAbsent(id, () => _averageTone);
  double get _averageTone => tones.length == 0 ? 0 : tones.reduce((a, b) => a + b) / tones.length.toDouble();

  static final Map<ArgumentList, Iterable<int>> tonesAtCache = Map();
  Iterable<int> tonesAt(int elementPosition) {
    if(id == "keyboardDummy" || id == "colorboardDummy") {
      return _tonesAt(elementPosition);
    }
    final key = ArgumentList([id, elementPosition]);
    return tonesAtCache.putIfAbsent(key, () => _tonesAt(elementPosition));
  }
  Iterable<int> _tonesAt(int elementPosition) {
    if (type == MelodyType.midi) {
      final data = midiData.data[elementPosition];
      if(data == null) {
        return [];
      }
      final midiEvents = data.midiEvents;
      final convertedData = data.noteOns.map((e) => e.noteNumber - 60);
      return convertedData;
    } else {
      return []; // TODO: Audio rendering?
    }
  }


  static final Map<ArgumentList, Iterable<int>> noteOffsCache = Map();
  Iterable<int> noteOffsAt(int elementPosition) {
    if(id == "keyboardDummy" || id == "colorboardDummy") {
      return [];
    }
    final key = ArgumentList([id, elementPosition]);
    return noteOffsCache.putIfAbsent(key, () => _noteOffsAt(elementPosition));
  }
  Iterable<int> _noteOffsAt(int elementPosition) {
    if (type == MelodyType.midi) {
      final data = midiData.data[elementPosition];
      if(data == null) {
        return [];
      }
      final midiEvents = data.midiEvents;
      final convertedData = data.noteOffs.map((e) => e.noteNumber - 60);
      return convertedData;
    } else {
      return []; // TODO: Audio rendering?
    }
  }

  int measureStart(int elementPosition, Meter meter) {
    int beat = elementPosition ~/ subdivisionsPerBeat;
    while(beat % meter.defaultBeatsPerMeasure != 0) {
      beat -= 1;
    }
    return beat * subdivisionsPerBeat;
  }

  static final Map<ArgumentList, Iterable<int>> tonesInMeasureCache = Map();
  /// Returns only tone classes - i.e. everything is [NoteConversions.mod12],
  /// for all data within the measure at [elementPosition].
  Iterable<int> tonesInMeasure(int elementPosition, Meter meter) {
    int measureStart = this.measureStart(elementPosition, meter);
    if(id == "keyboardDummy" || id == "colorboardDummy") {
      return _tonesInMeasure(elementPosition, meter);
    }
    final key = ArgumentList([id, measureStart]);
    return tonesInMeasureCache.putIfAbsent(key, () => _tonesInMeasure(elementPosition, meter));
  }
  Iterable<int> _tonesInMeasure(int elementPosition, Meter meter) {
    if (type == MelodyType.midi) {
      Set<int> result = Set();
      int measureStart = this.measureStart(elementPosition, meter);
      range(measureStart, measureStart + meter.defaultBeatsPerMeasure * subdivisionsPerBeat).forEach((pos) {
        Iterable<int> tones = tonesAt(pos).map((i) => i.mod12);
        result.addAll(tones);
      });
      return result;
    } else {
      return []; // TODO: Audio rendering?
    }
  }

  int offsetUnder(Chord chord) {
    int result = 0;
    if (interpretationType != MelodyInterpretationType.fixed && interpretationType != MelodyInterpretationType.fixed_nonadaptive) {
      int root = chord.rootNote.tone.mod12;
      if (root > 6) {
        result = root - 12;
      } else {
        result = root;
      }
    }
    return result;
  }

  MidiChange midiChangeBefore(int subdivision) {
    final int initialSubdivision = subdivision;
    MidiChange result = midiData.data[subdivision];
    while (result == null) {
      subdivision = subdivision - 1;
      if (subdivision < 0) {
        subdivision += length;
      }
      result = midiData.data[subdivision];
    }
    return result;
  }
}

extension SectionTheory on Section {
  String get convenientName => (name.isEmpty) ? name : "Section ${id.substring(0, 5)}";
  double get realBeatCount => harmony.realBeatCount;
  int get beatCount => harmony.beatCount;

  MelodyReference referenceTo(Melody melody) =>
    (melody != null)
      ? melodies.firstWhere((element) => element.melodyId == melody.id, orElse: () => _defaultMelodyReference(melody))
      : null;

  MelodyReference _defaultMelodyReference(Melody melody) {
    var result = MelodyReference()
      ..melodyId = melody.id
      ..playbackType = MelodyReference_PlaybackType.disabled
      ..volume = 0.5;
    melodies.add(result);
    return result;
  }
}

extension Enabled on MelodyReference {
  bool get isEnabled => this.playbackType.value != MelodyReference_PlaybackType.disabled.value;
}

extension PartTheory on Part {
//  String get convenientName => (name.isEmpty) ? name : "Part ${id.substring(0, 5)}";
  bool get isDrum => instrument.type == InstrumentType.drum;
  bool get isHarmonic => instrument.type == InstrumentType.harmonic;
  String get midiName => isDrum ? "Drums" : midiInstruments[instrument.midiInstrument];
}

extension ScoreTheory on Score {
  double get realBeatCount => sections.fold(0, (p, s) => p + s.realBeatCount);
  int get beatCount => sections.fold(0, (p, s) => p + s.beatCount);

  Melody melodyReferencedBy(MelodyReference ref) =>
    parts.fold(null, (previousValue, part) =>
    previousValue ?? part.melodies.firstWhere(
        (melody) => melody.id == ref.melodyId,
      orElse: () => null
    )
    );
}
