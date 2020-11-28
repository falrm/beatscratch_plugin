//
//  BeatScratchPlugin.swift
//  Runner
//
//  Created by Jon Latane on 4/18/20.
//  Copyright © 2020 The Flutter Authors. All rights reserved.
//

import Foundation
import AudioKit
#if canImport(FlutterMacOS)
import FlutterMacOS
#elseif canImport(Flutter)
import Flutter
#endif

class BeatScratchPlugin {
  // Globally accessible
  static let sharedInstance = BeatScratchPlugin()
  var score: Score = Score() {
    willSet {
      BeatScratchScorePlayer.sharedInstance.currentSection = newValue.sections.first {
        $0.id == BeatScratchScorePlayer.sharedInstance.currentSection.id
      } ?? newValue.sections.first!
    }
    didSet {
      notifyBeatScratchAudioAvailable()
//      score.parts.forEach {
//        setupPart(part: $0)
//      }
      notifyBeatScratchAudioAvailable()
    }
  }
  var channel: FlutterMethodChannel?
  
  private init() {}
  
  private var newMelodies: Array<Melody> = []

  func attach(channel: FlutterMethodChannel) {
    let conductor = Conductor.sharedInstance
    self.channel = channel
    channel.setMethodCallHandler { (call, result) in
      print("Call from Swift: " + call.method)
      do {
        switch call.method {
        case "sendMIDI":
          let data = (call.arguments as! FlutterStandardTypedData).data
          let args = [UInt8](data)
          var attacks = Array<BeatScratchScorePlayer.Attack>()
          let parsedBytes = conductor.parseMidi(args, record: true, attacks: &attacks)
          if parsedBytes > 0 {
            result(nil)
          } else {
            result(FlutterMethodNotImplemented)
          }
          break
        case "createScore", "updateSections":
          let score = try Score(serializedData: (call.arguments as! FlutterStandardTypedData).data)
          if call.method == "createScore" {
            self.score = score
            self.score.parts.forEach {
              self.setupPart(part: $0)
            }
          } else if call.method == "updateSections" {
            self.score.sections = score.sections
          }
          result(nil)
          break
        case "createPart", "updatePartConfiguration":
          var part = try Part(serializedData: (call.arguments as! FlutterStandardTypedData).data)
          self.setupPart(part: part)
          if call.method == "updatePartConfiguration" {
            if let existingPart = self.score.parts.first(where: {$0.id == part.id}) {
              do {
                try part.melodies = existingPart.melodies
                try self.score.parts.removeAll(where: {$0.id == part.id})
                try self.score.parts.append(part)
              } catch {
                print("updatePartConfiguration error: \(error)")
              }
              result(nil)
            } else {
              result(FlutterError(code: "500", message: "Part does not exist", details: "nope"))
            }
          } else {
            self.score.parts.append(part)
            result(nil)
          }
          break
        case "deletePart":
          let partId = call.arguments as! String
          self.score.parts.removeAll { $0.id == partId }
          result(nil)
          break
        case "newMelody":
          let melody = try Melody(serializedData: (call.arguments as! FlutterStandardTypedData).data)
          self.newMelodies.append(melody)
          result(nil)
          break
        case "registerMelody":
          let registerMelody = try RegisterMelody(serializedData: (call.arguments as! FlutterStandardTypedData).data)
          if let melody: Melody = self.newMelodies.first(where: { $0.id == registerMelody.melodyID }) {
            if var part: Part = self.score.parts.first(where: { $0.id == registerMelody.partID }) {
              part.melodies.append(melody)
              self.score.parts.removeAll { $0.id == part.id }
              self.score.parts.append(part)
              self.newMelodies.removeAll { $0.id == registerMelody.melodyID }
              result(nil)
            } else {
              result(FlutterError(code: "500", message: "Part must be added first", details: "nope"))
            }
          } else {
            result(FlutterError(code: "500", message: "Melody must be added first", details: "nope"))
          }
          break
        case "updateMelody":
          let melody = try Melody(serializedData: (call.arguments as! FlutterStandardTypedData).data)
          if var part: Part = self.score.parts.first(where:{
            $0.melodies.contains(where: { $0.id == melody.id })
          }) {
            part.melodies.removeAll { $0.id == melody.id }
            part.melodies.append(melody)
            self.score.parts.removeAll { $0.id == part.id }
            self.score.parts.append(part)
          } else {
            result(FlutterError(code: "500", message: "Melody not found in any Part", details: "nope"))
          }
          result(nil)
          break
        case "deleteMelody":
          let melodyId = call.arguments as! String
          self.score.parts.forEach {
            var part = $0
            part.melodies.removeAll { $0.id == melodyId }
            self.score.parts.removeAll { $0.id == part.id }
            self.score.parts.append(part)
          }
          result(nil)
          break
        case "setKeyboardPart":
          if let partId = call.arguments as? String {
            if let part = self.score.parts.first(where: {$0.id == partId}) {
              let channel = Int(part.instrument.midiChannel)
              BeatScratchMidiListener.sharedInstance.conductorChannel = channel
            }
          }
          result(nil)
          break
        case "checkBeatScratchAudioStatus":
          result(Conductor.sharedInstance.samplersInitialized)
          self.notifyMidiDevices()
          result(nil)
          break
        case "resetAudioSystem":
          Conductor.sharedInstance.initMidi()
          Conductor.sharedInstance.setupSamplersInBackground()
          result(nil)
          break
        case "play":
          BeatScratchPlaybackThread.sharedInstance.playing = true
          result(nil)
          break
        case "pause":
          BeatScratchPlaybackThread.sharedInstance.stopped = true
          result(nil)
          break
        case "stop":
          BeatScratchPlaybackThread.sharedInstance.stopped = true
          BeatScratchScorePlayer.sharedInstance.currentTick = 0
          result(nil)
          break
        case "setBeat":
          let beat = call.arguments as! Int
          Conductor.sharedInstance.stopPlayingNotes()
          BeatScratchScorePlayer.sharedInstance.currentTick = Int64(beat) * Int64( BeatScratchPlaybackThread.ticksPerBeat)
          result(nil)
          break
        case "setCurrentSection":
          let sectionId = call.arguments as! String
          if let section = self.score.sections.first(where: { $0.id == sectionId }) {
            BeatScratchScorePlayer.sharedInstance.currentSection = section
//            Conductor.sharedInstance.stopPlayingNotes()
            result(nil)
          } else {
            result(FlutterError(code: "500", message: "Section not found", details: "nope"))
          }
          break
        case "countIn":
//          let countInBeat = call.arguments as! Int
          BeatScratchPlaybackThread.sharedInstance.sendBeat()
          result(nil)
          break
        case "tickBeat":
          BeatScratchPlaybackThread.sharedInstance.sendBeat()
          result(nil)
          break
        case "setPlaybackMode":
          let playback: Playback = try Playback(serializedData: (call.arguments as! FlutterStandardTypedData).data)
          BeatScratchScorePlayer.sharedInstance.playbackMode = playback.mode
          result(nil)
          break
        case "setRecordingMelody":
          let melodyId: String? = call.arguments as! String?
          MelodyRecorder.sharedInstance.recordingMelodyId = melodyId
          result(nil)
          break
        case "setMetronomeEnabled":
          let metronomeEnabled: Bool = call.arguments as! Bool
          BeatScratchScorePlayer.sharedInstance.metronomeEnabled = metronomeEnabled
          result(nil)
          break
        case "setBpmMultiplier":
          let bpmMultiplier: Double = call.arguments as! Double
          BeatScratchPlaybackThread.sharedInstance.bpmMultiplier = bpmMultiplier
          result(nil)
          break
        default:
          result(FlutterMethodNotImplemented)
          break
        }
      } catch {
        print("Failed to process Platform Channel call in macOS. Error: " + error.localizedDescription)
        result(FlutterError())
      }
    }
  }
  
  func sendPressedMidiNotes() {
    do {
//      print("swift: sendPressedMidiNotes")
      var midiNotes = MidiNotes()
      midiNotes.midiNotes = BeatScratchMidiListener.sharedInstance.pressedNotes.map { UInt32($0) }
      channel?.invokeMethod("sendPressedMidiNotes", arguments: try midiNotes.serializedData())
    } catch {
      print("Failed to sendPressedMidiNotes: \(error)")
    }
  }
  
  func notifyRecordedMelody() {
    do {
      if let recordingMelody = MelodyRecorder.sharedInstance.recordingMelody {
        if recordingMelody.midiData.data.count > 0 {
          channel?.invokeMethod("notifyRecordedMelody", arguments: try recordingMelody.serializedData())
        }
      }
    } catch {
      print("Failed to notifyRecordedMelody: \(error)")
    }
  }
  
  func notifyBeatScratchAudioAvailable() {
    channel?.invokeMethod("notifyBeatScratchAudioAvailable", arguments: Conductor.sharedInstance.samplersInitialized)
  }
  
  func notifyPlayingBeat() {
    let beat: Int = Int(BeatScratchScorePlayer.sharedInstance.currentTick / Int64(BeatScratchPlaybackThread.ticksPerBeat))
    channel?.invokeMethod("notifyPlayingBeat", arguments: beat)
  }
  
  func notifyPaused() {
    channel?.invokeMethod("notifyPaused", arguments: nil)
  }

  func notifyCountInInitiated() {
    channel?.invokeMethod("notifyCountInInitiated", arguments: nil)
  }
  
  func notifyCurrentSection() {
    let section = BeatScratchScorePlayer.sharedInstance.currentSection
    channel?.invokeMethod("notifyCurrentSection", arguments: section.id)
  }
  
  func notifyStartedCurrentSection() {
    let section = BeatScratchScorePlayer.sharedInstance.currentSection
    channel?.invokeMethod("notifyStartedSection", arguments: section.id)
  }
  
  func notifyBpmMultiplier() {
    channel?.invokeMethod("notifyBpmMultiplier", arguments: BeatScratchPlaybackThread.sharedInstance.bpmMultiplier)
  }
  
  func notifyUnmultipliedBpm() {
    channel?.invokeMethod("notifyUnmultipliedBpm", arguments: BeatScratchPlaybackThread.sharedInstance.unmultipliedBpm)
  }
  
  func setupPart(part: Part) {
    Conductor.sharedInstance.setMIDIInstrument(channel: part.instrument.midiChannel, midiInstrument: part.instrument.midiInstrument)
    Conductor.sharedInstance.setVolume(channel: part.instrument.midiChannel, volume: Double(part.instrument.volume))
  }
  
  func openScoreFromUrl(_ url: String) {
    channel?.invokeMethod("openScoreFromUrl", arguments: url)
  }
  
  func notifyMidiDevices() {
    var midiDevices = MidiDevices()
    AKManager.midi.inputNames.filter { $0 != "MIDI Client" }.forEach {
      var controller = MidiController()
      controller.id = $0
      controller.name = $0
      midiDevices.controllers.append(controller)
    }
    
    var fakeSynth = MidiSynthesizer()
    fakeSynth.id = "internal"
    fakeSynth.name = "BeatScratch \nAudio System"
    fakeSynth.enabled = true
    midiDevices.synthesizers.append(fakeSynth)
    
    fakeSynth = MidiSynthesizer()
    fakeSynth.id = "placeholder"
    fakeSynth.name = "No Synths for AudioKit"
    fakeSynth.enabled = true
    midiDevices.synthesizers.append(fakeSynth)
    
    do {
      channel?.invokeMethod("notifyMidiDevices", arguments: try midiDevices.serializedData())
    } catch {
      print("Failed to notifyMidiDevices: \(error)")
    }
  }
}
