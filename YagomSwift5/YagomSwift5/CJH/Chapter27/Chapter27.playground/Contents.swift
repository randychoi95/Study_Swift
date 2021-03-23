import UIKit

// MARK: 강한참조
class Person {
    let name: String
    init(name: String) {
        self.name = name
        print("\(name) is being initialized")
    }
    
    var room: Room?
    
    deinit {
        print("\(name) is being deinitialized")
    }
}

var reference1: Person?
var reference2: Person?
var reference3: Person?

reference1 = Person(name: "yagom")
reference2 = reference1
reference3 = reference1

reference3 = nil
reference2 = nil
reference1 = nil

func foo() {
    let yagom: Person = Person(name: "yagom2")
}
foo()

var globalReference: Person?

func foo2() {
    let yagom: Person = Person(name: "yagom3")
    
    globalReference = yagom
}
foo2()

class Room {
    let number: String
    
    init(number: String) {
        self.number = number
    }
    
    var host: Person?
    
    deinit {
        print("Room \(number) is being deinitalized")
    }
}

var yagom: Person? = Person(name: "yagom4")
var room: Room? = Room(number: "505")

room?.host = yagom
yagom?.room = room

yagom?.room = nil
yagom = nil
room?.host = nil
room = nil

// MARK: 약한참조
class Room2 {
    let number: String
    
    init(number: String) {
        self.number = number
    }
    
    weak var host: Person?
    
    deinit {
        print("Room2 \(number) is being deinitalized")
    }
}

var yagom2: Person? = Person(name: "yagom5")
var room2: Room2? = Room2(number: "505")

room2?.host = yagom
yagom?.room = room

yagom2 = nil
print(room2?.host)

room2 = nil

// MARK: 미소유 참조
class Person2 {
    let name: String
    
    // 카드를 소지할 수도, 소지하지 않을 수도 있기 때문에 옵셔널로 정의합니다.
    // 또, 카드를 한 번 가진 후 잃어버리면 안되기 때문에 강한참조를 해야합니다.
    var card: CreditCard?
    
    init(name: String) {
        self.name = name
    }
    
    deinit {
        print("\(name) is being deinitalized")
    }
}

class CreditCard {
    let number: UInt
    unowned let owner: Person2 // 카드는 소유자가 분명히 존재해야 합니다.
    
    init(number: UInt, owner: Person2) {
        self.number = number
        self.owner = owner
    }
    
    deinit {
        print("Card #\(number) is being deinitalized")
    }
}

var jisoo: Person2? = Person2(name: "jisoo")

if let person: Person2 = jisoo {
    person.card = CreditCard(number: 1004, owner: person)
}

jisoo = nil

// 미소유참조와 암시적 추출 옵셔널 프로퍼티
class Company {
    let name: String
    // 암시적 추출 옵셔널 프로퍼티 (강한참조)
    var ceo: CEO!
    
    init(name: String, ceoName: String) {
        self.name = name
        self.ceo = CEO(name: ceoName, company: self)
    }
    
    func introduce() {
        print("\(name)의 CEO는 \(ceo.name)입니다.")
    }
}

class CEO {
    let name: String
    // 미소유참조 상수 프로퍼티 (미소유참조)
    unowned let company: Company
    
    init(name: String, company: Company) {
        self.name = name
        self.company = company
    }
    
    func introduce() {
        print("\(name)는 \(company.name)의 CEO입니다.")
    }
}

let company: Company = Company(name: "무한상사", ceoName: "김태호")
company.introduce()
company.ceo.introduce()

// 클로저의 강한참조 순환
class Person3 {
    let name: String
    let hobby: String?
    
    lazy var introduce: () -> String = {
        var introduction: String = "My name is \(self.name)."
        
        guard let hobby = self.hobby else {
            return introduction
        }
        
        introduction += " "
        introduction += "My hobby is \(hobby)."
        
        return introduction
    }
    
    init(name: String, hobby: String? = nil) {
        self.name = name
        self.hobby = hobby
    }
    
    deinit {
        print("\(name) is being deinitalized")
    }
}

var yagom3: Person3? = Person3(name: "yagom", hobby: "eating")
print(yagom3?.introduce())
yagom3 = nil

// MARK: 획득목록
var a = 0
var b = 0
let closure = { [a] in
    print(a, b)
    b = 20
}

a = 10
b = 10
closure()
print(b)

class SimpleClass {
    var value: Int = 0
}

var x = SimpleClass()
var y = SimpleClass()

let closure2 = { [x] in
    print(x.value, y.value)
}

x.value = 10
y.value = 10

closure2()

class SimpleClass2 {
    var value: Int = 0
}

var x2: SimpleClass2? = SimpleClass2()
var y2 = SimpleClass2()

let closure3 = { [weak x2, unowned y2] in
    print(x2?.value, y2.value)
}

x2 = nil
y2.value = 10

closure3()

class Person4 {
    let name: String
    let hobby: String?
    
    lazy var introduce: () -> String = { [ /*unowned*/ weak self] in
        guard let `self` = self else {
            return "원래의 참조 인스턴스가 없어졌습니다."
        }
        var introduction: String = "My name is \(self.name)."
        
        guard let hobby = self.hobby else {
            return introduction
        }
        
        introduction += " "
        introduction += "My hobby is \(hobby)."
        return introduction
    }
    
    init(name: String, hobby: String? = nil) {
        self.name = name
        self.hobby = hobby
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
}

var yagom4: Person4? = Person4(name: "yagom", hobby: "eating")

var hana: Person4? = Person4(name: "hana", hobby: "playing guitar")

hana?.introduce = yagom4?.introduce ?? {" "}

print(yagom4?.introduce())

yagom4 = nil

print(hana?.introduce())


