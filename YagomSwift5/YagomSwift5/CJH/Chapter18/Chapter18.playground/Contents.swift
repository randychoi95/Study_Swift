import UIKit

// MARK: 클래스 상속
class Person {
    var name: String = ""
    var age: Int = 0
    
    var introduction: String {
        return "이름: \(name). 나이 : \(age)"
    }
    
    func speak() {
        print("가나다라마바사")
    }
}

let yagom: Person = Person()
yagom.name = "yagom"
yagom.age = 99
print(yagom.introduction)
yagom.speak()

class Student: Person {
    var grade: String = "F"
    
    func study() {
        print("Study hard...")
    }
}

let jay: Student = Student()
jay.name = "jay"
jay.age = 10
jay.grade = "A"
print(jay.introduction)
jay.speak()
jay.study()

class UniversityStudent: Student {
    var major: String = ""
}

let jenny: UniversityStudent = UniversityStudent()
jenny.major = "Art"
jenny.speak()
jenny.study()

// MARK: 재정의
// - 자식클래스는 부모클래스로부터 물려받은 특성을 그대로 사용하지 않고 자신만의 기능으로 변경하여 사용

// 메서드 재정의
class Person2 {
    var name: String = ""
    var age: Int = 0
    
    var introduction: String {
        return "이름 : \(name). 나이 : \(age)"
    }
    
    func speak() {
        print("가나다라마바사")
    }
    
    class func introduceClass() -> String {
        return "인류의 소원은 평화입니다."
    }
}

class Student2: Person2 {
    var grade: String = "F"
    
    func study() {
        print("Study hard...")
    }
    
    override func speak() {
        print("저는 학생입니다.")
    }
}

class UniversityStudent2: Student2 {
    var major: String = ""
    
    class func introduceClass() {
        print(super.introduceClass())
    }
    
    override class func introduceClass() -> String {
        return "대학생의 소원은 A+입니다."
    }
    
    override func speak() {
        super.speak()
        print("대학생이죠.")
    }
}

let yagom2: Person2 = Person2()
yagom2.speak()

let jay2: Student2 = Student2()
jay2.speak()

let jenny2: UniversityStudent2 = UniversityStudent2()
jenny2.speak()

print(Person2.introduceClass())
print(Student2.introduceClass())
print(UniversityStudent2.introduceClass() as String)
UniversityStudent2.introduceClass() as Void

// 프로퍼티 재정의
class Person3 {
    var name: String = ""
    var age: Int = 0
    var koreanAge: Int {
        return self.age + 1
    }
    
    var introduction: String {
        return "이름 : \(name). 나이 : \(age)"
    }
}

class Student3: Person3 {
    var grade: String = "F"
    
    override var introduction: String {
        return super.introduction + " " + "학점 : \(self.grade)"
    }
    
    override var koreanAge: Int {
        get {
            return super.koreanAge
        }
        set {
            self.age = newValue - 1
        }
    }
}

let yagom3: Person3 = Person3()
yagom3.name = "yagom"
yagom3.age = 55
//yagom3.koreanAge = 56
print(yagom3.introduction)
print(yagom3.koreanAge)

let jay3: Student3 = Student3()
jay3.name = "jay"
jay3.age = 14
jay3.koreanAge = 15
print(jay3.introduction)
print(jay3.koreanAge)

// 프로퍼티 감시자 재정의
class Person4 {
    var name: String = ""
    var age: Int = 0 {
        didSet {
            print("Person age : \(self.age)")
        }
    }
    var koreanAge: Int {
        return self.age + 1
    }
    
    var fullName: String {
        get{
            return self.name
        }
        set {
            self.name = newValue
        }
    }
}

class Student4: Person4 {
    var grade: String = "F"
    
    override var age: Int {
        didSet {
            print("Student age : \(self.age)")
        }
    }
    
    override var koreanAge: Int {
        get {
            return super.koreanAge
        }
        
        set {
            self.age =  newValue - 1
        }
    }
    
    override var fullName: String {
        didSet {
            print("Full Name : \(self.fullName)")
        }
    }
}

let yagom4: Person4 = Person4()
yagom4.name = "yagom"
yagom4.age = 55
yagom4.fullName = "Jo yagom"
print(yagom4.koreanAge)

let jay4: Student4 = Student4()
jay4.name = "jay"
jay4.age = 14
jay4.koreanAge = 15
jay4.fullName = "Kim jay"
print(jay4.koreanAge)

// 서브스크립트 재정의
class School {
    var students: [Student] = [Student]()
    
    subscript(number: Int) -> Student {
        print("School subscript")
        return students[number]
    }
}

class MiddleSchool: School {
    var middleStdents: [Student] = [Student]()
    
    // 부모클래스(school)에게 상속받은 서브스크립트 재정의
    override subscript(number: Int) -> Student {
        print("middleSchool subscript")
        return middleStdents[number]
    }
}

let university: School = School()
university.students.append(Student())
university[0]

let middle: MiddleSchool = MiddleSchool()
middle.middleStdents.append(Student())
middle[0]

// 재정의 방지
class Person5 {
    final var name: String = ""
    
    final func speak() {
        print("가나다라마바사")
    }
}

final class Student5: Person5 {
    // final을 사용하여 재정의를 할 수 없도록 했기 때문
//    override var name: String {
//        set {
//            super.name = newValue
//        }
//        get {
//            return "학생"
//        }
//    }
    
    // final을 사용하여 재정의를 할 수 없도록 했기 때문
//    override func speak() {
//        print("저는 학생입니다.")
//    }
}

// final을 사용하여 상속/Users/choi/Desktop/sourcetree/Study_Swift/YagomSwift5/YagomSwift5/CJH/Chapter16할 수 없도록 했기 때문
//class UniversityStudent5: Student5 { }


// MARK: 클래스의 이니셜라이저
class Person6 {
    var name: String
    var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

class Student6: Person6 {
    var major: String
    
    init(name: String, age: Int, major: String) {
        self.major = "Swift"
        super.init(name: name, age: age)
    }
    
    convenience init(name: String) {
        self.init(name: name, age: 7, major: "")
    }
}

// 이니셜라이저 상속 및 재정의
class Person7 {
    var name: String
    var age: Int
    
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
    
    convenience init(name: String) {
        self.init(name: name, age: 0)
    }
}

class Student7: Person7 {
    var major: String
    
    override init(name: String, age: Int) {
        self.major = "Swift"
        super.init(name: name, age: age)
    }
    
    convenience init(name: String) {
        self.init(name: name, age: 7)
    }
}

class Person8 {
    var name: String
    var age: Int
    
    init() {
        self.name = "Unknown"
        self.age = 0
    }
    
    init?(name: String, age: Int) {
        if name.isEmpty {
            return nil
        }
        self.name = name
        self.age = age
    }
    
    init?(age: Int) {
        if age < 0 {
            return nil
        }
        self.name = "Unknown"
        self.age = age
    }
}

class Student8: Person8 {
    var major: String
    
    override init?(name: String, age: Int) {
        self.major = "Swift"
        super.init(name: name, age: age)
    }
    
    override init(age: Int) {
        self.major = "Swift"
        super.init()
    }
}

// 이니셜라이저 자동 상속
class Person9 {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    convenience init() {
        self.init(name: "Unknown")
    }
}

class Student9: Person9 {
    var major: String = "Swift"
}

let yagom5: Person9 = Person9(name: "yagom")
let hana: Student9 = Student9(name: "hana")
print(yagom5.name)
print(hana.name)

let wizplan: Person9 = Person9()
let jinSung: Student9 = Student9()
print(wizplan.name)
print(jinSung.name)

// 편의 이니셜라이저 자동 상속
class Person10 {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    convenience init() {
        self.init(name: "Unknown")
    }
}

class Student10: Person10 {
    var major: String
    
    override init(name: String) {
        self.major = "Unknown"
        super.init(name: name)
    }
    
    init(name: String, major: String) {
        self.major = major
        super.init(name: name)
    }
}

let wizplan2: Person10 = Person10()
let jinSung2: Student10 = Student10()
print(wizplan2.name)
print(jinSung2.name)

class Person11 {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    convenience init() {
        self.init(name: "Unknown")
    }
}

class Student11: Person11 {
    var major: String
    
    convenience init(major: String) {
        self.init()
        self.major = major
    }
    
    override convenience init(name: String) {
        self.init(name: name, major: "Unknown")
    }
    
    init(name: String, major: String) {
        self.major = major
        super.init(name: name)
    }
}

let wizplan3: Person11 = Person11()
let jinSung3: Student11 = Student11(major: "Swift")
print(wizplan3.name)
print(jinSung3.name)
print(jinSung3.major)

class UniversityStudent3: Student11 {
    var grade: String = "A+"
    var description: String {
        return "\(self.name) \(self.major) \(self.grade)"
    }
    
    convenience init(name: String, major: String, grade: String) {
        self.init(name: name, major: major)
        self.grade = grade
    }
}

let nova: UniversityStudent3 = UniversityStudent3()
print(nova.description)

let raon: UniversityStudent3 = UniversityStudent3(name: "raon")
print(raon.description)

let joker: UniversityStudent3 = UniversityStudent3(name: "joker", major: "Programming")
print(joker.description)

let chope: UniversityStudent3 = UniversityStudent3(name: "chope", major: "Computer", grade: "C")
print(chope.description)

// 요구 이니셜라이저
class Person12 {
    var name: String
    
    // 요구 이니셜라이저 정의
    required init() {
        self.name = "Unknown"
    }
}

class Student12: Person12 {
    var major: String = "Unknown"
    
    // 자신의 지정 이니셜라이저 구현
    init(major: String) {
        self.major = major
        super.init()
    }
    
    required init() {
        self.major = "Unknown"
        super.init()
    }
}

class UniversityStudent4: Student12 {
    var grade: String
    
    // 자신의 지정 이니셜라이저 구현
    init(grade: String) {
        self.grade = grade
        super.init()
    }
    
    required init() {
        self.grade = "F"
        super.init()
    }
}

let miJeong: Student12 = Student12()

let jiSoo: Student12 = Student12()
print(jiSoo.major)

let yagom6: Student12 = Student12(major: "Swift")
print(yagom6.major)

let juHyun: UniversityStudent4 = UniversityStudent4(grade: "A+")
print(juHyun.grade)

class Person13 {
    var name: String
    
    init() {
        self.name = "Unknown"
    }
}

class Student13: Person13 {
    var major: String = "Unknown"
    
    init(major: String) {
        self.major = major
        super.init()
    }
    
    // 부모클래스의 이니셜라이저를 재정의함과 동시에
    // 요구 이니셜라이저로 변경됨을 알립니다.
    required override init() {
        self.major = "Unknown"
        super.init()
    }
    
    // 이 요구 이니셜라이저는 앞으로 계속 요구합니다.
    required convenience init(name: String) {
        self.init()
        self.name = name
    }
}

class UniversityStudent5: Student13 {
    var grade: String
    
    init(grade: String) {
        self.grade = grade
        super.init()
    }
    
    // Student 클래스에서 요구했으므로 구현해주어야 합니다.
    required init() {
        self.grade = "F"
        super.init()
    }
    
    // Student 클래스에서 요구했으므로 구현해주어야 합니다.
    required convenience init(name: String) {
        self.init()
        self.name = name
    }
}

let yagom7: UniversityStudent5 = UniversityStudent5()
print(yagom7.grade)

let juHyun2: UniversityStudent5 = UniversityStudent5(name: "JuHyun")
print(juHyun2.name)
