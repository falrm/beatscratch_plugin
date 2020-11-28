//
//  Base24ConversionMap.swift
//  Runner
//
//  Created by Jon Latane on 4/30/20.
//  Copyright © 2020 The Flutter Authors. All rights reserved.
//

import Foundation

class Base24Conversion {
  static let map: Dictionary<Int, Array<Int>> = [
    1 : [0],
    2 : [0,12],
    3 : [0,8,16],
    4 : [0,6,12,18],
    5 : [0,5,10,14,19],
    6 : [0,4,8,12,16,20],
    7 : [0,3,7,10,14,17,21],
    8 : [0,3,6,9,12,15,18,21],
    9 : [0,3,5, 8,11,13, 16,19,21],
    10 :[0,2,5,7,10,12,14,17,19,22],
    11 :[0,2,4,7,9,11,13,15,17,19,22],
    12 :[0,2,4,6,8,10,12,14,16,18,20,22],
    13 : Array(Set(0...23).subtracting([2,4,6,8,10,12,14,16,18,20,22])),
    14 : Array(Set(0...23).subtracting([2,4,7,9,11,13,15,17,19,22])),
    15 : Array(Set(0...23).subtracting([2,5,7,10,12,14,17,19,22])),
    16 : Array(Set(0...23).subtracting([3,5, 8,11,13, 16,19,21])),
    17 : Array(Set(0...23).subtracting([3,6,9,12,15,18,21])),
    18 : Array(Set(0...23).subtracting([3,7,10,14,17,21])),
    19 : Array(Set(0...23).subtracting([4,8,12,16,20])),
    20 : Array(Set(0...23).subtracting([5,10,14,19])),
    21 : Array(Set(0...23).subtracting([6,12,18])),
    22 : Array(Set(0...23).subtracting([8, 16])),
    23 : Array(Set(0...23).subtracting([12])),
    24 : Array(0...23)
  ]
}
