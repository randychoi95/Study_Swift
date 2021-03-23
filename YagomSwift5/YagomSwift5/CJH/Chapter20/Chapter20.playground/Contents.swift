import UIKit

// MARK: 프로토콜 요구사항
// 프로퍼티 요구
protocol SomeProtocol {
    var settableProperty: String { get set }
    var notNeedToBeSettableProperty: String { get }
}

protocol AnotherProtocol {
    static var someTypeProperty: Int { get set }
    static var anotherTypeProperty: Int { get }
}

protocol Sendable {
    var from: String { get }
    var to: String { get }
}

class Message: Sendable {
    var sender: String
    var from: String {
        return self.sender
    }
    var to: String
    
    init(sender: String, receiver: String) {
        self.sender = sender
        self.to = receiver
    }
}

class Mail: Sendable {
    var from: String
    var to: String
    
    init(sender: String, receiver: String) {
        self.from = sender
        self.to = receiver
    }
}

// 메서드 요구
// 무언가를 수신받을 수 있는 기능
protocol Receiveable {
    func received(data: Any, from: Sendable2)
}

// 무언가를 발신할 수 있는 기능
protocol Sendable2 {
    var from: Sendable2 { get }
    var to: Receiveable? { get }
    
    func send(data: Any)
    
    static func isSendableInstance(_ instance: Any) -> Bool
}

// 수신, 발신이 가능한 Message 클래스
class Message2: Sendable2, Receiveable {
    // 발신은 발신 가능한 객체, 즉 Sendable 프로토콜을 준수하는 티입의 인스턴스여야 합니다.
    var from: Sendable2 {
        return self
    }
    
    // 상대방은 수신 가능한 객체, 즉 Receiveable 프로토콜을 준수하는 타입의 인스턴스여야 합니다.
    var to: Receiveable?
    
    // 메시지를 발신합니다.
    func send(data: Any) {
        guard let receiver: Receiveable = self.to else {
            print("Message has no receicer")
            return
        }
        // 수신 가능한 인스턴스의 received 메서드를 호출합니다.
        receiver.received(data: data, from: self.from)
    }
    
    // 메시지를 수신합니다.
    func received(data: Any, from: Sendable2) {
        print("Message received \(data) from \(from)")
    }
    
    // class 메서드이므로 상속이 가능합니다.
    class func isSendableInstance(_ instance: Any) -> Bool {
        if let sendableInstance: Sendable2 = instance as? Sendable2 {
            return sendableInstance.to != nil
        }
        return false
    }
}

// 수신, 발신이 가능한 Mail 클래스
class Mail2: Sendable2, Receiveable {
    var from: Sendable2 {
        return self
    }
    
    var to: Receiveable?
    
    func send(data: Any) {
        guard let reveicer: Receiveable = self.to else {
            print("Mail has no receiver")
            return
        }
        reveicer.received(data: data, from: self.from)
    }
    
    func received(data: Any, from: Sendable2) {
        print("Mail received \(data) from \(from)")
    }
    
    // static 메서드이므로 상속이 불가능합니다.
    static func isSendableInstance(_ instance: Any) -> Bool {
        if let sendableInstance: Sendable2 = instance as? Sendable2 {
            return sendableInstance.to != nil
        }
        return false
    }
}

// 두 Message 인스턴스를 생성합니다.
let myPhoneMessage: Message2 = Message2()
let yourPhoneMessage: Message2 = Message2()

// 아직 수신받을 인스턴스가 없습니다.
myPhoneMessage.send(data: "Hello")

// Message 인스턴스를 발신과 수신이 모두 가능하므로 메세지를 주고 받을 수 있습니다.
myPhoneMessage.to = yourPhoneMessage
myPhoneMessage.send(data: "Hello")

// 두 Mail 인스턴스를 생성합니다.
let myMail: Mail2 = Mail2()
let yourMail: Mail2 = Mail2()

myMail.send(data: "Hi")

// Mail 과 Message 모두 Sendable과 Receiveable 프로토콜을 준수하므로
// 서로 주고 받을 수 있습니다.
myMail.to = yourMail
myMail.send(data: "Hi")

myMail.to = myPhoneMessage
myMail.send(data: "Bye")

// String은 Sendable 프로토콜을 준수하지 않습니다.
Message2.isSendableInstance("Hello")

// Mail과 Message는 Sendable 프로토콜을 준수합니다.
Message2.isSendableInstance(myPhoneMessage)

// yourPhoneMessage는 to 프로퍼티가 설정되지 않아서 보낼 수 없는 상태입니다.
Message2.isSendableInstance(yourPhoneMessage)
Mail2.isSendableInstance(myPhoneMessage)
Mail2.isSendableInstance(myMail)

// 가변 메서드 요구
protocol Resettable {
    mutating func reset()
}

class Person: Resettable {
    var name: String?
    var age: Int?
    
    func reset() {
        self.name = nil
        self.age = nil
    }
}

struct Point: Resettable {
    var x: Int = 0
    var y: Int = 0
    
    mutating func reset() {
        self.x = 0
        self.y = 0
    }
}

enum Direction: Resettable {
    case east, west, south, north, unknown
    
    mutating func reset() {
        self = Direction.unknown
    }
}

// 이니셜라이저 요구
protocol Named {
    var name: String { get }
    
    init(name: String)
}

struct Pet: Named {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

class Person2: Named {
    var name: String
    
    required init(name: String) {
        self.name = name
    }
}

final class Person3: Named {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

class School {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

class MiddleSchool: School, Named {
    required override init(name: String) {
        super.init(name: name)
    }
}

protocol Named2 {
    var name: String { get }
    
    init?(name: String)
}

struct Animal: Named2 {
    var name: String
    
    init!(name: String) {
        self.name = name
    }
}

struct Pet2: Named2 {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

class Person4: Named2 {
    var name: String
    
    required init(name: String) {
        self.name = name
    }
}

class School2: Named2 {
    var name: String
    
    required init?(name: String) {
        self.name = name
    }
}

// MARK: 프로토콜의 상속과 클래스 전용 프로토콜
protocol Readable {
    func read()
}

protocol Writeable {
    func wirte()
}

protocol ReadSpeakable: Readable {
    func speak()
}

protocol ReadWriteSpeakable: Readable, Writeable {
    func speak()
}

class SomeClass: ReadWriteSpeakable {
    func read() {
        print("Read")
    }
    
    func wirte() {
        print("Write")
    }
    
    func speak() {
        print("Speak")
    }
}

// 클래스 전용 프로토콜 정의
protocol ClassOnlyProtocol: class, Readable, Writeable {
    
}

class SomeClass2: ClassOnlyProtocol {
    func read() {
        
    }
    
    func wirte() {
        
    }
}

// MARK: 프로토콜 조합과 프로토콜 준수 확인
protocol Named3 {
    var name: String { get }
}

protocol Aged {
    var age: Int { get }
}

struct Person5: Named3, Aged {
    var name: String
    var age: Int
}

class Car: Named3 {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

class Truck: Car, Aged {
    var age: Int
    
    init(name: String, age: Int) {
        self.age = age
        super.init(name: name)
    }
}

func celebrateBirthday(to celebrator: Named3 & Aged) {
    print("Happy birthday \(celebrator.name)!! Now you are \(celebrator.age)")
}

let yagom: Person5 = Person5(name: "yagom", age: 99)
celebrateBirthday(to: yagom)

let myCar: Car = Car(name: "Boong Boong")
//celebrateBirthday(to: myCar) -> Aged를 충족시키지 못합니다

// 클래스 & 프로토콜 조합에서 클래스 타입은 한 타입만 조합할 수 있습니다.
//var someVariable: Car & Truck & Aged

// Car 클래스의 인스턴스 역할도 수행할 수 있고,
// Aged 프로토콜을 준수하는 이스턴스만 할당할 수 있습니다.
var someVariable: Car & Aged

// Truck 인스턴스는 Car 클래스 역할도 할 수 있고 Aged 프로토콜도 준수하므로 할당할 수 있습니다.
someVariable = Truck(name: "Truck", age: 5)

print(yagom is Named3)
print(yagom is Aged)

print(myCar is Named3)
print(myCar is Aged)

if let castedInstance: Named3 = yagom as? Named3 {
    print("\(castedInstance) is Named")
}

if let castedInstance: Aged = yagom as? Aged {
    print("\(castedInstance) is Aged")
}

if let castedInstance: Named3 = myCar as? Named3 {
    print("\(castedInstance) is Named")
}

//if let castedInstance: Named3 = myCar as? Aged {
//    print("\(castedInstance) is Aged")
//}

// MARK: 프로토콜의 선택적 요구
@objc protocol Moveable {
    func walk()
    @objc optional func fly()
}

// 걷기만 할 수 있는 호랑이
class Tiger: NSObject, Moveable {
    func walk() {
        print("Tiget walks")
    }
}

// 걷고 날 수 있는 새
class Bird: NSObject, Moveable {
    func walk() {
        print("Bird walks")
    }
    
    func fly() {
        print("Bird flys")
    }
}

let tiger: Tiger = Tiger()
let bird: Bird = Bird()

tiger.walk()
bird.walk()
bird.fly()

var moveableInstance: Moveable = tiger
moveableInstance.fly?()


moveableInstance = bird
moveableInstance.fly?()

// MARK: 프로토콜 변수와 상수
var someNamed: Named2 = Animal(name: "Animal")
someNamed = Pet2(name: "Pet")
someNamed = Person4(name: "Person")
someNamed = School2(name: "School")!
