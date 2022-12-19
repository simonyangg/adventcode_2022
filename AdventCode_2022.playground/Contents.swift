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

func listOfCombinations() -> [String] {
    var arrayOfCombinations = [String]()
        do {
            if let path = Bundle.main.path(forResource: "strategy_input", ofType: "txt") {
                let data = try String(contentsOfFile:path, encoding: String.Encoding.utf8)
                arrayOfCombinations = data.components(separatedBy: "\n")
            }
        } catch let err as NSError {
            print(err)
        }
    
    return arrayOfCombinations
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

// ABC
// XYZ

enum MatchResult {
    case win
    case draw
    case lose
    
    var value: Int {
        switch self {
        case .win: return 6
        case .draw: return 3
        case .lose: return 0
        }
    }
}

enum Selection: String {
    case Rock
    case Paper
    case Scissors
    
    var value: Int {
        switch self {
        case .Rock: return 1
        case .Paper: return 2
        case .Scissors: return 3
        }
    }
        
    static func selectionFrom(input: String?) -> Selection? {
        switch input {
        case "A": return .Rock
        case "B": return .Paper
        case "C": return .Scissors
        case "X": return .Rock
        case "Y": return .Paper
        case "Z": return .Scissors
        default: return nil
        }
    }
    
    static func matchresult(opponent1: Selection, opponent2: Selection) -> MatchResult {
        switch opponent1 {
        case .Rock:
            switch opponent2 {
            case .Rock:
                return MatchResult.draw
            case .Paper:
                return MatchResult.lose
            case .Scissors:
                return MatchResult.win
            }
        case .Paper:
            switch opponent2 {
            case .Rock:
                return MatchResult.win
            case .Paper:
                return MatchResult.draw
            case .Scissors:
                return MatchResult.lose
            }
        case .Scissors:
            switch opponent2 {
            case .Rock:
                return MatchResult.lose
            case .Paper:
                return MatchResult.win
            case .Scissors:
                return MatchResult.draw
            }
        }
    }
    
    static func valueForInput(combinationInput: String) -> Int {
        if let mySelection = Selection.selectionFrom(input: String(combinationInput.last ?? " ")),
           let opponentSelection = Selection.selectionFrom(input: String(combinationInput.first ?? " ")) {
            let matchResult = Selection.matchresult(opponent1: mySelection, opponent2: opponentSelection)
            let value = matchResult.value + mySelection.value
            return value
        }
        
        return 0
    }
    
    func opponent2Selection(opponent: String) -> Selection? {
        switch opponent {
        case "X": return .Rock
        case "Y": return .Paper
        case "Z": return .Scissors
        default: return nil
        }
    }
}

let arrayOfCombinations = listOfCombinations()
let resultsvalues = arrayOfCombinations.map { combination in
    return Selection.valueForInput(combinationInput: combination)
}

let finalresult = resultsvalues.reduce(0, +)
print("Day 2 Part 1 result is:\(finalresult)")

