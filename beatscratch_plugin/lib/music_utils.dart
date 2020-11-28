import 'midi_theory.dart';
import 'package:dart_midi/dart_midi.dart';
import 'package:unification/unification.dart';
import 'package:dart_midi/src/byte_writer.dart';

import 'generated/protos/music.pb.dart';
import 'util.dart';

extension ScoreReKey on Score {
  reKeyMelodies({bool andParts: true}) {
    parts.forEach((part) {
      if (andParts) {
        part.id = uuid.v4();
      }
      part.melodies.forEach((melody) {
        String oldMelodyId = melody.id;
        String newMelodyId = uuid.v4();

        sections.forEach((section) {
          section.melodies.forEach((melodyReference) {
            if(melodyReference.melodyId == oldMelodyId) {
              melodyReference.melodyId = newMelodyId;
            }
          });
        });

        melody.id = newMelodyId;
      });
      part.id = uuid.v4();
    });
    sections.forEach((section) {
      section.id = uuid.v4();
    });
  }
}

extension Migrations on Score {
  migrate() {
    _setBpmsOnSections();
    _separateNoteOnAndOffs();
  }

  _setBpmsOnSections() {
    double firstSeenBpm;
    for (Section section in sections) {
      if (section.tempo != null && section.tempo.bpm != null) {
        firstSeenBpm = section.tempo.bpm;
        break;
      }
    }
    sections.forEach((section) {
      if (section.tempo == null || section.tempo.bpm == null) {
        section.tempo = Tempo()..bpm = firstSeenBpm ?? 123;
      }
    });
  }
  _separateNoteOnAndOffs() {
    parts.expand((p) => p.melodies).forEach((melody) {
      melody.separateNoteOnAndOffs();
    });
  }
}

extension DeleteNotes on Melody {
  deleteMidiNote(int midiNote, int subdivision) {
    // First delete the NoteOnEvent here
    midiData.data[subdivision].midiEvents = midiData.data[subdivision].midiEvents.withoutNoteOnEvents(midiNote);

    // Find the NoteOff that corresponds and delete it
    int s = subdivision;
    do {
      var foundNoteOff = false;
      var midiChange = midiData.data[s];
      if (midiChange != null) {
        final midiEvents = midiChange.midiEvents;
        if (midiEvents.hasNoteOnEvent(midiNote) != null) {
          midiChange.midiEvents = midiEvents.withoutNoteOffEvents(midiNote);
          foundNoteOff = true;
        }
      }
      if (foundNoteOff) {
        break;
      }
      s = (s + 1) % length;
    } while (s != subdivision);
  }

  deleteBeat(int beat) {
    var startSubdivision = (beat * subdivisionsPerBeat) % length;
    var subdivision = startSubdivision;
    do {
      var midiChange = midiData.data[subdivision];
      if (midiChange != null) {
        midiChange.noteOns.forEach((it) { deleteMidiNote(it.noteNumber, subdivision); });
      }
      subdivision = (subdivision + 1) % length;
    } while (subdivision != (startSubdivision + subdivisionsPerBeat) % length);
  }
}

extension DeleteEvent on MidiChange {
  // List<int> dataWithout(bool Function(MidiEvent) eventFilter) {
  //   ByteWriter writer = ByteWriter();
  //   midiEvents.forEach((midiEvent) {
  //     if (midiEvent is NoteOnEvent) {
  //       midiEvent.writeEvent(writer);
  //       noteOns.add(midiEvent.noteNumber);
  //     } else if (midiEvent is NoteOffEvent) {
  //       if (!noteOns.contains(midiEvent.noteNumber)) {
  //         midiEvent.writeEvent(writer);
  //       } else {
  //         madeChanges = true;
  //         midiEvent.writeEvent(nextWriter);
  //       }
  //     }
  //   });
  // }
}

extension SeparateNoteOnAndOff on Melody {
  bool separateNoteOnAndOffs() {
    bool madeChanges = false;
    if(type == MelodyType.midi) {
      midiData.data.keys.forEach((index) {
        MidiChange midiChange =  midiData.data[index];
        int nextIndex = (index < midiData.data.length - 1) ? index + 1 : 0;
        MidiChange nextMidiChange =  midiData.data[nextIndex] ?? MidiChange();

        ByteWriter writer = ByteWriter();
        ByteWriter nextWriter = ByteWriter();

        List<int> noteOns = List();

        midiChange.midiEvents.forEach((midiEvent) {
          if (midiEvent is NoteOnEvent) {
            midiEvent.writeEvent(writer);
            noteOns.add(midiEvent.noteNumber);
          } else if (midiEvent is NoteOffEvent) {
            if (!noteOns.contains(midiEvent.noteNumber)) {
              midiEvent.writeEvent(writer);
            } else {
              madeChanges = true;
              midiEvent.writeEvent(nextWriter);
            }
          }
        });

        nextWriter.buffer.addAll(nextMidiChange.data ?? []);
        midiChange.data = writer.buffer;
        nextMidiChange.data = nextWriter.buffer;
      });
    }
    return madeChanges;
  }
}