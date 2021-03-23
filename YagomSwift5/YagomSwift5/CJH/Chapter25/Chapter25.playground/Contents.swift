import UIKit

// MARK: 와일드카드 패턴
let string: String = "ABC"

switch string {
// ABC -> 어떤 값이 와도 상관없기에 항상 실행됩니다.
case _: print(string)
}

let optionalString: String? = "ABC"

switch optionalString {
// optionalString이 Optional("ABC")일 때만 실행됩니다.
case "ABC"?: print(optionalString)
    
// optionalString이 Optional("ABC") 외의 값이 있을 떄만 실행됩니다.
case _?: print("Has value, but not ABC")
    
// 값이 없을 때 실행됩니다.
case nil: print("nil")
    
}

let yagom = ("yagom", 99, "Male")

switch yagom {
// 첫 번째 요소가 "yagom"일 때만 실행됩니다.
case ("yagom", _, _): print("Hello yagom!!!")
    
// 그 외 언제든지 실행됩니다.
case (_, _, _): print("Who cares~")
}

for _ in 0..<2 {
    print("Hello")
}

// MARK: 식별자 패턴
let someValue: Int = 42

// MARK: 값 바인딩 패턴
let yagom2 = ("yagom", 99, "Male")

switch yagom2 {
// name, age, gender를 yagom의 각각의 요소와 바인딩합니다.
case let (name, age, gender): print("Name: \(name), Age: \(age), Gender: \(gender)")
}

switch yagom2 {
case (let name, let age, let gender): print("Name: \(name), Age: \(age), Gender: \(gender)")
}

switch yagom2 {
// 값 바인딩 패턴은 와일드카드 패턴과 결합하여 유용하게 사용될 수도 있습니다.
case (let name, _, let gender): print("Name: \(name), Gender: \(gender)")
}

// MARK: 튜플 패턴
let (a): Int = 2
print(a)

let (x, y): (Int, Int) = (1, 2)
print(x)
print(y)

let name: String = "Jung"
let age: Int = 99
let gender: String? = "Male"

switch (name, age, gender) {
case ("Jung", _, _) : print("Hello Jung!!")
case (_, _, "Male"?): print("who are you man?")
default: print("I don't know who you are")
}

let points: [(Int, Int)] = [(0, 0), (1, 0), (1, 1), (2, 0), (2, 1)]

for (x, _) in points {
    print(x)
}

// MARK: 열거형 케이스 패턴
let someValue2: Int = 30

if case 0...100 = someValue2 {
    print("0 <= \(someValue2) <= 100")
}

let anotherValue: String = "ABC"

if case "ABC" = anotherValue {
    print(anotherValue)
}

enum MainDish {
    case pasta(taste: String)
    case pizza(dough: String, topping: String)
    case chicken(withSauce: Bool)
    case rice
}

var dishes: [MainDish] = []

var dinner: MainDish = .pasta(taste: "크림")
dishes.append(dinner)

if case .pasta(let taste) = dinner {
    print("\(taste) 파스타")
}

dinner = .pizza(dough: "치즈크러스트", topping: "불고기")
dishes.append(dinner)

func whatIsThis(dish: MainDish) {
    guard case .pizza(let dough, let topping) = dinner else {
        print("It's not a Pizza")
        return
    }
    
    print("\(dough) \(topping) 피자")
}
whatIsThis(dish: dinner)

dinner = .chicken(withSauce: true)
dishes.append(dinner)

while case .chicken(let sauced) = dinner {
    print("\(sauced ? "양념" : "후라이드") 통닭")
    break
}

dinner = .rice
dishes.append(dinner)

if case .rice = dinner {
    print("오늘 저녁은 밥입니다.")
}

for dish in dishes {
    switch dish {
    case let .pasta(taste): print(taste)
    case let .pizza(dough, topping): print(dough, topping)
    case let .chicken(sauced): print(sauced ? "양념" : "후라이드")
    case .rice: print("Just 쌀")
    }
}

// MARK: 옵셔널 패턴
var optionalValue: Int? = 100

if case .some(let value) = optionalValue {
    print(value)
}

if case let value? = optionalValue {
    print(value)
}

func isItHasValue(_ optionalValue: Int?) {
    guard case .some(let value) = optionalValue else {
        print("none")
        return
    }
    
    print(value)
}

isItHasValue(optionalValue)

while case .some(let value) = optionalValue {
    print(value)
    optionalValue = nil
}

print(optionalValue)

let arrayOfOptionalInts: [Int?] = [nil, 2, 3, nil, 5]

for case let number? in arrayOfOptionalInts {
    print("Found a \(number)")
}

// MARK: 타입캐스팅 패턴
let someValue3: Any = 100

switch someValue3 {
// 타입이 Int인지 확인하지만 캐스팅된 값을 사용할 수는 없습니다.
case is String: print("It's String!")

// 타입 확인과 동시에 캐스팅까지 완료되어 value에 저장됩니다.
// 값 바인딩 패턴과 결합된 모습입니다.
case let value as Int: print(value + 1)
default: print("Int도 String도 아닙니다.")
}

// MARK: 표현 패턴
switch 3 {
case 0...5: print("0과 5사이")
default: print("0보다 작거나 5보다 큽니다.")
}

var point: (Int, Int) = (1, 2)

// 같은 타입 간의 비교이므로 == 연산자를 사용하여 비교할 것입니다.
switch point {
case (0, 0): print("원점")
case (-2...2, -2...2): print("(\(point.0), \(point.1))은 원점과 가깝습니다.")
default: print("point (\(point.0), \(point.1))")
}

// String 타입과 Int 타입이 매치될 수 있도록 ~= 연산자를 정의합니다.
func ~= (pattern: String, value: Int) -> Bool {
    return pattern == "\(value)"
}

point = (0, 0)

//새로 정의된 ~= 연산자를 사용하여 비교합니다.
switch point {
case ("0", "0"): print("원점")
default: print("point (\(point.0), \(point.1))")
}

struct Person {
    var name: String
    var age: Int
}

let lingo: Person = Person(name: "Lingo", age: 99)
func ~= (pattern: String, value: Person) -> Bool {
    return pattern == value.name
}

func ~= (pattern: Person, value: Person) -> Bool {
    return pattern.name == value.name && pattern.age == value.age
}

switch lingo {
case Person(name: "Lingo", age: 99): print("Same Person!!")
case "Lingo": print("Hello Lingo!!")
default: print("I don't know who you are")
}

// 제네릭을 사용하기 위해 프로토콜을 정의합니다.
protocol Personalize {
    var name: String { get }
    var age: Int { get }
}

struct Person2: Personalize {
    var name: String
    var age: Int
}

let star: Person2 = Person2(name: "Star", age: 99)

// 제네릭을 사용하여 패턴 연산자를 정의합니다.
func ~= <T: Personalize>(pattern: String, value: T) -> Bool {
    return pattern == value.name
}

func ~= <T: Personalize>(pattern: T, value: T) -> Bool {
    return pattern.name == value.name && pattern.age == value.age
}

// 기존 패턴 연산자가 없더라도 제네릭 패턴 연산자로 똑같이 사용할 수 있습니다.
switch star {
case Person2(name: "Star", age: 99) : print("Same Person!!")
case "Star": print("Hello Star!!")
default: print("I don't know who you are")
}

// 이번엔 제네릭을 사용하여 패턴 연산자를 정의합니다.
// 패턴 자체가 함수임
func ~= <T: Personalize>(pattern: (T) -> Bool, value: T) -> Bool {
    return pattern(value)
}

//패턴에 사용할 제네릭 함수입니다.
func young<T: Personalize>(value: T) -> Bool {
    return value.age < 50
}

switch star {
case young: print("\(star.name) is young")
default: print("\(star.name) is old")
}

// 패턴에 사용할 제네릭 함수입니다.
func isNamed<T: Personalize>(_ pattern: String) -> ((T) -> Bool) {
    return { (value: T) -> Bool in value.name == pattern}
}

switch star{
// 패턴결합을 하면 isNamed("Jung")(star)와 같은 효과를 봅니다.
case isNamed("Jung"): print("He is Jung")
default: print("Another person")
}

// 연산자가 함수라는 점을 생각해보면 이런 방식으로도 구현할 수 있습니다.
prefix operator ==?

prefix func ==? <T:Personalize>(pattern: String) -> ((T) -> Bool) {
    return isNamed(pattern)
}

switch star {
// 패턴 결합을 하면 isNamed("Jung")(star)와 같은 효과를 봅니다.
case ==?"Jung": print("He is Jung")
default: print("Another person")
}
