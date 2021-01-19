// Expose the base Proto-generated models, JSON and BeatScratch URL conversions
export 'generated/protos/protos.dart';
export 'jsify_proto.dart';
export 'url_conversions.dart';

// Expose dart_midi directly for the developer
export 'package:dart_midi/dart_midi.dart';

// Useful extensions on the Proto-provided types.
// The idea is most of this sort of thing lives in Dart,
// with ports of algorithms needed for playback to Kotlin/Swift/JS
// as needed.
export 'music_theory.dart';
export 'music_notation_theory.dart';
export 'midi_theory.dart';

// The plugin itself is how the developer interacts with the BeatScratch Plugin. It can be
// thought of as a singleton that maintains and syncs state with a native realtime MIDI-based
// audio playback engine. We can send it Scores that have at least one Section with any number
// of Melodies (MIDI data enveloped in useful options etc.), set whether it's playing a Score
// or looping a Section, update Parts, add and update Melodies, delete, etc.
//
// Very much akin to a Web API except it has like, nanosecond-level latency. Additional APIs
// let us view (and on Android/ChromeOS, configure) MidiSynthesizers, MidiControllers, and more.
export 'main_plugin.dart';
