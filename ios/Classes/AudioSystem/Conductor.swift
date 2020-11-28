//
//  Conductor
//  ROM Player
//
//  Created by Matthew Fecher on 7/20/17.
//  Copyright © 2017 AudioKit Pro. All rights reserved.

import Foundation
import AudioKit
import ExternalAccessory
#if canImport(FlutterMacOS)
let maxNonDrumChannels = 16
#elseif canImport(Flutter)
let maxNonDrumChannels = 5
#endif

class Conductor {
  // Globally accessible
  static let sharedInstance = Conductor()
  var samplersInitialized = false {
    didSet { BeatScratchPlugin.sharedInstance.notifyBeatScratchAudioAvailable() }
  }
  var sampler1 = AKSampler(masterVolume:1.0)
  var sampler2 = maxNonDrumChannels > 1 ? AKSampler(masterVolume:1.0) : nil
  var sampler3 = maxNonDrumChannels > 2 ? AKSampler(masterVolume:1.0) : nil
  var sampler4 = maxNonDrumChannels > 3 ? AKSampler(masterVolume:1.0) : nil
  var sampler5 = maxNonDrumChannels > 4 ? AKSampler(masterVolume:1.0) : nil
  var sampler6 = maxNonDrumChannels > 5 ? AKSampler(masterVolume:1.0) : nil
  var sampler7 = maxNonDrumChannels > 6 ? AKSampler(masterVolume:1.0) : nil
  var sampler8 = maxNonDrumChannels > 7 ? AKSampler(masterVolume:1.0) : nil
  var sampler9 = maxNonDrumChannels > 8 ? AKSampler(masterVolume:1.0) : nil
  var drumSampler = AKSampler(masterVolume:1.0)
  var sampler11 = maxNonDrumChannels > 9 ? AKSampler(masterVolume:1.0) : nil
  var sampler12 = maxNonDrumChannels > 10 ? AKSampler(masterVolume:1.0) : nil
  var sampler13 = maxNonDrumChannels > 11 ? AKSampler(masterVolume:1.0) : nil
  var sampler14 = maxNonDrumChannels > 12 ? AKSampler(masterVolume:1.0) : nil
  var sampler15 = maxNonDrumChannels > 13 ? AKSampler(masterVolume:1.0) : nil
  var sampler16 = maxNonDrumChannels > 14 ? AKSampler(masterVolume:1.0) : nil
  var channelSamplers: [UInt32: AKSampler] = [:]
  
  //    var decimator: AKDecimator
  //    var tremolo: AKTremolo
  //    var fatten: Fatten
  //    var filterSection: FilterSection
  //
  //    var autoPanMixer: AKDryWetMixer
  //    var autopan: AutoPan
  //
  //    var multiDelay: PingPongDelay
  //    var masterVolume = AKMixer()
  //    var reverb: AKCostelloReverb
  //    var reverbMixer: AKDryWetMixer
  let midi = AKManager.midi
//  var accessoryManager = EAAccessoryManager.shared()
  
//  func deviceConnected(notification: NSNotification) {
//    print("EAAccessoryManager device connected, creating BeatScratch Session")
//    midi.openInput(name: "BeatScratch Session")
//  }
  
  private init() {
    initMidi()
    
    // Session settings
    //AKAudioFile.cleanTempDirectory()
    AKSettings.bufferLength = .medium
    AKSettings.enableLogging = true
    
    midi.addListener(BeatScratchMidiListener.sharedInstance)
    
    // Set Output & Start AudioKit
    let mix = AKMixer(sampler1, sampler2, sampler3, sampler4, sampler5, drumSampler)
    AKManager.output = mix
    do {
      try AKManager.start()
    } catch {
      AKLog("AudioKit did not start")
    }
    
    setupSamplersInBackground()
  }
  
  func setupSamplersInBackground() {
    self.samplersInitialized = false
    DispatchQueue.global(qos: .userInitiated).async {
      self.setupSamplers()
      self.samplersInitialized = true
    }
  }
  
  func initMidi() {
    midi.closeAllInputs()
    midi.createVirtualPorts()
    midi.openInput()
    midi.openOutput()
    try BeatScratchPlugin.sharedInstance.notifyMidiDevices()
  }
  
  private func setupSamplers() {
    self.channelSamplers.merge(
      [
        0:  self.sampler1,
        1:  self.sampler2,
        2:  self.sampler3,
        3:  self.sampler4,
        4:  self.sampler5,
        5:  self.sampler6,
        6:  self.sampler7,
        7:  self.sampler8,
        8:  self.sampler9,
        9:  self.drumSampler,
        10: self.sampler11,
        11: self.sampler12,
        12: self.sampler13,
        13: self.sampler14,
        14: self.sampler15,
        15: self.sampler16,
      ].filter { $0.key == 9 || $0.key < maxNonDrumChannels }.mapValues { $0! },
      uniquingKeysWith: { (_, last) in last }
    )
    for (channel, sampler) in channelSamplers {
      if channel == 9 {
        setupSampler(sampler: sampler, fluidSample: "000_Standard")
      } else if channel == 0 {
        let instrument: UInt32 = channelInstruments[channel] ?? 0
        setupSampler(sampler: sampler, fluidSample: instrumentPatches[Int(instrument)])
      }
    }
  }
  
  private func setupSampler(sampler: AKSampler, fluidSample: String) {
    // Example (below) of loading compressed sample files without a SFZ file
    //loadAndMapCompressedSampleFiles()
    
    // Preferred method: use SFZ file
    loadSFZ(sampler: sampler, sfzFileName: fluidSample + ".sfz")
    
    
    // Set up the main amplitude envelope
    sampler.attackDuration = 0.01
    sampler.decayDuration = 0.1
    sampler.sustainLevel = 0.8
    sampler.releaseDuration = 0.5
    
    // optionally, enable the per-voice filters and set up the filter envelope
    // (Try this with the sawtooth waveform example above)
    //        sampler.filterEnable = true
    //        sampler.filterCutoff = 20.0
    //        sampler.filterAttackDuration = 1.0
    //        sampler.filterDecayDuration = 1.0
    //        sampler.filterSustainLevel = 0.5
    //        sampler.filterReleaseDuration = 10.0
    //        sampler.filterEnvelopeVelocityScaling = 1.0
  }
  
  private func loadSFZ(sampler: AKSampler, sfzFileName: String) {
    let folderPath = Bundle.main.resourcePath! + "/Sounds/sfz/fluid"
    print("Fluid R3 Resources are in " + folderPath)
    let info = ProcessInfo.processInfo
    let begin = info.systemUptime
    
    sampler.loadSfzWithEmbeddedSpacesInSampleNames(folderPath: folderPath,
                                                   sfzFileName: sfzFileName)
    
    let elapsedTime = info.systemUptime - begin
    AKLog("Time to load samples \(elapsedTime) seconds")
  }
  
  func addMidiListener(listener: AKMIDIListener) {
    midi.addListener(listener)
  }
  
  private var channelInstruments: Dictionary<UInt32, UInt32> = [
    0:0,1:0,2:0,3:0,4:0,5:0,6:0,7:0,8:0,9:0,10:0,11:0,12:0,13:0,14:0,15:0
  ]
  func setMIDIInstrument(channel: UInt32, midiInstrument: UInt32) {
    if channelInstruments[channel] != midiInstrument {
      self.samplersInitialized = false;
      DispatchQueue.global(qos: .userInitiated).async {
        self.setupSampler(sampler: self.channelSamplers[channel]!, fluidSample: instrumentPatches[Int(midiInstrument)])
        self.channelInstruments[channel] = midiInstrument
        self.samplersInitialized = true;
      }
    }
  }
  
  func setVolume(channel: UInt32, volume: Double) {
    self.channelSamplers[channel]?.masterVolume = volume
  }
  
  private let playingNotesAccess = DispatchSemaphore(value: 1)
  var playingNotes: Dictionary<MIDIChannel, Array<MIDINoteNumber>> = [
  0:[],1:[],2:[],3:[],4:[],5:[],6:[],7:[],8:[],9:[],10:[],11:[],12:[],13:[],14:[],15:[],]
  func playNote(note: MIDINoteNumber, velocity: MIDIVelocity, channel: MIDIChannel, record: Bool = false) {
    print("Conductor playNote, note=\(note), velocity=\(velocity), channel=\(channel), record=\(record)")
    do {
      playingNotesAccess.wait()
      var notes: Array<MIDINoteNumber>? = playingNotes[channel]
      if notes == nil {
        notes = Array()
      }
      notes!.append(note)
      playingNotes[channel] = notes
      playingNotesAccess.signal()
      try channelSamplers[UInt32(channel)]?.play(noteNumber: note, velocity: velocity)
      if(record) {
        try MelodyRecorder.sharedInstance.notifyNotePlayed(note: note, velocity: velocity, channel: channel)
      }
    } catch {
      print("playNote error: " + error.localizedDescription)
    }
  }
  
  func stopNote(note: MIDINoteNumber, channel: MIDIChannel, record: Bool = false) {
    print("Conductor stopNote, note=\(note), channel=\(channel), record=\(record)")
    do {
      playingNotesAccess.wait()
      var notes: Array<MIDINoteNumber>? = playingNotes[channel]
      if notes == nil {
        notes = Array()
      }
      notes!.removeAll { $0 == note }
      playingNotes[channel] = notes
      playingNotesAccess.signal()
      try channelSamplers[UInt32(channel)]?.stop(noteNumber: note)
      if(record) {
        try MelodyRecorder.sharedInstance.notifyNoteStopped(note: note, channel: channel)
      }
    } catch {
      print("stopNote error: " + error.localizedDescription)
    }
  }
  
  func stopPlayingNotes() {
    playingNotes.forEach {
      let channel = $0
      $1.forEach {
        let note = $0
        self.stopNote(note: note, channel: channel)
      }
    }
  }
  
  // Return the total number of bytes processed
  func parseMidi(_ midiData: [UInt8], channelOverride: UInt8? = nil, velocityMultiplier: Float = 1, record: Bool = false, playNoteOns: Bool = true, melodyId: String? = nil, attacks: inout Array<BeatScratchScorePlayer.Attack>) -> Int {
    var bytes = [UInt8](midiData)
    var bytesProcessed = Conductor.sharedInstance.parseFirstMidiCommand(bytes, channelOverride, velocityMultiplier, record, playNoteOns, melodyId, &attacks)
    var totalBytesProcessed = bytesProcessed
    while(bytes.count > bytesProcessed) {
      bytes.removeFirst(max(1,bytesProcessed))
      bytesProcessed = Conductor.sharedInstance.parseFirstMidiCommand(bytes, channelOverride, velocityMultiplier, record, playNoteOns, melodyId, &attacks)
      totalBytesProcessed += bytesProcessed
    }
    return totalBytesProcessed
  }
  
  // Return the number of bytes processed
  private func parseFirstMidiCommand(_ args: [UInt8], _ channelOverride: UInt8?, _ velocityMultiplier: Float, _ record: Bool, _ playNoteOns: Bool, _ melodyId: String?, _ attacks: inout Array<BeatScratchScorePlayer.Attack>) -> Int {
    if(args.count == 0) { return 0 }
    if((args[0] & 0xF0) == 0x90) { // noteOn
      if(playNoteOns) {
        let noteNumber = args[1]
        let velocity = MIDIVelocity(velocityMultiplier * Float(args[2]))
        let channel = channelOverride ?? args[0] & 0xF
        playNote(note: noteNumber, velocity: velocity, channel: channel, record: record)
        if(melodyId != nil) {
          let attack = BeatScratchScorePlayer.Attack(melodyId: melodyId, channel: channel, tone: noteNumber, velocity: velocity)
          attacks.append(attack)
        }
      }
      return 3
    } else if((args[0] & 0xF0) == 0x80) { // noteOff
      let noteNumber = args[1]
//      let velocity = MIDIVelocity(velocityMultiplier * Float(args[2]))
      let channel = channelOverride ?? args[0] & 0xF
      stopNote(note: noteNumber, channel: channel, record: record)
      return 3
    } else {
      print("unmatched MIDI bytes:");
      print(args);
      return 0
    }
  }
  
  func allNotesOff() {
    for note in 0 ... 127 {
      for(channel, _) in channelSamplers {
        stopNote(note: UInt8(note), channel: UInt8(channel))
      }
    }
  }
}

var drumPatch = "000_Standard"
var instrumentPatches = [
  "000_Grand Piano",
  // "000_Mellow Grand Piano",
  // "000_Standard",
  "001_Bright Grand Piano",
  // "001_Standard 1",
  "002_Electric Grand",
  // "002_Standard 2",
  "003_Honky-Tonk Piano",
  // "003_Standard 3",
  // "004_Detuned Tine EP",
  // "004_Standard 4",
  "004_Tine Electric Piano",
  // "005_Detuned FM EP",
  "005_FM Electric Piano",
  // "005_Standard 5",
  // "006_Coupled Harpsichord",
  "006_Harpsichord",
  // "006_Standard 6",
  "007_Clavinet",
  // "007_Standard 7",
  "008_Celesta",
  // "008_Room",
  "009_Glockenspiel",
  // "009_Room 1",
  "010_Music Box",
  // "010_Room 2",
  // "011_Room 3",
  "011_Vibraphone",
  "012_Marimba",
  // "012_Room 4",
  // "013_Room 5",
  "013_Xylophone",
  // "014_Church Bell",
  // "014_Room 6",
  "014_Tubular Bells",
  "015_Dulcimer",
  // "015_Room 7",
  // "016_Detuned Organ 1",
  "016_Drawbar Organ",
  // "016_Power",
  // "017_Detuned Organ 2",
  "017_Percussive Organ",
  // "017_Power 1",
  // "018_Power 2",
  "018_Rock Organ",
  // "019_Church Organ 2",
  "019_Church Organ",
  // "019_Power 3",
  "020_Reed Organ",
  "021_Accordion",
  // "021_Italian Accordion",
  "022_Harmonica",
  "023_Bandoneon",
  // "024_Electronic",
  "024_Nylon String Guitar",
  // "024_Ukulele",
  // "025_12-String Guitar",
  // "025_Mandolin",
  "025_Steel String Guitar",
  // "025_TR-808",
  // "026_Hawaiian Guitar",
  "026_Jazz Guitar",
  "027_Clean Guitar",
  "028_Funk Guitar",
  // "028_Palm Muted Guitar",
  "029_Overdrive Guitar",
  "030_Distortion Guitar",
  // "030_Feedback Guitar",
  // "031_Guitar Feedback",
  "031_Guitar Harmonics",
  "032_Acoustic Bass",
  // "032_Jazz",
  "033_Fingered Bass",
  // "033_Jazz 1",
  // "034_Jazz 2",
  "034_Picked Bass",
  "035_Fretless Bass",
  // "035_Jazz 3",
  // "036_Jazz 4",
  "036_Slap Bass",
  "037_Pop Bass",
  "038_Synth Bass 1",
  // "038_Synth Bass 3",
  "039_Synth Bass 2",
  // "039_Synth Bass 4",
  // "040_Brush",
  // "040_Slow Violin",
  "040_Violin",
  // "041_Brush 1",
  "041_Viola",
  // "042_Brush 2",
  "042_Cello",
  "043_Contrabass",
  "044_Tremolo Strings",
  "045_Pizzicato Strings",
  "046_Harp",
  "047_Timpani",
  // "048_Dry Strings",
  // "048_Orchestra Kit",
  // "048_Orchestral Pad",
  "048_Strings",
  "049_Slow Strings",
  "050_Synth Strings 1",
  // "050_Synth Strings 3",
  "051_Synth Strings 2",
  "052_Choir Aahs",
  "053_Voice Oohs",
  "054_Synth Voice",
  "055_Orchestra Hit",
  // "056_MarchingSnare",
  "056_Trumpet",
  // "057_OldMarchingBass",
  "057_Trombone",
  // "058_Marching Cymbals",
  "058_Tuba",
  "059_Harmon Mute Trumpet",
  // "059_NewMarchingBass",
  "060_French Horns",
  // "061_Brass 2",
  "061_Brass Section",
  "062_Synth Brass 1",
  // "062_Synth Brass 3",
  "063_Synth Brass 2",
  // "063_Synth Brass 4",
  "064_Soprano Sax",
  "065_Alto Sax",
  "066_Tenor Sax",
  "067_Baritone Sax",
  "068_Oboe",
  "069_English Horn",
  "070_Bassoon",
  "071_Clarinet",
  "072_Piccolo",
  "073_Flute",
  "074_Recorder",
  "075_Pan Flute",
  "076_Bottle Chiff",
  "077_Shakuhachi",
  "078_Whistle",
  "079_Ocarina",
  // "080_Sine Wave",
  "080_Square Lead",
  "081_Saw Lead",
  "082_Calliope Lead",
  "083_Chiffer Lead",
  "084_Charang",
  "085_Solo Vox",
  "086_5th Saw Wave",
  "087_Bass & Lead",
  "088_Fantasia",
  "089_Warm Pad",
  "090_Polysynth",
  "091_Space Voice",
  "092_Bowed Glass",
  "093_Metal Pad",
  "094_Halo Pad",
  // "095_OldMarchingTenor",
  "095_Sweep Pad",
  "096_Ice Rain",
  // "096_MarchingTenor",
  "097_Soundtrack",
  "098_Crystal",
  "099_Atmosphere",
  "100_Brightness",
  "101_Goblin",
  "102_Echo Drops",
  "103_Star Theme",
  "104_Sitar",
  "105_Banjo",
  "106_Shamisen",
  "107_Koto",
  // "107_Taisho Koto",
  "108_Kalimba",
  "109_Bagpipe",
  "110_Fiddle",
  "111_Shenai",
  "112_Tinker Bell",
  "113_Agogo",
  "114_Steel Drums",
  // "115_Castanets",
  // "115_Temple Blocks",
  "115_Woodblock",
  // "116_Concert Bass Drum",
  "116_Taiko Drum",
  // "117_Melo Tom 2",
  "117_Melodic Tom",
  // "118_808 Tom",
  "118_Synth Drum",
  "119_Reverse Cymbal",
  "120_Fret Noise",
  "121_Breath Noise",
  "122_Sea Shore",
  "123_Bird Tweet",
  "124_Telephone",
  "125_Helicopter",
  "126_Applause",
  "127_Gun Shot"
]
