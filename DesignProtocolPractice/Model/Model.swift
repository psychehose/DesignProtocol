//
//  Model.swift
//  DesignProtocolPractice
//
//  Created by 김호세 on 6/13/23.
//

import Foundation

protocol Animal {
  associatedtype CommodityType: Food
  associatedtype FeedType: AnimalFeed
  var isHungry: Bool { get }
  func produce() -> CommodityType
  func eat(_ food: FeedType)
}


struct Farm {
  var animals: [any Animal]
  var isLazy: Bool

  // Animal은 그냥 interface임  data Type이 아니다!.. 즉 컨크리트 타입이 아님.
  // 그래서 위에서처럼 선언할 수가 없는데. any type을 사용하면 마치 concrete 같이 사용할 수 있음
  // 이것을 type erasure 라고 함.
  // 실제 구현 타입이 있어야 하는데, protocol로 숨겨버렸으니까!!
  // any Food는 즉 upper bound임

  var hungryAnimals: some Collection<any Animal> {
    animals.lazy.filter(\.isHungry)
  }

  func produceCommodities() -> [any Food] {
    return animals.map { animal in
      animal.produce()
    }
  }

  func feedAnimals() {
    // 문제상황:
    // 닭은 Scratch을 먹어야 하고
    // 소는 Hay를 먹어야 한다.
    // 이때 animal.eat()에서 어떠한 방식으로 Parameter를 넘겨야할 지 문제.
    // Animal 프로토콜과 관련된 FeedTye의 upper bound는 'any AnimalFeed' 근데, any를 생각해봤을 때,
    // any AnimalFeed가 닭인 경우에 Grain Type, 소인 경우에 Hay Type을 정적으로 보장할 방법이 없음
    // 여기에서, Type erasure를 허용해서는 안된다.
    // existential any type을 unboxing 해야한다.
    // unboxing 하는 방법은 opaque some type을 take하는 함수를 호출한다.


    for animal in hungryAnimals {
      feedAnimal(animal)

      // 여기에서 animal은 animal instance임.
      // type erasure를 허용했기 때문에 animal instance겠지.
      // 근데 그니까 animal은 특정한 동물 인스탠스인데 정적으로
      // 이 동물이 Hay를 먹을 지 Scratcho를 먹을 지 보장할 수가 없어
      // 그래서 some Animal을 take 하는 함수를 호출해서 unboxing을 해야함
    }

  }

  private func feedAnimal(_ animal: some Animal) {
    let crop = type(of: animal).FeedType.grow()
    let feed = crop.harvest()
    animal.eat(feed)

  }

  func feedAll(_ animals: [some Animal] ) {

    for animal in animals {
      let crop = type(of: animal).FeedType.grow()
      let produce = crop.harvest()
      animal.eat(produce)

      print("\(animal) eats \(produce)")
    }
  }
  
}


protocol AnimalFeed {
  associatedtype CropType: Crop where CropType.FeedType == Self
  static func grow() -> CropType
}

protocol Crop {
  associatedtype FeedType: AnimalFeed where FeedType.CropType == Self
  func harvest() -> FeedType
}


protocol Food { }
struct Egg: Food { }
struct Milk: Food { }



extension Farm {
  var modifiedHungryAnimals: some Collection {
    animals.lazy.filter(\.isHungry)
  }

  var modifiedHungryAnimalsWithType: some Collection<any Animal> {
    animals.lazy.filter(\.isHungry)
  }

  var modifiedHungryAnimalsWithTypeWithTypeErasure: any Collection<any Animal> {
    if isLazy {
      return animals.lazy.filter(\.isHungry)
    } else {
      return animals.filter(\.isHungry)
    }
  }
}
