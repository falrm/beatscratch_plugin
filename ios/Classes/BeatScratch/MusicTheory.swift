//
//  MusicTheory.swift
//  Runner
//
//  Created by Jon Latane on 4/30/20.
//  Copyright © 2020 The Flutter Authors. All rights reserved.
//

import Foundation

extension MelodyReference {
  func melodyFrom(_ score: Score) -> Melody? {
    if let part = score.parts.first(where: { $0.melodies.contains { $0.id == self.melodyID}}) {
      return part.melodies.first { $0.id == self.melodyID }
    }
    return nil
  }
}

extension Harmony {
  func changeBefore(initialSubdivision: Int)-> Chord  {
    var subdivision = Int32(initialSubdivision)
    var result: Chord? = data[subdivision]
    while (result == nil) {
      subdivision -= 1
      if (subdivision < 0) {
        subdivision += Int32(length)
      }
      result = data[subdivision]
    }
    return result!;
  }
}
//
//val NoteLetter.tone: Int get() {
//  return when (this) {
//    NoteLetter.C -> {
//      0
//    }
//    NoteLetter.D -> {
//      2
//    }
//    NoteLetter.E -> {
//      4
//    }
//    NoteLetter.F -> {
//      5
//    }
//    NoteLetter.G -> {
//      7
//    }
//    NoteLetter.A -> {
//      9
//    }
//    NoteLetter.B -> {
//      11
//    }
//    else         -> {
//      throw FormatException()
//    }
//  }
//}
//
//
//val NoteSign.toneOffset: Int get() {
//  return when (this) {
//    NoteSign.natural      -> 0
//    NoteSign.sharp        -> 1
//    NoteSign.flat         -> -1
//    NoteSign.double_sharp -> 2
//    NoteSign.double_flat  -> -2
//    else                  -> throw FormatException()
//  }
//}
//
//
//val NoteName.tone: Int get() = noteLetter.tone + noteSign.toneOffset
//
//val NoteName.mod12: Int get() = tone.mod12
//
//fun Melody.offsetUnder(chord: Chord) = when {
//  interpretationType != MelodyInterpretationType.fixed_nonadaptive && interpretationType != MelodyInterpretationType.fixed_nonadaptive -> {
//    chord.rootNote.mod12.let { root ->
//      when {
//        root > 6 -> root - 12
//        else     -> root
//      }
//    }
//  }
//  else                                                                  -> 0
//}
//
//fun Int.playbackToneUnder(chord: Chord, melody: Melody): Int {
//  return if (melody.interpretationType !== MelodyInterpretationType.fixed_nonadaptive) {
//    val transposedTone: Int = this + melody.offsetUnder(chord)
//    chord.closestTone(transposedTone)
//  } else {
//    this
//  }
//}
//
//fun Chord.containsTone(tone: Int): Boolean {
//  var tone = tone
//  tone = tone.mod12
//  val root: Int = rootNote.tone
//  if (root == tone) {
//    return true
//  }
//  val difference = (tone - root).mod12 - 1
//  return chroma shr difference and 0x0001 == 1
//}
//
//fun Chord.closestTone(tone: Int): Int {
//  var result: Int? = null
//  (0..11).forEach { i ->
//    if (result == null) {
//      if (containsTone(tone - i)) {
//        result = tone - i
//      }
//      if (containsTone(tone + i)) {
//        result = tone + i
//      }
//    }
//  }
//  //    print("closest to $tone for ${this.toString().replaceAll("\n", "")} is $result");
//  return result ?: rootNote.tone
//}
