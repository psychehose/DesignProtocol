//
//  Cow.swift
//  DesignProtocolPractice
//
//  Created by 김호세 on 6/18/23.
//

import Foundation


struct Cow: Animal {
  var isHungry: Bool

  func produce() -> Milk {
    return Milk()
  }

  func eat(_ food: Hay) { }
}

struct Hay: AnimalFeed {

  static func grow() -> Alfalfa {
    return Alfalfa()
  }

}

struct Alfalfa: Crop {
  func harvest() -> Hay {
    return Hay()
  }
}


