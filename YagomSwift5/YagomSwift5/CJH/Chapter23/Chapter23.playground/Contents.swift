import UIKit

// MARK: 프로토콜 지향 프로그래밍
// 익스텐션을 통한 프로토콜의 실제 구현
protocol Receiveable {
    func received(data: Any, from: Sendable)
}

extension Receiveable {
    // 메세지를 수신합니다.
    func received(data: Any, from: Sendable) {
        print("\(self) received \(data) from \(from)")
    }
}

// 무엇인가를 발신할 수 있는 기능
protocol Sendable {
    var from: Sendable { get }
    var to: Receiveable? { get }
    
    func send(data: Any)
    
    static func isSendableInstance(_ instance: Any) -> Bool
}

extension Sendable {
    // 발신은 발신 가능한 객체, 즉 Sendable 프로토콜을 준수하는 타입의 인스턴스여야 합니다.
    var from: Sendable {
        return self
    }
    
    // 메세지를 발신합니다.
    func send(data: Any) {
        guard let receiver: Receiveable = self.to else {
            print("Message has no receiver")
            return
        }
        
        // 수신 가능한 인스턴스의 received 메서드를 호출합니다.
        receiver.received(data: data, from: self.from)
    }
    
    static func isSendableInstance(_ instance: Any) -> Bool {
        if let sendableInstance: Sendable = instance as? Sendable {
            return sendableInstance.to != nil
        }
        return false
    }
}

// 수신, 발신이 가능한 Message 클래스
class Message: Sendable, Receiveable {
    var to: Receiveable?
}

// 수신, 발신이 가능한 Mail 클래스
class Mail: Sendable, Receiveable {
    var to: Receiveable?
}

// 두 Message 인스턴스를 생성합니다.
let myPhoneMessage: Message = Message()
let yourPhoneMessage: Message = Message()

// 아직 수신받을 인스턴스가 없습니다.
myPhoneMessage.send(data: "Hello")

// Message 인스턴스는 발신과 수신이 모두 가능하므로 메세지를 주고 받을 수 있습니다.
myPhoneMessage.to = yourPhoneMessage
myPhoneMessage.send(data: "Hello")

// Mail 인스턴스를 두 개 생성합니다.
let myMail: Mail = Mail()
let yourMail: Mail = Mail()

myMail.send(data: "Hi")

// Message와 Mail 모두 Sendable과 Receiveable 프로토콜을 준수하므로
// 서로 주고 받을 수 있습니다.
myMail.to = yourMail
myMail.send(data: "Hi")

myMail.to = yourPhoneMessage
myMail.send(data: "Bye")

// String은 Sendable 프로토콜을 준수하지 않습니다.
Message.isSendableInstance("Hello")

// Message와 Mail은 Sendable 프로토콜을 준수합니다.
Message.isSendableInstance(myPhoneMessage)

// yourPhoneMessage는 to 프로퍼티가 설정되지 않아서 보낼 수 없는 상태입니다.
Message.isSendableInstance(yourPhoneMessage) // -> to 프로퍼티가 설정되지 않아서 보낼 수 없는 상태입니다.
Mail.isSendableInstance(myPhoneMessage)
Mail.isSendableInstance(myMail)

// 익스텐션을 통해 구현된 메서드 재정의
class Mail2: Sendable, Receiveable {
    var to: Receiveable?
    
    func send(data: Any) {
        print("Mail의 send 메서드는 재정의되었습니다.")
    }
}

let mailInstance: Mail2 = Mail2()
mailInstance.send(data: "Hello")

// 제네릭, 프로토콜, 익스텐션을 통한 재사용
protocol SelfPrintable {
    func printSelf()
}

extension SelfPrintable where Self: Container {
    func printSelf() {
        print(items)
    }
}

protocol Container: SelfPrintable {
    associatedtype ItemType
    
    var items: [ItemType] { get set }
    var count: Int { get }
    
    mutating func append(item: ItemType)
    subscript(i: Int) -> ItemType { get }
}

extension Container {
    mutating func append(item: ItemType) {
        items.append(item)
    }
    
    var count: Int {
        return items.count
    }
    
    subscript(i: Int) -> ItemType {
        return items[i]
    }
}

protocol Popable: Container {
    mutating func pop() -> ItemType?
    mutating func push(_ item: ItemType)
}

extension Popable {
    mutating func pop() -> ItemType? {
        return items.removeLast()
    }
    
    mutating func push(_ item: ItemType) {
        self.append(item: item)
    }
}

protocol Insertable: Container {
    mutating func delete() -> ItemType?
    mutating func insert(_ item: ItemType)
}

extension Insertable {
    mutating func delete() -> ItemType? {
        return items.removeFirst()
    }
    
    mutating func insert(_ item:ItemType) {
        self.append(item: item)
    }
}

struct Stack<Element>: Popable {
    var items: [Element] = [Element]()
    
    func map<T>(transform: (Element) -> T) -> Stack<T> {
        var transformedStack: Stack<T> = Stack<T>()
        
        for item in items {
            transformedStack.items.append(transform(item))
        }
        
        return transformedStack
    }
    
    func filter(includeElement: (Element) -> Bool) -> Stack<Element> {
        var filteredStack: Stack<ItemType> = Stack<ItemType>()
        
        for item in items {
            if includeElement(item) {
                filteredStack.items.append(item)
            }
        }
        return filteredStack
    }
    
    func reduce<T>(_ initialResult: T, nextPartialResult: (T, Element) -> T) -> T {
    var result: T = initialResult
    
        for item in items {
            result = nextPartialResult(result, item)
        }
        
        return result
    }
}

struct Queue<Element>: Insertable {
    var items: [Element] = [Element]()
}

var myIntStack: Stack<Int> = Stack<Int>()
var myStringStack: Stack<String> = Stack<String>()
var myIntQueue: Queue<Int> = Queue<Int>()
var myStringQueue: Queue<String> = Queue<String>()

myIntStack.append(item: 3)
myIntStack.printSelf()

myIntStack.append(item: 2)
myIntStack.printSelf()

myIntStack.pop()
myIntStack.printSelf()

myStringStack.push("A")
myStringStack.printSelf()

myStringStack.push("B")
myStringStack.printSelf()

myStringStack.pop()
myStringStack.printSelf()

myIntQueue.insert(3)
myIntQueue.printSelf()

myIntQueue.insert(2)
myIntQueue.printSelf()

myIntQueue.delete()
myIntQueue.printSelf()

myStringQueue.insert("A")
myStringQueue.printSelf()

myStringQueue.insert("B")
myStringQueue.printSelf()

myStringQueue.delete()
myStringQueue.printSelf()

var myIntStack2: Stack<Int> = Stack<Int>()
myIntStack2.push(1)
myIntStack2.push(5)
myIntStack2.push(2)
myIntStack2.printSelf()
var myStrStack: Stack<String> = myIntStack2.map{ "\($0)" }
myStrStack.printSelf()

let filteredStack: Stack<Int> = myIntStack2.filter { (item: Int) -> Bool in
    return item < 5
}

filteredStack.printSelf()

let combinedInt: Int = myIntStack2.reduce(100) { (result: Int, next: Int) -> Int in
    return result + next
}

print(combinedInt)

let combinedDouble: Double = myIntStack2.reduce(100.0) { (result: Double, next: Int) -> Double in
    return result + Double(next)
}

print(combinedDouble)

let combinedString: String = myIntStack2.reduce("") { (result: String, next: Int) -> String in
    return result + "\(next) "
}

print(combinedString)

// MARK: 맵, 필터, 리듀스 직접 구현해보기
let items: Array<Int> = [1, 2, 3]

let mappedItems: Array<Int> = items.map { (item: Int) -> Int in
    return item * 10
}

print(mappedItems)

let filteredItems: Array<Int> = items.filter { (item: Int) -> Bool in
    return item % 2 == 0
}
print(filteredItems)

let combindedItems: Int = items.reduce(0) { (result: Int, next: Int) -> Int in
    return result + next
}

print(combindedItems)

let combinedItemsDoubled: Double = items.reduce(0.0) { (result: Double, next: Int) -> Double in
    return result + Double(next)
}

print(combinedItemsDoubled)

let combinedItemsString: String = items.reduce("") { (result: String, next: Int) -> String in
    return result + "\(next) "
}

print(combinedItemsString)

// MARK: 기본타입 확장
protocol SelfPrintable2 {
    func printSelf()
}

extension SelfPrintable2 {
    func printSelf() {
        print(self)
    }
}

extension Int: SelfPrintable2 { }
extension String: SelfPrintable2 { }
extension Double: SelfPrintable2 { }

1024.printSelf()
3.14.printSelf()
"hana".printSelf()
