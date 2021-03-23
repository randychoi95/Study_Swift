import UIKit

// MARK: 데이터 타입 안심
// 타입을 지정하지 않았으나 타입 추론을 통하여 name은 String 타입으로 선언됩니다.
var name = "Kwanhee"

// 앞서 타입 추론에 의해 name은 String 타입의 변수로 지정되었기 때문에
// 정수를 할당하려고 시도하면 오류가 발생합니다.
//name = 100

// MARK: 타입 별칭
typealias MyInt = Int
typealias YourInt = Int
typealias MyDouble = Double

let age: MyInt = 100
var year: YourInt = 2080

// MyInt도, YourInt도 Int이기 때문에 같은 타입으로 취급합니다.
year = age

let month: Int = 7
let percentage: MyDouble = 99.9

// MARK: 튜플
// String, Int, Double 타입을 갖는 튜플
var person: (String, Int, Double) = ("yagom", 100, 182.5)

// 인덱스를 통해서 값을 뺴 올 수 있습니다.
print("이름: \(person.0), 나이: \(person.1), 신장: \(person.2)")

person.1 = 99
person.2 = 178.5

print("이름: \(person.0), 나이: \(person.1), 신장: \(person.2)")

var person2: (name: String, age: Int, height: Double) = ("yagom", 100, 182.5)

// 요소 이름을 통해서 값을 빼 올 수 있습니다.
print("이름: \(person2.name), 나이: \(person2.age), 신장: \(person2.height)")

person2.age = 99
person2.2 = 178.5

print("이름: \(person2.0), 나이: \(person2.1), 신장: \(person2.2)")

typealias PersonTuple = (name: String, age: Int, height: Double)

let yagom: PersonTuple = ("yagom", 100, 178.5)
let eric: PersonTuple = ("eric", 150, 182.5)

print("이름: \(yagom.name), 나이: \(yagom.age), 신장: \(yagom.height)")
print("이름: \(eric.name), 나이: \(eric.age), 신장: \(eric.height)")

// MARK: 컬렉션형
// 배열
// 대괄호를 사용하여 배열임을 표현합니다.
var names: Array<String> = ["yagom", "chulsoo", "younghee", "yagom"]

// 위 선언과 정확히 동일한 표현입니다. [String]는 Array<String>의 축약 표현입니다.
//var names: [String] = ["yagom", "chulsoo", "younghee", "yagom"]

var emptyArray: [Any] = [Any]()
//var emptyArray: [Any] = Array<Any>()

// 배열의 타입을 정확히 명시해줬다면 []만으로도 빈 배열을 생성할 수 있습니다.
//var emptyArray: [Any] = []
print(emptyArray.isEmpty)
print(names.count)

print(names[2])
names[2] = "jenny"
print(names[2])
// print(names[4]) 인덱스의 범위를 벗어났기 때문에 오류 발생

//names[4] = "elsa" 인덱스의 범위를 벗어났기 때문에 오류발생
names.append("elsa")
names.append(contentsOf: ["john", "max"])
names.insert("happy", at: 2)
// 인덱스 5의 위치에 jinhee와 minsoo가 삽입됩니다.
names.insert(contentsOf: ["jinhee", "minsoo"], at: 5)

print(names[4])
print(names.index(of: "yagom"))
print(names.index(of: "christal"))
print(names.first)
print(names.last)

let firstItem: String = names.removeFirst()
let lastItem: String = names.removeLast()
let indexZeroItem: String = names.remove(at: 0)

print(firstItem)
print(lastItem)
print(indexZeroItem)
print(names[1...3])

// 딕셔너리
// typealias를 통해 조금 더 단순하게 표현해볼 수도 있습니다.
typealias StringIntDictionary = [String: Int]

// 키는 String, 값은 Int 타압인 빈 딕셔너리를 생성합니다.
//var numberForNmae: Dictionary<String, Int> = Dictionary<String, Int>()

// 위 선언과 같은 표현
//var numberForName: [String: Int] = [String: Int]()

// 위 코드와 같은 동작
//var numberForName: StringIntDictionary = StringIntDictionary()

// 딕셔너리의 키와 값 타입을 정확히 명시해줬다면 [:]만으로도 빈 딕셔너리를 생성할 수 있습니다.
//var numberForName: [String: Int] = [:]

// 초기값을 주어 생성해줄 수도 있습니다.
var numberForName: [String: Int] = ["yagom": 100, "chulsoo": 200, "jenny": 300]

print(numberForName.isEmpty)
print(numberForName.count)

print(numberForName["chulsoo"])
print(numberForName["minji"])

numberForName["chulsoo"] = 150
print(numberForName["chulsoo"])

numberForName["max"] = 999
print(numberForName["max"])

print(numberForName.removeValue(forKey: "yagom"))

// 위에서 yagom 키에 해당하는 값이 이미 삭제되었으므로 nil이 반환됩니다.
// 키에 해당하는 값이 없으면 기본값을 돌려주도록 할 수 도 있습니다.
print(numberForName.removeValue(forKey: "yagom"))

// yagom 키에 해당하는 값이 없으면 기본으로 0이 반환됩니다.
print(numberForName["yagom", default: 0])

// set
// 빈 세트 생성
//var names2: Set<String> = Set<String>()
//var names2: Set<String> = []

// Array와 마찬가지로 대괄호를 사용합니다.
var names2: Set<String> = ["yagom", "chulsoo", "younghee", "yagom"]

// 그렇기 때문에 타입 추론을 사용하게 되면 컴파일러는 Set가 아닌 Array로 타입을 지정합니다.
var numbers = [100, 200, 300]
print(type(of: numbers))

print(names2.isEmpty)
print(names2.count)

print(names2.count)
names2.insert("jenny")
print(names2.count)

print(names2.remove("chulsoo"))
print(names2.remove("john"))

let englishClassStudents: Set<String> = ["john", "chulsoo", "yagom"]
let koreanClassStudents: Set<String> = ["jenny", "yagom", "chulsoo"]

// 교집합
let intersectSet: Set<String> = englishClassStudents.intersection(koreanClassStudents)

// 여집합의 합(배타적 논리합)
let symmetricDiffSet: Set<String> = englishClassStudents.symmetricDifference(koreanClassStudents)

// 합집합
let unionSet: Set<String> = englishClassStudents.union(koreanClassStudents)

// 차집합
let subtractSet: Set<String> = englishClassStudents.subtracting(koreanClassStudents)

print(unionSet.sorted())

// MARK: 열거형
// 기본 열거형
enum School {
    case primary
    case elementary
    case middle
    case high
    case college
    case university
    case graduate
}

var highestEducationLevel: School = School.university
highestEducationLevel = .graduate

// 원시 값
enum School2: String {
    case primary = "유치원"
    case elementary = "초등학교"
    case middle = "중학교"
    case high = "고등학교"
    case college = "대학"
    case university = "대학교"
    case graduate = "대학원"
}

let highestEducationLevel2: School2 = School2.university
print("저의 최종학력은 \(highestEducationLevel2.rawValue) 졸업입니다.")

enum WeekDays: Character {
    case mon = "월", tue = "화", wed = "수", thu = "목", fri = "금", sat = "토", sun = "일"
}

let today: WeekDays = WeekDays.fri
print("오늘은 \(today.rawValue)요일입니다.")

enum School3: String {
    case primary = "유치원"
    case elementary = "초등학교"
    case middle = "중학교"
    case high = "고등학교"
    case college
    case university
    case graduate
}

let highestEducationLevel3: School3 = School3.university
print("저의 최종학력은 \(highestEducationLevel3.rawValue) 졸업입니다.")
print(School3.elementary.rawValue)

enum Numbers: Int {
    case zero
    case one
    case two
    case ten = 10
}

print("\(Numbers.zero.rawValue), \(Numbers.one.rawValue), \(Numbers.two.rawValue), \(Numbers.ten.rawValue)")

let primary = School2(rawValue: "유치원")
let graduate = School2(rawValue: "석박사")

let one = Numbers(rawValue: 1)
let three = Numbers(rawValue: 3)

// 연관 값
enum MainDish {
    case pasta(taste: String)
    case pizza(dough: String, topping: String)
    case chicken(withSauce: Bool)
    case rice
}

var dinner: MainDish = MainDish.pasta(taste: "크림")
dinner = .pizza(dough: "치즈크러스트", topping: "불고기")
dinner = .chicken(withSauce: true)
dinner = .rice

enum PastaTaste {
    case cream, tomato
}
enum PizzaDough {
    case cheeseCrust, thin, original
}

enum PizzaTopping {
    case pepperoni, cheese, bacon
}

enum MainDish2 {
    case pasta(taste: PastaTaste)
    case pizza(dough: PizzaDough, topping: PizzaTopping)
    case chicken(withSauce: Bool)
    case rice
}

var dinner2: MainDish2 = MainDish2.pasta(taste: PastaTaste.tomato)
dinner2 = MainDish2.pizza(dough: PizzaDough.cheeseCrust, topping: PizzaTopping.bacon)

// 항목 순회
enum School4: CaseIterable {
    case primary
    case elementary
    case middle
    case high
    case college
    case university
    case graduate
}

let allCases: [School4] = School4.allCases
print(allCases)

enum School5: String, CaseIterable {
    case primary = "유치원"
    case elementary = "초등학교"
    case middle = "중학교"
    case high = "고등학교"
    case college = "대학"
    case university = "대학교"
    case graduate = "대학원"
}

let allCases2: [School5] = School5.allCases
print(allCases2)

enum School6: String, CaseIterable {
    case primary = "유치원"
    case elementary = "초등학교"
    case middle = "중학교"
    case high = "고등학교"
    case college = "대학"
    case university = "대학교"
    @available(iOS, obsoleted: 12.0)
    case graduate = "대학원"
    
    static var allCases: [School6] {
        let all: [School6] = [.primary, .elementary, .middle, .high, .college, .university]
        #if os(iOS)
        return all
        #else
        return all + [.graduate]
        #endif
    }
}

let allCases3: [School6] = School6.allCases
print(allCases3)

// 순환 열거형
enum ArithmeticExpression {
    case number(Int)
    indirect case addition(ArithmeticExpression, ArithmeticExpression)
    indirect case multiplication(ArithmeticExpression, ArithmeticExpression)
}

let five = ArithmeticExpression.number(5)
let four = ArithmeticExpression.number(4)
let sum = ArithmeticExpression.addition(five, four)
let final = ArithmeticExpression.multiplication(sum, ArithmeticExpression.number(2))

func evaluate(_ expression: ArithmeticExpression) -> Int {
    switch expression {
    case .number(let value):
        return value
    case .addition(let left, let right):
        return evaluate(left) + evaluate(right)
    case .multiplication(let left, let right):
        return evaluate(left) * evaluate(right)
    }
}

let result: Int = evaluate(final)
print("(5 + 4) * 2 = \(result)")
