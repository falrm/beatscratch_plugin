//
//  MidiProcessing.swift
//  Runner
//
//  Created by Jon Latane on 5/7/20.
//

import Foundation
import AudioKit

protocol MidiEvent {
  var eventByteCount: Int { get }
}

struct NoteOnEvent : MidiEvent {
  var midiNote: UInt8
  var velocity: UInt8
  var channel: UInt8
  var eventByteCount: Int { get { return 3 } }
}

struct NoteOffEvent : MidiEvent {
  var midiNote: UInt8
  var velocity: UInt8
  var channel: UInt8
  var eventByteCount: Int { get { return 3 } }
}

extension Data {
  var midiEvents: [MidiEvent] {
    get {
      let bytes = [UInt8](self)
      var result: [MidiEvent] = Array()
      var index = 0
      while index < bytes.count {
        if((bytes[index] & 0xF0) == 0x90) { // noteOn
          let noteNumber = bytes[index + 1]
          let velocity = bytes[index + 2]
          let channel = bytes[index] & 0xF
          result.append(NoteOnEvent(midiNote: noteNumber, velocity: velocity, channel: channel))
          index += 3
        } else if((bytes[0] & 0xF0) == 0x80) { // noteOff
          let noteNumber = bytes[index + 1]
          let velocity = bytes[index + 2]
          let channel = bytes[index] & 0xF
          result.append(NoteOffEvent(midiNote: noteNumber, velocity: velocity, channel: channel))
          index += 3
        } else {
          print("unmatched MIDI byte:");
          print(bytes[index]);
          index += 1
        }
      }
      
      return result
    }
  }
  
}
