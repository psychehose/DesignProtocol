import Foundation

var numbers: [Int] = [1, 2, 3, 6, 9]

let modifiedNumbers = numbers
    .filter { number in
        print("Even number filter")
        return number % 2 == 0
    }.map { number -> Int in
        print("Doubling the number")
        return number * 2
    }
//
print(modifiedNumbers)

let modifiedLazyNumbers = numbers.lazy
     .filter { number in
         print("Lazy Even number filter")
         return number % 2 == 0
     }.map { number -> Int in
         print("Lazy Doubling the number")
         return number * 2
     }
//     .reduce(0) { partialResult, ele in
//       return partialResult + 1
//     }


print(modifiedLazyNumbers)
//print(modifiedLazyNumbers.first!)


