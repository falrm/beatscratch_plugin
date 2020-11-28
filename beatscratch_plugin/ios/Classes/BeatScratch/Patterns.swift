//
//  Patterns.swift
//  Runner
//
//  Created by Jon Latane on 4/30/20.
//  Copyright © 2020 The Flutter Authors. All rights reserved.
//

import Foundation

extension Int {
  var mod12: Int { return ((self % 12) + 12) % 12 }
  var mod12Nearest: Int {
    let it = mod12
    if it <= 6 {
      return it
    }
    return it - 12
  }
  func convertSubdivisionPosition(
    fromSubdivisionsPerBeat: Int,
    toSubdivisionsPerBeat: Int,
    toLength: Int = 10000000
  ) -> Int {
  // In the storageContext of the "from" melody, in, say, sixteenth notes (subdivisionsPerBeat=4),
  // if this is 5, then currentBeat is 1.25.
  let fromBeat: Double = Double(self) / Double(fromSubdivisionsPerBeat)
  
  let toLengthBeats: Double = Double(toLength) / Double(toSubdivisionsPerBeat)
  let positionInToPattern: Double = fromBeat.truncatingRemainder(dividingBy: toLengthBeats)
  
  // This candidate for attack is the closest element index to the current tick
  let result = floor(positionInToPattern * Double(toSubdivisionsPerBeat))
  return Int(result)
  }
  
  func convertSubdivisionPosition(
    fromMelody: Melody,
    toMelody: Melody
  ) -> Int {
    self.convertSubdivisionPosition(
      fromSubdivisionsPerBeat: Int(fromMelody.subdivisionsPerBeat),
      toSubdivisionsPerBeat: Int(toMelody.subdivisionsPerBeat)
    )
  }
  
  func convertSubdivisionPosition(
    fromMelody: Melody,
    toHarmony: Harmony
  ) -> Int {
    self.convertSubdivisionPosition(
      fromSubdivisionsPerBeat: Int(fromMelody.subdivisionsPerBeat),
      toSubdivisionsPerBeat: Int(toHarmony.subdivisionsPerBeat)
    )
  }
  
  func convertSubdivisionPosition(
    fromHarmony: Harmony,
    toMelody: Melody
  ) -> Int {
    self.convertSubdivisionPosition(
      fromSubdivisionsPerBeat: Int(fromHarmony.subdivisionsPerBeat),
      toSubdivisionsPerBeat: Int(toMelody.subdivisionsPerBeat)
    )
  }
  
  func convertSubdivisionPosition(
    fromHarmony: Harmony,
    toHarmony: Harmony
  ) -> Int {
    self.convertSubdivisionPosition(
      fromSubdivisionsPerBeat: Int(fromHarmony.subdivisionsPerBeat),
      toSubdivisionsPerBeat: Int(toHarmony.subdivisionsPerBeat)
    )
  }
}
