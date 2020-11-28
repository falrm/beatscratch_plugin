//
//  AKSamplerExtensions.swift
//  Runner
//
//  Created by Jon Latane on 4/8/20.
//  Copyright © 2020 The Flutter Authors. All rights reserved.
//

import Foundation
import AudioKit

extension AKSampler {
  open func loadSfzWithEmbeddedSpacesInSampleNames(folderPath: String, sfzFileName: String) {
    stopAllVoices()
    do {
      try unloadAllSamples()
    }  catch {
      AKLog("Failed to unload samples")
    }
    
    var lastPrefix: String = ""
    var lokey: Int32 = 0
    var hikey: Int32 = 127
    var pitch: Int32 = 60
    var lovel: Int32 = 0
    var hivel: Int32 = 127
    var sample: String = ""
    var loopmode: String = ""
    var loopstart: Float32 = 0
    var loopend: Float32 = 0
    
    func resetVars() {
      lokey = 0
      hikey = 127
      pitch = 60
      lovel = 0
      hivel = 127
      sample = ""
      loopstart = 0
      loopend = 0
    }
    
    let baseURL = URL(fileURLWithPath: folderPath)
    let sfzURL = baseURL.appendingPathComponent(sfzFileName)
    do {
      let data = try String(contentsOf: sfzURL, encoding: .ascii)
      let lines = data.components(separatedBy: .newlines)
      for line in lines {
        let trimmed = String(line.trimmingCharacters(in: .whitespacesAndNewlines))
        if trimmed == "" || trimmed.hasPrefix("//") {
          // ignore blank lines and comment lines
          continue
        }
        for token in trimmed.components(separatedBy: .whitespaces) {
          if token.hasPrefix("<global>") || token.hasPrefix("<group>") || token.hasPrefix("<region>") {
            if lastPrefix == "region" {
              try buildSample(baseURL: baseURL, lokey: lokey, hikey: hikey, pitch: pitch, lovel: lovel, hivel: hivel, sample: sample, loopmode: loopmode, loopstart: loopstart, loopend: loopend)
            }
            resetVars()
          } else if token.hasPrefix("key=") {
            pitch = Int32(token.components(separatedBy: "=")[1])!
            lokey = pitch
            hikey = pitch
          } else if token.hasPrefix("lokey") {
            lokey = Int32(token.components(separatedBy: "=")[1])!
          } else if token.hasPrefix("hikey") {
            hikey = Int32(token.components(separatedBy: "=")[1])!
          } else if token.hasPrefix("pitch_keycenter") {
            pitch = Int32(token.components(separatedBy: "=")[1])!
          } else if token.hasPrefix("lovel") {
            lovel = Int32(token.components(separatedBy: "=")[1])!
          } else if token.hasPrefix("hivel") {
            hivel = Int32(token.components(separatedBy: "=")[1])!
          } else if token.hasPrefix("loop_mode") {
            loopmode = token.components(separatedBy: "=")[1]
          } else if token.hasPrefix("loop_start") {
            loopstart = Float32(token.components(separatedBy: "=")[1])!
          } else if token.hasPrefix("loop_end") {
            loopend = Float32(token.components(separatedBy: "=")[1])!
          } else if token.hasPrefix("sample") {
            sample = trimmed.components(separatedBy: "sample=")[1].replacingOccurrences(of: "\\", with: "/")
          }
          
          if token.hasPrefix("<global>") {
            lastPrefix = "global"
          }
          if token.hasPrefix("<group>") {
            lastPrefix = "group"
          }
          if token.hasPrefix("<region>") {
            lastPrefix = "region"
          }
        }
        
        //                if sample != "" {
        //                    buildSample(baseURL: baseURL, lokey: lokey, hikey: hikey, pitch: pitch, lovel: lovel, hivel: hivel, sample: sample, loopmode: loopmode, loopstart: loopstart, loopend: loopend)
        //                    sample = ""
        //                }
      }
      if(lastPrefix == "region") {
        try buildSample(baseURL: baseURL, lokey: lokey, hikey: hikey, pitch: pitch, lovel: lovel, hivel: hivel, sample: sample, loopmode: loopmode, loopstart: loopstart, loopend: loopend)
      }
    } catch {
      AKLog(error)
    }
    
    buildKeyMap()
    restartVoices()
  }

  open func buildSample(
    baseURL: URL,
    lokey: Int32,
    hikey: Int32,
    pitch: Int32,
    lovel: Int32,
    hivel: Int32,
    sample: String,
    loopmode: String,
    loopstart: Float32,
    loopend: Float32
  ) throws {
    let noteFreq = Float(AKPolyphonicNode.tuningTable.frequency(forNoteNumber: MIDINoteNumber(pitch)))
    AKLog("load \(pitch) \(noteFreq) Hz range \(lokey)-\(hikey) vel \(lovel)-\(hivel) \(sample)")
    
    let sd = AKSampleDescriptor(noteNumber: pitch,
                                noteFrequency: noteFreq,
                                minimumNoteNumber: lokey,
                                maximumNoteNumber: hikey,
                                minimumVelocity: lovel,
                                maximumVelocity: hivel,
                                isLooping: loopmode != "" && loopmode != "no_loop",
                                loopStartPoint: loopstart,
                                loopEndPoint: loopend,
                                startPoint: 0.0,
                                endPoint: 0.0)
    let sampleFileURL = baseURL.appendingPathComponent(sample)
    if sample.hasSuffix(".wv") {
      loadCompressedSampleFile(from: AKSampleFileDescriptor(sampleDescriptor: sd, path: sampleFileURL.path))
    } else {
      if sample.hasSuffix(".aif") || sample.hasSuffix(".wav") {
        let compressedFileURL = baseURL.appendingPathComponent(String(sample.dropLast(4) + ".wv"))
        let fileMgr = FileManager.default
        if fileMgr.fileExists(atPath: compressedFileURL.path) {
          loadCompressedSampleFile(from: AKSampleFileDescriptor(sampleDescriptor: sd, path: compressedFileURL.path))
        } else {
          let sampleFile = try AKAudioFile(forReading: sampleFileURL)
          loadAKAudioFile(from: sd, file: sampleFile)
        }
      }
    }
  }
}
