import UIKit

// MARK: 프로퍼티
// 저장 프로퍼티
struct CoordinatePoint {
    var x: Int
    var y: Int
}

let yagomPoint: CoordinatePoint = CoordinatePoint(x: 10, y: 5)

class Position {
    var point: CoordinatePoint
    let name: String
    
    init(name: String, currentPoint: CoordinatePoint) {
        self.name = name
        self.point = currentPoint
    }
}

let yagomPosition: Position = Position(name: "yagom", currentPoint: yagomPoint)

struct CoordinatePoint2 {
    var x: Int = 0
    var y: Int = 0
}

let yagomPoint2: CoordinatePoint2 = CoordinatePoint2()

let wizplanPoint: CoordinatePoint2 = CoordinatePoint2(x: 10, y: 5)

print("yagom's point : \(yagomPoint2.x), \(yagomPoint2.y)")
print("wizplan's point : \(wizplanPoint.x), \(wizplanPoint.y)")

class Position2 {
    var point: CoordinatePoint2 = CoordinatePoint2()
    var name: String = "Unknown"
}

let yagomPosition2: Position2 = Position2()

yagomPosition2.point = yagomPoint2
yagomPosition2.name = "yagom"

struct CoordinatePoint3 {
    var x: Int
    var y: Int
}

class Position3 {
    var point: CoordinatePoint3?
    let name: String
    
    init(name: String) {
        self.name = name
    }
}

let yagomPosition3: Position3 = Position3(name: "yagom")
yagomPosition3.point = CoordinatePoint3(x: 20, y: 10)


// 지연 저장 프로퍼티
struct CoordinatePoint4 {
    var x: Int = 0
    var y: Int = 0
}

class Position4 {
    lazy var point: CoordinatePoint4 = CoordinatePoint4()
    let name: String
    
    init(name: String) {
        self.name = name
    }
}

let yagomPosition4: Position4 = Position4(name: "yagom")
print(yagomPosition4.point)

// 연산 프로퍼티
struct CoordinatePoint5 {
    var x: Int
    var y: Int
    
    func oppositePoint() -> Self {
        return CoordinatePoint5(x: -x, y: -y)
    }
    
    mutating func setOppositePoint(_ opposite: CoordinatePoint5) {
        x = -opposite.x
        y = -opposite.y
    }
}

var yagomPosition5: CoordinatePoint5 = CoordinatePoint5(x: 10, y: 20)
print(yagomPosition5)

print(yagomPosition5.oppositePoint())

yagomPosition5.setOppositePoint(CoordinatePoint5(x: 15, y: 10))
print(yagomPosition5)

struct CoordinatePoint6 {
    var x: Int
    var y: Int
    
    var oppositePoint: CoordinatePoint6 {
        get {
            return CoordinatePoint6(x: -x, y: -y)
        }
        set(opposite) {
            x = -opposite.x
            y = -opposite.y
        }
    }
}

var yagomPosition6: CoordinatePoint6 = CoordinatePoint6(x: 10, y: 20)
print(yagomPosition6)
print(yagomPosition6.oppositePoint)
yagomPosition6.oppositePoint = CoordinatePoint6(x: 15, y: 10)
print(yagomPosition6)

// 프로퍼티 감시자
class Account {
    var credit: Int = 0 {
        willSet {
            print("잔액이 \(credit)원에서 \(newValue)원으로 변경될 예정입니다.")
        }
        didSet {
            print("잔액이 \(oldValue)에서 \(credit)원으로 변경되었습니다.")
        }
    }
    
    var dollarValue: Double {
        get{
            return Double(credit) / 1000.0
        }
        set {
            credit = Int(newValue * 1000)
            print("잔액을 \(newValue)달러로 변경 중입니다.")
        }
    }
}

class ForeignAcccount: Account {
    override var dollarValue: Double {
        willSet {
            print("잔액이 \(dollarValue)달러에서 \(newValue)달러로 변경될 예정입니다.")
        }
        didSet {
            print("잔액이 \(oldValue)달러에서 \(dollarValue)달러로 변경되었습니다.")
        }
    }
}

let myAccount: Account = Account()
myAccount.credit = 1000

let myAccount2: ForeignAcccount = ForeignAcccount()
myAccount2.credit = 1000
myAccount2.dollarValue = 2

// 전역변수와 지역변수
var wonInPocket: Int = 2000 {
    willSet {
        print("주머니의 돈이 \(wonInPocket)원에서 \(newValue)원으로 변경될 예정입니다.")
    }
    didSet {
        print("주머니의 돈이 \(oldValue)원에서 \(wonInPocket)원으로 변경되었습니다.")
    }
}

var dollarInPocket: Double {
    get {
        return Double(wonInPocket) / 1000.0
    }
    set {
        wonInPocket = Int(newValue * 1000)
        print("주머니의 달러를 \(newValue)달러로 변경 중입니다.")
    }
}

dollarInPocket = 3.5

// 타입 프로퍼티
class AClass {
    static var typeProperty: Int = 0
    
    var instanceProperty: Int = 0 {
        didSet {
            Self.typeProperty = instanceProperty + 100
        }
    }
    
    static var typeComputedProperty: Int {
        get{
            return typeProperty
        }
        set {
            typeProperty = newValue
        }
    }
}
AClass.typeProperty = 123

let classInstance: AClass = AClass()
classInstance.instanceProperty = 100

print(AClass.typeProperty)
print(AClass.typeComputedProperty)

class Account2 {
    static let dollarExchangeRate: Double = 1000.0
    
    var credit: Int = 0
    
    var dollarValue: Double {
        get{
            // Self.dollarExchangeRate는 Account2.dollarExchangeRate와 같은 표현입니다.
            return  Double(credit) / Self.dollarExchangeRate
        }
        set {
            credit = Int(newValue * Account2.dollarExchangeRate)
            print("잔액을 \(newValue)달러로 변경 중입니다.")
        }
    }
}

// 키 경로
class Person {
    var name: String
    
    init(name: String) {
        self.name = name
    }
}

struct Stuff {
    var name: String
    var owner: Person
}

print(type(of: \Person.name))
print(type(of: \Stuff.name))

let keyPath = \Stuff.owner
let nameKeyPath = keyPath.appending(path: \.name)
print(type(of: keyPath))
print(type(of: nameKeyPath))

let yagom = Person(name: "yagom")
let hana = Person(name: "hana")
let macbook = Stuff(name: "MacBook Pro", owner: yagom)
var iMac = Stuff(name: "iMac", owner: yagom)
let iPhone = Stuff(name: "iPhone", owner: hana)

let stuffNameKeyPath = \Stuff.name
let ownerkeyPath = \Stuff.owner

let ownerNameKeyPath = ownerkeyPath.appending(path: \.name)

print(macbook[keyPath: stuffNameKeyPath])
print(iMac[keyPath: stuffNameKeyPath])
print(iPhone[keyPath: stuffNameKeyPath])

print(macbook[keyPath: ownerNameKeyPath])
print(iMac[keyPath: ownerNameKeyPath])
print(iPhone[keyPath: ownerNameKeyPath])

iMac[keyPath: stuffNameKeyPath] = "iMac Pro"
iMac[keyPath: ownerkeyPath] = hana

print(iMac[keyPath: stuffNameKeyPath])
print(iMac[keyPath: ownerNameKeyPath])

// MARK: 메서드
// 인스턴스 메서드
class LevelClass {
    var level: Int = 0 {
        didSet {
            print("Level \(level)")
        }
    }
    
    func levelUp() {
        print("Level Up!")
        level += 1
    }
    
    func levelDown() {
        print("Level Down")
        level -= 1
        if level < 0 {
            reset()
        }
    }
    
    func jumpLevel(level: Int) {
        print("Jump to \(level)")
        self.level = level
    }
    
    func reset() {
        print("Reset!")
        level = 0
    }
}

var levelClassInstance: LevelClass = LevelClass()
levelClassInstance.levelUp()
levelClassInstance.levelDown()
levelClassInstance.levelDown()
levelClassInstance.jumpLevel(level: 3)

struct LevelStruct {
    var level: Int = 0 {
        didSet {
            print("Level \(level)")
        }
    }
    
    mutating func levelUp() {
        print("Level Up!")
        level += 1
    }
    
    mutating func levelDown() {
        print("Level Down")
        level -= 1
        if level < 0 {
            reset()
        }
    }
    
    mutating func jumpLevel(to: Int) {
        print("Jump to \(to)")
        level = to
    }
    
    mutating func reset() {
        print("Reset!")
        level = 0
    }
}

var levelStructInstance: LevelStruct = LevelStruct()
levelStructInstance.levelUp()
levelStructInstance.levelDown()
levelStructInstance.levelDown()
levelStructInstance.jumpLevel(to: 3)

class LevelClass2 {
    var level: Int = 0
    
    func reset() {
        // 오류 self 프로퍼티 참조 변경 불가
//        self = LevelClass2()
    }
}

struct LevelStruct2 {
    var level: Int = 0
    
    mutating func levelUp() {
        print("Level Up!")
        level += 1
    }
    
    mutating func reset() {
        print("Reset!")
        self = LevelStruct2()
    }
}

var levelStructInstance2:  LevelStruct2 = LevelStruct2()
levelStructInstance2.levelUp()
print(levelStructInstance2.level)

levelStructInstance2.reset()
print(levelStructInstance2.level)

enum OnOffSwitch {
    case on, off
    mutating func nextState() {
        self = self == .on ? .off : .on
    }
}

var toggle: OnOffSwitch = OnOffSwitch.off
toggle.nextState()
print(toggle)

// 타입 메서드
class AClass2 {
    static func staticTypeMethod() {
        print("AClass2 staticTypeMethod")
    }
    
    class func classTypeMethod() {
        print("AClass2 classTypeMethod")
    }
}

class BClass: AClass2 {
    /*
    // 오류발생 - 재정의 불가
    override static func staticTypeMethod() {
        
    }
    */
    
    override class func classTypeMethod() {
        print("BClass classTypeMethod")
    }
}
AClass2.staticTypeMethod()
AClass2.classTypeMethod()
BClass.classTypeMethod()

struct SystemVolume {
    static var volume: Int = 5
    
    static func mute() {
        self.volume = 0
    }
}

class Navigation {
    var volume: Int = 5
    
    func guideWay() {
        SystemVolume.mute()
    }
    
    func finishGuideWay() {
        SystemVolume.volume = self.volume
    }
}

SystemVolume.volume = 10

let myNavi: Navigation = Navigation()

myNavi.guideWay()
print(SystemVolume.volume)

myNavi.finishGuideWay()
print(SystemVolume.volume)
