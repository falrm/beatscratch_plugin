//
//  MelodyRecorder.swift
//  Runner
//
//  Created by Jon Latane on 5/3/20.
//  Copyright © 2020 The Flutter Authors. All rights reserved.
//

import Foundation
import QuartzCore
import AudioKit

extension Dictionary {
  mutating func processUpdate(_ key: Key, computation: (Value?) -> Value) {
    let oldValue = self[key]
    let newValue: Value = computation(oldValue)
    self[key] = newValue
  }
}

class MelodyRecorder {
  static let sharedInstance = MelodyRecorder()
  private init() {}
  var recordingMelodyId: String?
  var recordingMelody: Melody? {
    get {
      if recordingMelodyId == nil {
        return nil
      }
      return BeatScratchPlugin.sharedInstance.score.parts.flatMap { $0.melodies }.first { $0.id == recordingMelodyId }
    }
    set {
      if newValue != nil {
        if var part: Part = BeatScratchPlugin.sharedInstance.score.parts.first(where: { $0.melodies.contains { $0.id == recordingMelodyId } }) {
          part.melodies.removeAll { $0.id == newValue!.id }
          part.melodies.append(newValue!)
          BeatScratchPlugin.sharedInstance.score.parts.removeAll { $0.id == part.id }
          BeatScratchPlugin.sharedInstance.score.parts.append(part)
        }
      }
    }
  }
  
  private var recordingBeat: Int?
  private var beatStartTime: CFTimeInterval?
  var recordedData = Dictionary<CFTimeInterval, [UInt8]>()
  
  func notifyNotePlayed(note: MIDINoteNumber, velocity: MIDIVelocity, channel: MIDIChannel) {
    if recordingMelody != nil {
      let time = CACurrentMediaTime()
      recordedData.processUpdate(time) {
        var data = $0 ?? []
        data.append(0x90)
        data.append(note)
        data.append(velocity)
        return data
      }
    }
  }
  
  func notifyNoteStopped(note: MIDINoteNumber, channel: MIDIChannel) {
    if recordingMelody != nil {
      let time = CACurrentMediaTime()
      recordedData.processUpdate(time) {
        var data = $0 ?? []
        data.append(0x80)
        data.append(note)
        data.append(127)
        return data
      }
    }
  }
  
  func notifyBeatFinished() {
    if recordingMelodyId != nil {
      recordToMelody()
      beatStartTime = CACurrentMediaTime()
      recordingBeat = Int(Double(BeatScratchScorePlayer.sharedInstance.currentTick) / BeatScratchPlaybackThread.ticksPerBeat)
    }
  }
  
  private func recordToMelody() {
    if var melody = recordingMelody, let startTime = beatStartTime, let beat = recordingBeat {
      let endTime = CACurrentMediaTime()
      recordedData.forEach {
        let time: CFTimeInterval = $0.key
        let value: [UInt8] = $0.value
        let subdivisionsPerBeat = melody.subdivisionsPerBeat
        let length = melody.length
        let beatSize = (endTime - startTime) //* (Double(subdivisionsPerBeat + 1))/Double(subdivisionsPerBeat)
        let beatProgress = time - startTime
        let normalizedProgress = beatProgress/beatSize // Between 0-1 "maybe".
        var subdivision = Int32((normalizedProgress * Double(subdivisionsPerBeat)).rounded())
        subdivision += Int32(beat) * Int32(subdivisionsPerBeat)
        subdivision = (subdivision + Int32(length)) % Int32(length)
        
        melody.midiData.data.processUpdate(subdivision) {
          var change = $0 ?? MidiChange()
          change.data.append(contentsOf: value)
          return change
        }
      }
      recordingMelody = melody
      let verify = recordingMelody
      BeatScratchPlugin.sharedInstance.notifyRecordedMelody()
    }
    recordedData.removeAll()
  }
}
