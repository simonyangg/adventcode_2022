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
    return elphCalories.sum()
}

let resultMax = result.max()
    

print("Max is:\(String(describing: resultMax))")

extension Array where Element == Int {
    
    func sum() -> Int {
        return self.reduce(0, +)
    }
}
