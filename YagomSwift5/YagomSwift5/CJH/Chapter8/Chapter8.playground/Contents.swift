import UIKit

// MARK: 옵셔널 사용
var myName: String = "yagom"
// 오류
//myName = nil

var myName2: String? = "yagom"
print(myName2)
myName2 = nil
print(myName2)

func checkOptionalValue(value optionalValue: Any?) {
    switch optionalValue {
    case .none:
        print("This Optional variable is nil")
    case .some(let value):
        print("Value is \(value)")
    }
}

myName2 = "yagom"
checkOptionalValue(value: myName2)

myName2 = nil
checkOptionalValue(value: myName2)

let numbers: [Int?] = [2, nil, -4, nil, 100]

for number in numbers {
    switch number {
    case .some(let value) where value < 0:
        print("Negative value!! \(value)")
    case .some(let value) where value > 10 :
        print("Large value!! \(value)")
    case .some(let value):
        print("Value \(value)")
    case .none:
        print("nil")
    }
}

// MARK: 옵셔널 추출
// 강제 추출
myName2 = "yagom"

var yagom: String = myName2!

myName2 = nil
// 오류
//yagom = myName2

if myName2 != nil {
    print("My name is \(myName2)")
} else {
    print("myName == nil")
}

// 옵셔널 바인딩
myName2 = "yagom"

if let name = myName2 {
    print("My name is \(name)")
} else {
    print("myName == nil")
}

if var name = myName2 {
    name = "wizplan"
    print("My name is \(name)")
} else {
    print("myName == nil")
}

myName2 = "yagom"
var yourName: String? = nil

if let name = myName2, let friend = yourName {
    print("We are friend! \(name) & \(friend)")
}

yourName = "eric"

if let name = myName2, let friend = yourName {
    print("We are friend! \(name) & \(friend)")
}

// 암시적 추출 옵셔널
var myName3: String! = "yagom"
print(myName3)
myName3 = nil

if let name = myName3 {
    print("My name is \(name)")
} else {
    print("myName == nil")
}
