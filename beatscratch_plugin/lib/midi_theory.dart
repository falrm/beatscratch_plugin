import 'package:dart_midi/dart_midi.dart';
import 'package:dart_midi/src/byte_writer.dart';

import 'generated/protos/music.pb.dart';
import 'util.dart';

extension MidiEventFilters on Iterable<MidiEvent> {
  bool hasNoteOnEvent(int midiNote) =>
    any((it) => !(it is NoteOnEvent) || (it as NoteOnEvent).noteNumber != midiNote);
  bool hasNoteOffEvent(int midiNote) =>
    any((it) => !(it is NoteOnEvent) || (it as NoteOnEvent).noteNumber != midiNote);
  Iterable<MidiEvent> withoutNoteOnEvents(int midiNote) =>
    where((it) => !(it is NoteOnEvent) || (it as NoteOnEvent).noteNumber != midiNote);
  Iterable<MidiEvent> withoutNoteOffEvents(int midiNote) =>
    where((it) => !(it is NoteOffEvent) || (it as NoteOffEvent).noteNumber != midiNote);
}

extension MidiChangeTheory on MidiChange {
  Iterable<MidiEvent> get midiEvents {
    final args = ArgumentList((data ?? []).toList());
    try {
      return midiEventsCache.putIfAbsent(args,
          () => _midiEvents.toList());
    } catch (e) {
      print("midiEvents fail; args=${args.arguments}: $e");
      return _midiEvents;
    }
  }
  Iterable<MidiEvent> get _midiEvents {
    if(data == null || data.isEmpty) {
      return [];
    }
    var chunkedData = data.chunked(3);
    // Parser expects some dumb time bytes... we don't need em of course
    var fakeTrackData = chunkedData.expand((eventBytes) => [0,].followedBy(eventBytes));
    var result =  _parser.parseTrack(fakeTrackData.toList());
    return result;
  }
  set midiEvents(Iterable<MidiEvent> value) {
//    print("setting midiEvents to ${value}; data=$data");
    ByteWriter writer = ByteWriter();
    value.forEach((event) { event.writeEvent(writer); });
    data = writer.buffer;
//    print("done setting midiEvents; data1=${writer.buffer}");
//    print("done setting midiEvents; data=$data");
  }

  static final Map<ArgumentList, Iterable<MidiEvent>> midiEventsCache = Map();
  Iterable<NoteOnEvent> get noteOns => midiEvents
    .where((event) => event is NoteOnEvent)
    .map((event) => event as NoteOnEvent);
  Iterable<NoteOffEvent> get noteOffs => midiEvents
    .where((event) => event is NoteOffEvent)
    .map((event) => event as NoteOffEvent);
}

final MidiParser _parser = MidiParser();

extension MidiMelodies on Melody {
  setMidiDataFromSimpleMelody(Map<int, Iterable<int>> simpleData, {int simpleVelocity = 127}) {
    Map<int, MidiChange> convertedData = Map();
    List<MapEntry<int, Iterable<int>>> sortedData = simpleData.entries.toList()
      ..sort((e1, e2) => e1.key.compareTo(e2.key));
    Iterable<int> prevTones;
    sortedData.forEach((entry) {
      int key = entry.key;
      Iterable<int> tones = entry.value;
      List<MidiEvent> events = [];
      if(prevTones == null) {
        prevTones = sortedData.last.value;
      }
      events.addAll(prevTones.map((tone) =>
      NoteOffEvent()
        ..noteNumber = tone + 60
        ..velocity = 127
        ..channel = 0));
      events.addAll(tones.map((tone) => NoteOnEvent()
        ..noteNumber = tone + 60
        ..velocity = simpleVelocity
        ..channel = 0));
      convertedData[key] = MidiChange()..midiEvents = events;
      prevTones = tones;
    });
//    print("midiData: ${convertedData}");
    midiData = MidiData()..data.addAll(convertedData);
  }
}

const List<String> midiInstruments = [
  "Acoustic Grand Piano",
  "Bright Acoustic Piano",
  "Electric Grand Piano",
  "Honky-tonk Piano",
  "Electric Piano 1",
  "Electric Piano 2",
  "Harpsichord",
  "Clavi",
  "Celesta",
  "Glockenspiel",
  "Music Box",
  "Vibraphone",
  "Marimba",
  "Xylophone",
  "Tubular Bells",
  "Dulcimer",
  "Drawbar Organ",
  "Percussive Organ",
  "Rock Organ",
  "Church Organ",
  "Reed Organ",
  "Accordion",
  "Harmonica",
  "Tango Accordion",
  "Acoustic Guitar (nylon)",
  "Acoustic Guitar (steel)",
  "Electric Guitar (jazz)",
  "Electric Guitar (clean)",
  "Electric Guitar (muted)",
  "Overdriven Guitar",
  "Distortion Guitar",
  "Guitar harmonics",
  "Acoustic Bass",
  "Electric Bass (finger)",
  "Electric Bass (pick)",
  "Fretless Bass",
  "Slap Bass 1",
  "Slap Bass 2",
  "Synth Bass 1",
  "Synth Bass 2",
  "Violin",
  "Viola",
  "Cello",
  "Contrabass",
  "Tremolo Strings",
  "Pizzicato Strings",
  "Orchestral Harp",
  "Timpani",
  "String Ensemble 1",
  "String Ensemble 2",
  "SynthStrings 1",
  "SynthStrings 2",
  "Choir Aahs",
  "Voice Oohs",
  "Synth Voice",
  "Orchestra Hit",
  "Trumpet",
  "Trombone",
  "Tuba",
  "Muted Trumpet",
  "French Horn",
  "Brass Section",
  "SynthBrass 1",
  "SynthBrass 2",
  "Soprano Sax",
  "Alto Sax",
  "Tenor Sax",
  "Baritone Sax",
  "Oboe",
  "English Horn",
  "Bassoon",
  "Clarinet",
  "Piccolo",
  "Flute",
  "Recorder",
  "Pan Flute",
  "Blown Bottle",
  "Shakuhachi",
  "Whistle",
  "Ocarina",
  "Lead 1 (square)",
  "Lead 2 (sawtooth)",
  "Lead 3 (calliope)",
  "Lead 4 (chiff)",
  "Lead 5 (charang)",
  "Lead 6 (voice)",
  "Lead 7 (fifths)",
  "Lead 8 (bass + lead)",
  "Pad 1 (new age)",
  "Pad 2 (warm)",
  "Pad 3 (polysynth)",
  "Pad 4 (choir)",
  "Pad 5 (bowed)",
  "Pad 6 (metallic)",
  "Pad 7 (halo)",
  "Pad 8 (sweep)",
  "FX 1 (rain)",
  "FX 2 (soundtrack)",
  "FX 3 (crystal)",
  "FX 4 (atmosphere)",
  "FX 5 (brightness)",
  "FX 6 (goblins)",
  "FX 7 (echoes)",
  "FX 8 (sci-fi)",
  "Sitar",
  "Banjo",
  "Shamisen",
  "Koto",
  "Kalimba",
  "Bag pipe",
  "Fiddle",
  "Shanai",
  "Tinkle Bell",
  "Agogo",
  "Steel Drums",
  "Woodblock",
  "Taiko Drum",
  "Melodic Tom",
  "Synth Drum",
  "Reverse Cymbal",
  "Guitar Fret Noise",
  "Breath Noise",
  "Seashore",
  "Bird Tweet",
  "Telephone Ring",
  "Helicopter",
  "Applause",
  "Gunshot",
];