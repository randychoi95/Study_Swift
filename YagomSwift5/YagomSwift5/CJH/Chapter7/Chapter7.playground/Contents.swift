import UIKit

// MARK: 함수와 메서드
// 기본적인 함수의 정의와 호출
func hello(name: String) -> String {
    return "Hello \(name)!"
}

let helloJenny: String = hello(name: "Jenny")
print(helloJenny)

func introduce(name: String) -> String {
    "제 이름은 " + name + "입니다."
}

let introduceJenny: String = introduce(name: "Jenny")
print(introduceJenny)

// 매개변수가 없는 함수와 매개변수가 여러 개인 함수
func helloWorld() -> String {
    return "Hello, world!"
}

print(helloWorld())

func sayHello(myName: String, yourName: String) -> String {
    return "Hello \(yourName)! I'm \(myName)"
}
print(sayHello(myName: "yagom", yourName: "Jenny"))

// 매개변수 이름과 전달인자 레이블
func sayHello(from myName: String, to name: String) -> String {
    return "Hello \(name)! I'm \(myName)"
}

print(sayHello(from: "yagom", to: "Jenny"))

func sayHello(_ name: String, _ times: Int) -> String {
    var result: String = ""
    
    for _ in 0..<times {
        result += "Hello \(name)!" + " "
    }
    
    return result
}
print(sayHello("Chope", 2))

func sayHello(to name: String, _ times: Int) -> String {
    var result: String = ""
    
    for _ in 0..<times {
        result += "Hello \(name)!" + " "
    }
    
    return result
}
print(sayHello(to: "Chope", 2))

func sayHello(to name: String, repeatCount times: Int) -> String {
    var result: String = ""
    
    for _ in 0..<times {
        result += "Hello \(name)!" + " "
    }
    
    return result
}
print(sayHello(to: "Chope", repeatCount: 2))

// 매개변수 기본값
func sayHello(_ name: String, times: Int = 3) -> String {
    var result: String = ""
    
    for _ in 0..<times {
        result += "Hello \(name)!" + " "
    }
    
    return result
}

print(sayHello("Hana"))
print(sayHello("Joe", times: 2))

// 가벼 매개변수와 입출력 매개변수
func sayHelloToFriends(me: String, friends names: String...) -> String {
    var result: String = ""
    
    for friend in names {
        result += "Hello \(friend)!" + " "
    }
    
    result += "I'm " + me + "!"
    return result
}

print(sayHelloToFriends(me: "yagom", friends: "Johansson", "Jay", "wizplan"))
print(sayHelloToFriends(me: "yagom"))

var numbers: [Int] = [1,2,3]

func nonReferenceParameter(_ arr: [Int]) {
    var copiedArr: [Int] = arr
    copiedArr[1] = 1
}

func referenceParameter(_ arr: inout [Int]) {
    arr[1] = 1
}

nonReferenceParameter(numbers)
print(numbers[1])

referenceParameter(&numbers)
print(numbers[1])

// 반환이 없는 함수
func sayHelloWorld() {
    print("Hello, World!")
}
sayHelloWorld()

sayHello(from: "yagom", to: "Mijeong")

func sayGoodbye() -> Void {
    print("Good bye")
}
sayGoodbye()

// 데이터 타입으로서의 함수
// 스위프트의 함수는 일급 객체이므로 하나의 데이터 타입으로 사용할 수 있습니다.
typealias CalculateTwoInts = (Int, Int) -> Int

func addTwoInts(_ a: Int, _ b: Int) -> Int {
    return a + b
}

func multiplyTwoInts(_ a: Int, _ b: Int) -> Int {
    return a * b
}

var mathFunction: CalculateTwoInts = addTwoInts
print(mathFunction(2, 5))

mathFunction = multiplyTwoInts
print(mathFunction(2, 5))

func printMathResult(_ mathFunction: CalculateTwoInts, _ a: Int, _ b: Int) {
    print("Result: \(mathFunction(a, b))")
}
printMathResult(addTwoInts, 3, 5)

func chooseMathFunction(_ toAdd: Bool) -> CalculateTwoInts {
    return toAdd ? addTwoInts : multiplyTwoInts
}
printMathResult(chooseMathFunction(true), 3, 5)

// MARK: 중첩 함수
typealias MoveFunc = (Int) -> Int

func goRight(_ currentPosition: Int) -> Int {
    return currentPosition + 1
}

func goLeft(_ currentPosition: Int) -> Int {
    return currentPosition - 1
}

func functionForMove(_ shouldGoLeft: Bool) -> MoveFunc {
    return shouldGoLeft ? goLeft : goRight
}

var position: Int = 3

var moveToZero: MoveFunc = functionForMove(position > 0)
print("원접으로 갑시다")
while position != 0 {
    print("\(position)... ")
    position = moveToZero(position)
}
print("원점 도착!")

func functionForMove2(_ shouldGoLeft: Bool) -> MoveFunc {
    func goRight(_ currentPosition: Int) -> Int {
        return currentPosition + 1
    }

    func goLeft(_ currentPosition: Int) -> Int {
        return currentPosition - 1
    }
    
    return shouldGoLeft ? goLeft : goRight
}

position = -4

moveToZero = functionForMove2(position > 0)

while position != 0 {
    print("\(position)... ")
    position = moveToZero(position)
}
print("원점 도착!")

// MARK: 종료되지 않는 함수
func crashAndBurn() -> Never {
    fatalError("Something very, very bad happend")
}
//crashAndBurn()

func someFunction(isAllIsWell: Bool) {
    guard isAllIsWell else {
        print("마을에 도둑이 들었습니다.!")
        crashAndBurn()
    }
    print("All is well")
}
someFunction(isAllIsWell: true)
//someFunction(isAllIsWell: false)

// MAKR: 반환 값을 무시할 수 있는 함수
func say(_ something: String) -> String {
    print(something)
    return something
}

@discardableResult func discardableResultSay(_ something: String) -> String {
    print(something)
    return something
}

say("hello")

discardableResultSay("hello")
