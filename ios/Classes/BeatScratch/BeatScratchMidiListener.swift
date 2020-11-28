//
//  MidiListener.swift
//  Runner
//
//  Created by Jon Latane on 4/22/20.
//  Copyright © 2020 The Flutter Authors. All rights reserved.
//

import Foundation
import AudioKit

class BeatScratchMidiListener : AKMIDIListener {
  static let sharedInstance = BeatScratchMidiListener()
  private init(){}
  private var controllerPressedNotes = Dictionary<MIDIUniqueID?, [MIDINoteNumber]>()
  var pressedNotes: [Int] {
    get {
      return [Int](controllerPressedNotes.values.flatMap { $0.map { Int($0) } })
    }
  }
  var conductorChannel: Int = 0

  let timeoutSeconds = 30
  private var lastEventWasNoteOn = false
  private var lastEventWasNoteOff = false
  private var lastEventNote: MIDINoteNumber = 0
  func receivedMIDINoteOn(noteNumber: MIDINoteNumber, velocity: MIDIVelocity, channel: MIDIChannel, portID: MIDIUniqueID? = nil, offset: MIDITimeStamp = 0) {
    if (lastEventWasNoteOn && lastEventNote == noteNumber) {
//      print("rejecting duplicate noteOn")
      return
    }
    print("received midi note on")
    lastEventWasNoteOn = true
    lastEventWasNoteOff = false
    lastEventNote = noteNumber
    Conductor.sharedInstance.playNote(note: noteNumber, velocity: velocity, channel: UInt8(conductorChannel), record: true)
    if !controllerPressedNotes.contains(where: { $0.key == portID }) {
      controllerPressedNotes[portID] = []
    }
    controllerPressedNotes[portID]!.append(noteNumber)
    BeatScratchPlugin.sharedInstance.sendPressedMidiNotes()
  }
  
  func receivedMIDINoteOff(noteNumber: MIDINoteNumber, velocity: MIDIVelocity, channel: MIDIChannel, portID: MIDIUniqueID? = nil, offset: MIDITimeStamp = 0) {
    if (lastEventWasNoteOff && lastEventNote == noteNumber) {
//      print("rejecting duplicate noteOff")
      return
    }
    print("received midi note off")
    lastEventWasNoteOff = true
    lastEventWasNoteOn = false
    lastEventNote = noteNumber
    Conductor.sharedInstance.stopNote(note: noteNumber, channel: UInt8(conductorChannel), record: true)
    controllerPressedNotes[portID]?.removeAll { $0 == noteNumber }
    BeatScratchPlugin.sharedInstance.sendPressedMidiNotes()
  }
  
  private var sustainDown = false
  func receivedMIDIController(_ controller: MIDIByte, value: MIDIByte, channel: MIDIChannel, portID: MIDIUniqueID?, offset: MIDITimeStamp) {
    print("receivedMIDIController: controller=\(controller), value=\(value), channel=\(channel), portID=\(String(describing: portID)), offset=\(offset)")
    switch controller {
      // Sustain Pedal
      case AKMIDIControl.damperOnOff.rawValue:
        if value >= 64 && !sustainDown {
          BeatScratchPlaybackThread.sharedInstance.sendBeat()
          sustainDown = true
        } else if value < 64 {
          sustainDown = false
        }
      // Mod Wheel
      //      case AKMIDIControl.modulationWheel.rawValue:
      //        DispatchQueue.main.async {
      //          self.modWheelPad.setVerticalValueFrom(midiValue: value)
      //        }
      default:
        break
    }
  }
  
  func receivedMIDIPropertyChange(propertyChangeInfo: MIDIObjectPropertyChangeNotification) {
    print(propertyChangeInfo)
    
    if propertyChangeInfo.objectType == MIDIObjectType.device {
      print("Device detected, opening input")
      Conductor.sharedInstance.initMidi()
    }
  }
  
  var lastPitchWheelValue: MIDIWord = 8192
  func receivedMIDIPitchWheel(_ pitchWheelValue: MIDIWord,
                              channel: MIDIChannel,
                              portID: MIDIUniqueID?,
                              offset: MIDITimeStamp) {
    print("receivedMIDIPitchWheel: \(pitchWheelValue)")
    if(lastPitchWheelValue == 8192 && pitchWheelValue != 8192) {
      BeatScratchPlaybackThread.sharedInstance.sendBeat()
    }
    lastPitchWheelValue = pitchWheelValue
  }
  
  func receivedMIDISystemCommand(_ data: [MIDIByte],
                                 portID: MIDIUniqueID?,
                                 offset: MIDITimeStamp) {
    print("receivedMIDISystemCommand: \(data)")
  }
  
  func receivedMIDISetupChange() {
    print("receivedMIDISetupChange")
  }


}
