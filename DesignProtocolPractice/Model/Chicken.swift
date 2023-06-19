//
//  Chicken.swift
//  DesignProtocolPractice
//
//  Created by 김호세 on 6/18/23.
//

import Foundation

struct Chicken: Animal {
  var isHungry: Bool

  func produce() -> Egg {
    return Egg()
  }
  func eat(_ food: Scratch) { }
}

struct Scratch: AnimalFeed {
  static func grow() -> Millet {
    return Millet()
  }
}

struct Millet: Crop {
  func harvest() -> Scratch {
    return Scratch()
  }
}
