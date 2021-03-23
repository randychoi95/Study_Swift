import UIKit

// MARK: 컨텍스트
// 컨텐츠를 담은 그 무엇인가
func addThree(_ num: Int) -> Int {
    return num + 3
}
addThree(2)

// MARK: 함수객체
Optional(2).map(addThree)

var value: Int? = 2
value.map{ $0 + 3 }
value = nil
value.map{ $0 + 3 }

// MARK: 모나드
func doubleEven(_ num: Int) -> Int? {
    if num.isMultiple(of: 2) {
        return num * 2
    }
    return nil
}
Optional(3).flatMap(doubleEven)

let optionals: [Int?] = [1, 2, nil, 5]

let mapped: [Int?] = optionals.map{ $0 }
let compactMapped: [Int] = optionals.compactMap { $0 }
print(mapped)
print(compactMapped)

let multipleContainer = [[1,2,Optional.none], [3,Optional.none], [4,5,Optional.none]]

let mappedMultipleCContainer = multipleContainer.map { $0.map { $0 }}
let flatmappedMultipleCContainer = multipleContainer.flatMap { $0.compactMap { $0 }}
print(mappedMultipleCContainer)
print(flatmappedMultipleCContainer)

func stringToInteger(_ string: String) -> Int? {
    return Int(string)
}

func integerToString(_ integer: Int) -> String? {
    return "\(integer)"
}

var optionalString: String? = "2"

let flattenResult = optionalString.flatMap(stringToInteger).flatMap(integerToString).flatMap(stringToInteger)
print(flattenResult)
let mappedResult = optionalString.map(stringToInteger)
print(mappedResult)

var result: Int?
if let string: String = optionalString {
    if let number: Int = stringToInteger(string) {
        if let finalString: String = integerToString(number) {
            if let finalNumber: Int = stringToInteger(finalString) {
                result = Optional(finalNumber)
            }
        }
    }
}
print(result)

if let string: String = optionalString,
    let number: Int = stringToInteger(string),
    let finalString: String = integerToString(number),
    let finalNumber: Int = stringToInteger(finalString) {
    result = Optional(finalNumber)
}
print(result)

func integerToNil(param: Int) -> String? {
    return nil
}

optionalString = "2"

result = optionalString.flatMap(stringToInteger).flatMap(integerToNil).flatMap(stringToInteger)
print(result)
