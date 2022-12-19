import UIKit

var greeting = "Hello, playground"

func caloriesValues() -> [[Int]] {
    var arrayOfStrings: [String]?
        do {
            if let path = Bundle.main.path(forResource: "calories_input", ofType: "txt") {
                let data = try String(contentsOfFile:path, encoding: String.Encoding.utf8)
                arrayOfStrings = data.components(separatedBy: "\n")
            }
        } catch let err as NSError {
            print(err)
        }
    var parsedArray = [[Int]]()
    var elphCaloriesArray = [Int]()
    arrayOfStrings?.forEach({ caloryString in
        if caloryString.count > 0 {
            elphCaloriesArray.append(Int(caloryString) ?? 0)
        } else {
            parsedArray.append(elphCaloriesArray)
            elphCaloriesArray.removeAll()
        }
    })
    
    return parsedArray
}

let parsedArray = caloriesValues()
let result = parsedArray.map { elphCalories in
    return elphCalories.reduce(0, +)
}

let day1Part1Answer = result.max()
print("Day1 part1 answer is:\(String(describing: (day1Part1Answer)))")

let sortedArray: [Int] = result.sorted { value1, value2 in
    return value1 > value2
}

let day1Part2Aswer = sortedArray.prefix(3).reduce(0, +)
print("Day1 part2 answer is:\(String(describing: (day1Part2Aswer)))")

