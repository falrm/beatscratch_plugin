import 'package:unification/unification.dart';

import 'generated/protos/music.pb.dart';
import 'music_theory.dart';
import 'util.dart';


class NoteSpecification {
  final NoteName noteName;
  final int octave;
  int get tone => noteName.tone + (octave - 4) * 12;
  NoteLetter get letter => noteName.noteLetter;
  NoteSign get sign => noteName.noteSign;
  int get diatonicValue => 7 * octave + letter.value;
  String get uiString => "${noteName.noteLetter.name}${noteName.noteSign.simpleString}$octave";
  @override String toString() => "NoteSpecification:$uiString";

  NoteSpecification({this.noteName, this.octave});

  NoteSpecification.name({NoteLetter letter, NoteSign sign = NoteSign.natural, int octave})
    : this(
    noteName: (NoteName()
      ..noteLetter = letter
      ..noteSign = sign),
    octave: octave);

  @override bool operator ==(other) => other is NoteSpecification && noteName == other.noteName && octave == other.octave;
  @override int get hashCode => noteName.hashCode^octave.hashCode;
}

extension HeptatonicConversions on int {
  static final Map<int, List<NoteSpecification>> _notesFor = range(-4, 12).map((octave) =>
    NoteLetter.values.map((letter) =>
      NoteSign.values.map((sign) => NoteSpecification.name(letter: letter, sign: sign, octave: octave))
    )).expand((i) => i).expand((i) => i).toList().groupBy(((note) => note.tone));

  NoteSpecification get naturalOrSharpNote => _notesFor[this].firstWhere(
      (note) => note.sign == NoteSign.natural, orElse: () => null
  ) ?? _notesFor[this].firstWhere((note) => note.sign == NoteSign.sharp);

  static final Map<Chord, Map<int, NoteSpecification>> _noteNameChordCache = Map();
  NoteSpecification nameNoteUnderChord(Chord chord) {
    final result = _nameNoteUnderChord(chord);
    return result;
  }
  /*=> _noteNameChordCache
    .putIfAbsent(chord, () => Map())
    .putIfAbsent(this, () => _nameNoteUnderChord(chord));*/

  NoteSpecification _nameNoteUnderChord(Chord chord) {
    NoteName rootNote = chord.rootNote;
    int difference = (this - rootNote.tone).mod12;
    switch (difference) {
      case 0:
        return _notesFor[this].firstWhere((it) => it.letter == rootNote.letter);
      case 1:
        return _notesFor[this].firstWhere((it) => it.letter == rootNote.letter + 1); // m2
      case 2:
        return _notesFor[this].firstWhere((it) => it.letter == rootNote.letter + 1); // M2
      case 3:
        if(chord.hasAug2) {
          return _notesFor[this].firstWhere((it) => it.letter == rootNote.letter + 1); // A2
        } else {
          return _notesFor[this].firstWhere((it) => it.letter == rootNote.letter + 2); // m3
        }
        break;
      case 4:
        return _notesFor[this].firstWhere((it) => it.letter == rootNote.letter + 2); // M3
      case 5:
        return _notesFor[this].firstWhere((it) => it.letter == rootNote.letter + 3); // P4
      case 6:
        if (chord.hasAug4) {
          return _notesFor[this].firstWhere((it) => it.letter == rootNote.letter + 3); // A4
        } else {
          return _notesFor[this].firstWhere((it) => it.letter == rootNote.letter + 4); // d5
        }
        break;
      case 7:
        return _notesFor[this].firstWhere((it) => it.letter == rootNote.letter + 4); // P5
      case 8:
        if(chord.hasAug5) {
          return _notesFor[this].firstWhere((it) => it.letter == rootNote.letter + 4); // A5
        } else {
          return _notesFor[this].firstWhere((it) => it.letter == rootNote.letter + 5); // m6
        }
        break;
      case 9:
        if (chord.hasDim7) {
          return _notesFor[this].firstWhere((it) => it.letter == rootNote.letter + 5); // d7
        } else {
          return _notesFor[this].firstWhere((it) => it.letter == rootNote.letter + 5); // M6
        }
        break;
      case 10:
        if(chord.hasAug6) {
          return _notesFor[this].firstWhere((it) => it.letter == rootNote.letter + 5); // A6
        } else {
          return _notesFor[this].firstWhere((it) => it.letter == rootNote.letter + 6); // m7
        }
        break;
      case 11:
        if(rootNote.sign == NoteSign.double_sharp) {
          return _notesFor[this].firstWhere((it) => it.letter == rootNote.letter); // diminished 1 (for readability)
        } else {
          return _notesFor[this].firstWhere((it) => it.letter == rootNote.letter + 6); //M7
        }
        break;
      default:
        throw "impossible!";
    }
  }

  int playbackToneUnder(Chord chord, Melody melody) {
    if(melody.interpretationType != MelodyInterpretationType.fixed_nonadaptive) {
      int transposedTone = this + melody.offsetUnder(chord);
      return chord.closestTone(transposedTone);
    } else {
      return this;
    }
  }
}

const double unscaledStandardBeatWidth = 90.0;
abstract class MusicStaff {
  MusicStaff();

  String get id;
  Iterable<Part> getParts(Score score, List<MusicStaff> staffConfiguration);

  @override bool operator ==(other) => other is MusicStaff && id == other.id;
  @override int get hashCode => id.hashCode;
}

class PartStaff extends MusicStaff {
  Part part;
  PartStaff(this.part);
  @override
  String get id => "staff-part-${part.id}";
  @override
  Iterable<Part> getParts(Score score, List<MusicStaff> staffConfiguration) => [ part ];
}

class AccompanimentStaff extends MusicStaff {
  @override
  String get id => "accompaniment";
  @override
  Iterable<Part> getParts(Score score, Iterable<MusicStaff> staffConfiguration) => score.parts
    .where((part) => part.isHarmonic)
    .where((part) => // Don't display Parts listed elsewhere in the configuration.
  !staffConfiguration.any((staff) => staff is PartStaff && staff.part.id == part.id));
}

class DrumStaff extends MusicStaff {
  @override
  String get id => "drum";
  @override
  Iterable<Part> getParts(Score score, Iterable<MusicStaff> staffConfiguration) =>
    score.parts.where((part) => part.isDrum);
}