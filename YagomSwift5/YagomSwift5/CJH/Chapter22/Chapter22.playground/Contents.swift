import UIKit

// MARK: 제네릭
prefix operator **

prefix func ** <T: BinaryInteger> (value: T) -> T {
    return value * value
}

let minusFive: Int = -5
let five: UInt = 5

let sqrtMinusFive: Int = **minusFive
let sqrtFive: UInt = **five

print(sqrtMinusFive)
print(sqrtFive)

// MARK: 제네릭 함수
func swapTwoValues<T>(_ a: inout T, _ b: inout T) {
    let temporaryA: T = a
    a = b
    b = temporaryA
}

var numberOne: Int = 5
var numberTwo: Int = 10
swapTwoValues(&numberOne, &numberTwo)
print("\(numberOne), \(numberTwo)")

var stringOne: String = "A"
var stringTwo: String  = "B"
swapTwoValues(&stringOne, &stringTwo)
print("\(stringOne), \(stringTwo)")


var anyOne: Any = 1
var anyTwo: Any = "Two"
swapTwoValues(&anyOne, &anyTwo)
print("\(anyOne), \(anyTwo)")

//swapTwoValues(&numberOne, &stringOne) -> 같은 타입끼리만 교환 가능

// MARK: 제네릭 타입
struct IntStack {
    var items = [Int]()
    mutating func push(_ item: Int) {
        items.append(item)
    }
    mutating func pop() -> Int {
        return items.removeLast()
    }
}

var integerStack: IntStack = IntStack()

integerStack.push(3)
print(integerStack.items)

integerStack.push(2)
print(integerStack.items)

integerStack.push(3)
print(integerStack.items)

integerStack.push(5)
print(integerStack.items)

integerStack.pop()
print(integerStack.items)

integerStack.pop()
print(integerStack.items)

integerStack.pop()
print(integerStack.items)

integerStack.pop()
print(integerStack.items)

struct Stack<Element> {
    var items = [Element]()
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        items.removeLast()
    }
}

var doubleStack: Stack<Double> = Stack<Double>()

doubleStack.push(1.0)
print(doubleStack.items)
doubleStack.push(2.0)
print(doubleStack.items)
doubleStack.pop()
print(doubleStack.items)

var stringStack: Stack<String> = Stack<String>()

stringStack.push("1")
print(stringStack.items)
stringStack.push("2")
print(stringStack.items)
stringStack.pop()
print(stringStack.items)

var anyStack: Stack<Any> = Stack<Any>()

anyStack.push(1.0)
print(anyStack.items)
anyStack.push("2")
print(anyStack.items)
anyStack.push(3)
print(anyStack.items)
anyStack.pop()
print(anyStack.items)

// MARK: 제네릭 타입 확장
extension Stack {
    var topElement: Element? {
        return self.items.last
    }
}

print(doubleStack.topElement)
print(stringStack.topElement)
print(anyStack.topElement)

// MARK: 타입 제약
func swapTwoValues<T: BinaryInteger>(_ a: inout T, _ b: inout T) where T: FloatingPoint {
    
}

struct Stack2<Element: Hashable> {
    
}

func substractTwoValue<T: BinaryInteger>(_ a: T, _ b: T) -> T {
    return a - b
}

func makeDictionaryWithTwoValue<Key: Hashable, Value>(key: Key, value: Value) -> Dictionary<Key, Value> {
    let dictionary: Dictionary<Key, Value> = [key: value]
    return dictionary
}

// MARK: 프로토콜의 연관 타입
protocol Container {
    associatedtype ItemType
    var count: Int { get }
    mutating func append(_ item: ItemType)
    subscript(i: Int) -> ItemType { get }
}

class MyContainer: Container {
    var items: Array<Int> = Array<Int>()
    
    var count: Int {
        return items.count
    }
    
    func append(_ item: Int) {
        items.append(item)
    }
    
    subscript(i: Int) -> Int {
        return items[i]
    }
}

struct Stack3<Element>: Container {
    // 기존 IntStack 구조체 구현
    var items = [Element]()
    mutating func push(_ item: Element) {
        items.append(item)
    }
    mutating func pop() -> Element {
        items.removeLast()
    }
    
    // Container 프로토콜 준수를 위한 구현
    mutating func append(_ item: Element) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Element {
        return items[i]
    }
}

// MARK: 제네릭 서브스크립트
extension Stack3 {
    subscript<Indices: Sequence>(indices: Indices) -> [Element] where Indices.Iterator.Element == Int {
        var result = [ItemType]()
        for index in indices {
            result.append(self[index])
        }
        return result
    }
}

var integerStack2: Stack3<Int> = Stack3<Int>()
integerStack2.append(1)
integerStack2.append(2)
integerStack2.append(3)
integerStack2.append(4)
integerStack2.append(5)

print(integerStack2[0...2])


