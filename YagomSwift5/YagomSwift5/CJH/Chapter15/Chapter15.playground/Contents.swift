import UIKit

// MARK: 맵
var numbers: [Int] = [0, 1, 2, 3, 4]

var doubleNumbers: [Int] = [Int]()
var strings: [String] = [String]()

// for 구문 사용
for number in numbers {
    doubleNumbers.append(number * 2)
    strings.append("\(number)")
}

print(doubleNumbers)
print(strings)

// map 메서드 사용
doubleNumbers = numbers.map({ (number: Int) -> Int in
    return number * 2
})

strings = numbers.map({ (number: Int) -> String in
    return "\(number)"
})

print(doubleNumbers)
print(strings)

doubleNumbers = numbers.map({ return $0 * 2 })
print(doubleNumbers)

doubleNumbers = numbers.map({ $0 * 2 })
print(doubleNumbers)

doubleNumbers = numbers.map { $0 * 2 }
print(doubleNumbers)

var evenNumbers: [Int] = [0, 2, 4, 6, 8]
var oddNumbers: [Int] = [0, 1, 3, 5, 7]
let multiplyTwo: (Int) -> Int = { $0 * 2 }

let doubledEvenNumbers = evenNumbers.map(multiplyTwo)
print(doubledEvenNumbers)

let doubledOddNumbers = oddNumbers.map(multiplyTwo)
print(doubledOddNumbers)

let alphabetDictionary: [String: String] = ["a":"A", "b":"B"]

var keys: [String] = alphabetDictionary.map { (tuple: (String, String)) ->
    String in
    return tuple.0
}

keys = alphabetDictionary.map{ $0.0 }

let values: [String] = alphabetDictionary.map{ $0.1 }
print(keys)
print(values)

var numberSet: Set<Int> = [1, 2, 3, 4, 5]
let resultSet = numberSet.map{ $0 * 2 }
print(resultSet)

let optionalInt: Int? = 3
let resultInt: Int? = optionalInt.map{ $0 * 2 }
print(resultInt)

let range: CountableClosedRange = (0...3)
let resultRange: [Int] = range.map{ $0 * 2}
print(resultRange)

// MARK: 필터
numbers = [0, 1, 2, 3, 4, 5]

evenNumbers = numbers.filter { (number: Int) -> Bool in
    return number % 2 == 0
}
print(evenNumbers)

let mappedNumbers: [Int] = numbers.map { $0 + 3}

evenNumbers = mappedNumbers.filter { (number: Int) -> Bool in
    return number % 2 == 0
}
print(evenNumbers)

// mappedNumbers를 굳이 여러 번 사용할 필요가 없다면 메서드를 체인처럼 연결하여 사용할 수 있습니다.
oddNumbers = numbers.map { $0 + 3 }.filter { $0 % 2 == 1 }
print(oddNumbers)

// MARK: 리듀스
numbers = [1, 2, 3]

// 첫 번째 형태인 reduce(_:_:)메서드의 사용

// 초깃값이 0이고 정수 배열의 모든 값을 더합니다.
var sum: Int = numbers.reduce(0) { (result: Int, next: Int) -> Int in
    print("\(result) + \(next)")
    return result + next
}
print(sum)

// 초깃값이 0이고 정수 배열의 모든 값을 뺍니다.
let subtract: Int = numbers.reduce(0, {(result: Int, next: Int) -> Int in
    print("\(result) - \(next)")
    return result - next
})
print(subtract)

// 초깃값이 3이고 정수 배열의 모든 값을 더합니다.
let sumFromThree: Int = numbers.reduce(3) {
    print("\($0) + \($1)")
    return $0 + $1
}
print(sumFromThree)

// 초깃값이 3이고 정수 배열의 모든 값을 뺍니다.
var subtractFromThree: Int = numbers.reduce(3) {
    print("\($0) - \($1)")
    return $0 - $1
}
print(subtractFromThree)

// 문자열 배열을 reduce(_:_:) 메서드를 이용해 연결시킵니다.
let names: [String] = ["Chope", "Jay", "Joker", "Nova"]

let reduceNames: String = names.reduce("yagom's friend : ") {
    return $0 + ", " + $1
}
print(reduceNames)

// 두 번째 형태인 reduce(into:_:) 메서드의 사용

// 초깃값이 0이고 정수 배열의 모든 값을 더합니다.
// 첫 번째 리듀스 형태와 달리 클로저의 값을 반환하지 않고 내부에서 직접 이전 값을 변경한다는 점이 다릅니다.
sum = numbers.reduce(into: 0, { (result: inout Int, next: Int) in
    print("\(result) + \(next)")
    result += next
})
print(sum)

// 초깃값이 3이고 정수 배열의 모든 값을 뺍니다.
// 첫 번째 리듀스 형태와 달리 클로저의 값을 반환하지 않고 내부에서 직접 이전 값을 변경한다는 점이 다릅니다.
subtractFromThree = numbers.reduce(into: 3, {
    print("\($0) - \($1)")
    $0 -= $1
})
print(subtractFromThree)

// 첫 번째 리듀스 형태와 다르기 때문에 다른 컨테이너에 값을 변경하여 넣어줄 수도 있습니다.
// 이렇게 하면 맵이나 필터와 유사한 형태로 사용할 수도 있습니다.
// 홀수는 걸러내고 짝수만 두 배로 변경하여 초깃값인 [1, 2, 3] 배열에 직접 연산합니다.
var doubledNumbers: [Int] = numbers.reduce(into: [1, 2]) { (result: inout [Int], next: Int) in
    print("result: \(result) next: \(next)")

    guard next.isMultiple(of: 2) else {
        return
    }
    
    print("\(result) append \(next)")
    
    result.append(next * 2)
}
print(doubledNumbers)

// 필터와 맵을 사용한 모습
doubleNumbers = [1,2] + numbers.filter{$0.isMultiple(of: 2)}.map{$0*2}
print(doubleNumbers)

// 이름을 모두 대문자로 변환하여 초깃값인 빈 배열에 직접 연산합니다.
var upperCasedNames: [String]
upperCasedNames = names.reduce(into: [], {
    $0.append($1.uppercased())
})
print(upperCasedNames)

// 맵을 사용한 모습
upperCasedNames = names.map { $0.uppercased() }
print(upperCasedNames)

numbers = [1, 2, 3, 4, 5, 6, 7]
var result: Int = numbers.filter{ $0.isMultiple(of: 2) }.map{ $0 * 3 }.reduce(0) { $0 + $1 }
print(result)

// for-in 구문 사용 시
result = 0

for number in numbers {
    guard number.isMultiple(of: 2) else {
        continue
    }
    
    result += number * 3
}
print(result)

// MARK: 맵, 필터, 리듀스의 활용
enum Gender {
    case male, female, unknown
}

struct Friend {
    let name: String
    let gender: Gender
    let location: String
    var age: UInt
}

var friends: [Friend] = [Friend]()
friends.append(Friend(name: "Yoobato", gender: .male, location: "발리", age: 26))
friends.append(Friend(name: "JiSoo", gender: .male, location: "시드니", age: 24))
friends.append(Friend(name: "JuHyun", gender: .male, location: "경기", age: 30))
friends.append(Friend(name: "JiYoung", gender: .female, location: "서울", age: 22))
friends.append(Friend(name: "SungHo", gender: .male, location: "충북", age: 20))
friends.append(Friend(name: "JungKi", gender: .unknown, location: "대전", age: 29))
friends.append(Friend(name: "YoungMin", gender: .male, location: "경기", age: 24))

// 서울 외의 지역에 거주하며 25세 이상인 친구
var resultFriend: [Friend] = friends.map {
    Friend(name: $0.name, gender: $0.gender, location: $0.location, age: $0.age + 1)
}

resultFriend = resultFriend.filter{ $0.location != "서울" && $0.age >= 25 }

let string: String = resultFriend.reduce("서울 외의 지역에 거주하며 25세 이상인 친구") { $0 + "\n" + "\($1.name) \($1.gender) \($1.location) \($1.age)세"}
print(string)
