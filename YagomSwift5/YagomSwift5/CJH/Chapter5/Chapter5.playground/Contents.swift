import UIKit

// MARK: 삼항 조건 연산자
var valueA: Int = 3
var valueB: Int = 5
var biggerValue: Int = valueA > valueB ? valueA : valueB

valueA = 0
valueB = -3
biggerValue = valueA > valueB ? valueA : valueB

var stringA: String = ""
var stringB: String = "String"
var resultValue: Double = stringA.isEmpty ? 1.0 : 0.0
resultValue = stringB.isEmpty ? 1.0 : 0.0

// MARK: 오버플로 연산자
var unsignedInteger: UInt8 = 0
//let errorUnderflowResult: UInt8 = unsignedInteger - 1
let underflowedValue: UInt8 = unsignedInteger &- 1
print(underflowedValue)

unsignedInteger = UInt8.max
//let errorOverflowResult: UInt8 = unsignedInteger + 1
let overflowedValue: UInt8 = unsignedInteger &+ 1
print(overflowedValue)

// MARK: 사용자 정의 연산자
// 전위 연산자 정의와 구현
prefix operator **

prefix func ** (value: Int) -> Int {
    return value * value
}

let minusFive: Int = -5
let sqrtMinusFive: Int = **minusFive

print(sqrtMinusFive)

prefix func ! (value: String) -> Bool {
    return value.isEmpty
}

var stringValue: String = "yagom"
var isEmptyString: Bool = !stringValue

print(isEmptyString)

stringValue = ""
isEmptyString = !stringValue

print(isEmptyString)

prefix operator ^^

prefix func ^^ (value: String) -> String {
    return value + " " + value
}

let resultString: String = ^^"yagom"
print(resultString)

// MARK: 후위 연산자 정의와 구현
postfix operator **

postfix func ** (value: Int) -> Int {
    return value + 10
}

let five: Int = 5
let fivePlusTen: Int = five**

print(fivePlusTen)

// 하나의 피연산자에 전위 연산과 후위 연산을 한 줄에 사용하게 되면 후위 연산을 먼저 수행합니다.
let sqrtFivePlusTen: Int = **five**
print(sqrtFivePlusTen)

// MARK: 중위 연산자 정의와 구현
infix operator ** : MultiplicationPrecedence

func ** (lhs: String, rhs: String) -> Bool {
    return lhs.contains(rhs)
}

let helloYagom: String = "Hello yagom"
let yagom: String = "yagom"
let isContainsYagom: Bool = helloYagom ** yagom
print(isContainsYagom)

class Car {
    var modelYear: Int?
    var modelName: String?
    
    static func == (lhs: Car, rhs: Car) -> Bool {
        return lhs.modelName == rhs.modelName
    }
}

struct SmartPhone {
    var company: String?
    var model: String?
    
    static func == (lhs: SmartPhone, rhs: SmartPhone) -> Bool {
        return lhs.model == rhs.model
    }
}

// Car 클래스의 인스턴스끼리 == 연산했을 때 modelName이 같다면 true를 반환
//func == (lhs: Car, rhs: Car) -> Bool {
//    return lhs.modelName == rhs.modelName
//}

// SmartPhone 구조체의 인스턴스끼리 == 연산했을 때 model이 같다면 true를 반환
//func == (lhs: SmartPhone, rhs: SmartPhone) -> Bool {
//    return lhs.model == rhs.model
//}

let myCar = Car()
myCar.modelName = "S"

let yourCar = Car()
yourCar.modelName = "S"

var myPhone = SmartPhone()
myPhone.model = "SE"

var yourPhone = SmartPhone()
yourPhone.model = "6"

print(myCar == yourCar)
print(myPhone == yourPhone)
