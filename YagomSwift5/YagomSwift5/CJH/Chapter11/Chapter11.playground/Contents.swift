import UIKit

// MARK: 인스턴스 생성
class SomeClass {
    init() {
        // 초기화할 때 필요한 코드
    }
}

struct SomeStruct {
    init() {
        // 초기화할 때 필요한 코드
    }
}

enum SomeEnum {
    case someCase
    
    init() {
        // 열거형은 초기화할 때 반드시 case중 하나가 되어야 합니다.
        self = .someCase
        // 초기화할 때 필요한 코드
    }
}

// 프로퍼티 기본값
struct Area {
    var squareMeter: Double
    
    init() {
        squareMeter = 0.0
    }
}
let room: Area = Area()
print(room.squareMeter)

// 이니셜라이저 매개변수
struct Area2 {
    var squareMeter: Double
    
    init(fromPy py: Double) {
        squareMeter = py * 3.3058
    }
    
    init(fromSquareMeter squareMeter: Double) {
        self.squareMeter = squareMeter
    }
    
    init(value: Double) {
        squareMeter = value
    }
    
    init(_ value: Double) {
        squareMeter = value
    }
}

let roomOne: Area2 = Area2(fromPy: 15.0)
print(roomOne.squareMeter)

let roomTwo: Area2 = Area2(fromSquareMeter: 33.06)
print(roomTwo.squareMeter)

let roomThree: Area2 = Area2(value: 30.0)
print(roomThree.squareMeter)

let roomFour: Area2 = Area2(55.0)
print(roomFour.squareMeter)

// 옵셔널 프로퍼티 타입
// 상수 프로퍼티
class Person {
    let name: String
    var age: Int?
    
    init(name: String) {
        self.name = name
    }
}

let yagom: Person = Person(name: "yagom")
print(yagom.name)
print(yagom.age)

yagom.age = 99
print(yagom.age)

// 오류
//yagom.name = "Eric"

// 기본 이니셜라이저와 멤버와이즈 이니셜라이저
struct Point {
    var x: Double = 0.0
    var y: Double = 0.0
}

struct Size {
    var width: Double = 0.0
    var height: Double = 0.0
}

let point: Point = Point(x: 0, y: 0)
let size: Size = Size(width: 50.0, height: 50.0)
// 구조체의 저장 프로퍼티에 기본값이 있는경우
// 필요한 매개변수만 사용하여 초기화할 수도 있습니다.
let somePoint: Point = Point()
let someSize: Size = Size(width: 50)
let anotherPoint: Point = Point(y: 100)
// 멤버와이즈 이니셜라이즈는 사용자 정의 이니셜라이저를 구현하지 않으면 프로퍼티의 이름으로 매개변수를 갖는 이니셜라이저, 구조체는 지원 / 클래스는 지원하지 않음.

// 초기화 위임
enum Student {
    case elementary, middle, high
    case none
    
    // 사용자 정의 이니셜라이저가 있는 경우, init() 메서드를 구현해주어야 기본 이니셜라이저를 사용할 수 있습니다.
    init() {
        self = .none
    }
    
    init(koreanAge: Int) {
        switch koreanAge {
        case 8...13:
            self = .elementary
        case 14...16:
            self = .middle
        case 17...19:
            self = .high
        default:
            self = .none
        }
    }
    
    init(bornAt: Int, currentYear: Int) {
        self.init(koreanAge: currentYear -  bornAt + 1)
    }
}

var younger: Student = Student(koreanAge: 16)
print(younger)

younger = Student(bornAt: 1998, currentYear: 2016)
print(younger)

// 실패 가능한 이니셜라이저
class Person2 {
    let name: String
    var age: Int?
    
    init?(name: String) {
        if name.isEmpty {
            return nil
        }
        self.name = name
    }
    
    init?(name: String, age: Int) {
        if name.isEmpty || age < 0 {
            return nil
        }
        self.name = name
        self.age = age
    }
}
let yagom2: Person2? = Person2(name: "yagom2", age: 99)

if let person: Person2 = yagom2 {
    print(person.name)
} else {
    print("Person wasn't initialized")
}

let chope: Person2? = Person2(name: "chope", age: -10)

if let person: Person2 = chope {
    print(person.name)
} else {
    print("Person wasn't initalized")
}

let eric: Person2? = Person2(name: "", age: 30)

if let person: Person2 = eric {
    print(person.name)
} else {
    print("Person wasn't initalized")
}

enum Student2: String {
    case elementary = "초등학생", middle = "중학생", high = "고등학생"
    
    init?(koreanAge: Int) {
        switch koreanAge {
        case 8...13:
            self = .elementary
        case 14...16:
            self = .middle
        case 17...19:
            self = .high
        default:
            return nil
        }
    }
    
    init?(bornAt: Int, currentYear: Int) {
        self.init(koreanAge: currentYear -  bornAt + 1)
    }
}

var younger2: Student2? = Student2(koreanAge: 20)
print(younger2)

younger2 = Student2(bornAt: 2020, currentYear: 2016)
print(younger2)

younger2 = Student2(bornAt: 2020, currentYear: 2016)
print(younger2)

younger2 = Student2(rawValue: "대학생")
print(younger2)

younger2 = Student2(rawValue: "고등학생")
print(younger2)

// 함수를 사용한 프로퍼티 기본값 설정
struct Student3 {
    var name: String?
    var number: Int?
}

class SchoolClass {
    var student: [Student3] = {
        // 새로운 인스턴스를 생성하고 사용자 정의 연산을 통한 후 반환해줍니다.
        // 반환되는 값의 타입은 [student] 타입이어야 합니다.
        var arr: [Student3] = [Student3]()
        
        for num in 1...15 {
            var student: Student3 = Student3(name: nil, number: num)
            arr.append(student)
        }
        return arr
    }()
}

let myClass: SchoolClass = SchoolClass()
print(myClass.student.count)

// MARK: 인스턴스 소멸
class FileManager {
    var fileName: String
    
    init(fileName: String) {
        self.fileName = fileName
    }
    
    func openFile() {
        print("Open File: \(self.fileName)")
    }
    
    func modifyFile() {
        print("Modify File \(self.fileName)")
    }
    
    func writeFile() {
        print("Write File \(self.fileName)")
    }
    
    func closeFile() {
        print("CloseFile: \(self.fileName)")
    }
    
    deinit {
        print("Deinit instance")
        self.writeFile()
        self.closeFile()
    }
}

var fileManager: FileManager? = FileManager(fileName: "abc.txt")

if let manager: FileManager = fileManager {
    manager.openFile()
    manager.modifyFile()
}

fileManager = nil
