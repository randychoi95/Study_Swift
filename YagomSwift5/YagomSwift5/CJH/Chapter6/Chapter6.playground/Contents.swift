import UIKit

// MARK: 조건문
// if 구문
let first: Int = 5
let second: Int = 7

if first > second {
    print("first > second")
} else if first < second {
    print("first < second")
} else {
    print("first == second")
}

// switch 구문
let integerValue: Int = 5

switch integerValue {
case 0:
    print("Value == zero")
case 1...10:
    print("Value == 1~10")
    fallthrough
case Int.min..<0, 101..<Int.max:
    print("Value < 0 or Value > 100")
    break
default:
    print("10 < Value <= 100")
}

let doubleValue: Double = 3.0

switch doubleValue {
case 0:
    print("Value == zero")
case 1.5...10.5:
    print("1.5 <= Value <= 10.5")
default:
    print("Value == \(doubleValue)")
}

let stringValue: String = "Liam Neeson"

switch stringValue {
case "yagom":
    print("He is yagom")
case "Jay":
    print("He is Jay")
case "Jenny", "Joker", "Nova":
    print("He or She is \(stringValue)")
default:
    print("\(stringValue) said 'I don't know who you are")
}

typealias NameAge = (name: String, age: Int)

let tupleValue: NameAge = ("yagom", 99)

switch tupleValue {
case ("yagom", 99):
    print("정확히 맞췄습니다!")
default:
    print("누굴 찾나요?")
}

switch tupleValue {
case ("yagom", 50):
    print("정확히 맞췄습니다!")
case ("yagom", _):
    print("이름만 맞았습니다. 나이는 \(tupleValue.age)")
case (_, 99):
    print("나이만 맞았습니다. 이름은 \(tupleValue.name)")
default:
    print("누굴 찾나요?")
}

switch tupleValue {
case ("yagom", 50):
    print("정확히 맞췄습니다!")
case ("yagom", let age):
    print("이름만 맞았습니다. 나이는 \(age)입니다.")
case (let name, 99):
    print("나이만 맞았습니다. 이름은 \(name)입니다.")
default:
    print("누굴 찾나요?")
}

let 직급: String = "사원"
let 연차: Int = 1
let 인턴인가: Bool = false

switch 직급 {
case "사원" where 인턴인가 == true:
    print("인턴입니다.")
case "사원" where 연차 < 2 && 인턴인가 == false:
    print("신입사원입니다.")
case "사원" where 연차 > 5:
    print("연식 좀 된 사원 입니다.")
case "사원":
    print("사원입니다.")
case "대리":
    print("대리입니다.")
default:
    print("사장입니까?")
}

enum School {
    case primary, elementary, middle, high, college, university, graduate
}

let 최종학력: School = School.university

switch 최종학력 {
case .primary:
    print("최종학력은 유치원입니다.")
case .elementary:
    print("최종학력은 초등학교입니다.")
case .middle:
    print("최종학력은 중학교입니다.")
case .high:
    print("최종학력은 고등학교입니다.")
case .college, .university:
    print("최종학력은 대학(교)입니다.")
case .graduate:
    print("최종학력은 대학원입니다.")
}

enum Menu {
    case chicken
    case pizza
    case hambuger
}

let lunchMenu: Menu = Menu.chicken

switch lunchMenu {
case .chicken:
    print("반반 무많이")
case .pizza:
    print("핫소스 많이 주세요")
@unknown case _:
    print("오늘 메뉴가 뭐죠?")
}
// unknown 속성을 부여하여 경고를 통해서 해당 switch 구문이 모든 case에 대응하지 않는다는 사실을 상기할 수 있다.

// MARK: 반복문
// for-in 구문
for i in 0...2 {
    print(i)
}

for i in 0...5 {
    if i.isMultiple(of: 2) {
        print(i)
        continue
    }
    
    print("\(i) == 홀수")
}

let helloSwift: String = "Hello Swift!"

for char in helloSwift {
    print(char)
}

var result: Int = 1

for _ in 1...3 {
    result *= 10
}

print("10의 3제곱은 \(result)입니다.")

// Dictionary
let friends: [String: Int] = ["Jay": 35, "Joe": 39, "Jenny": 31]

for tuple in friends {
    print(tuple)
}

let 주소: [String: String] = ["도": "충청북도", "시군구":"청주시 청원구", "동읍면":"율량동"]

for (키, 값) in 주소 {
    print("\(키) : \(값)")
}

// Set
let 지역번호: Set<String> = ["02", "031", "032", "033", "041", "042", "043"," 051", "052", "053", "054", "055", "061", "062", "063", "064"]

for 번호 in 지역번호 {
    print(번호)
}

// while 구문
var names: [String] = ["Joker", "Jenny", "Nova", "yagom"]

while names.isEmpty == false {
    print("Good bbye \(names.removeFirst())")
}

// repeat-while
names = ["Joker", "Jenny", "Nova", "yagom"]

repeat {
    print("Good bye \(names.removeFirst())")
} while names.isEmpty == false

// MARK: 구문 이름표
var numbers: [Int] = [3, 2342, 6, 3252]

numbersLoop: for num in numbers {
    if num > 5 || num < 1 {
        continue numbersLoop
    }
    
    var count: Int = 0
    
    printLoop: while true {
        print(num)
        count += 1
        
        if count == num {
            break printLoop
        }
    }
    
    removeLoop: while true {
        if numbers.first != num {
            break numbersLoop
        }
        numbers.removeFirst()
    }
}
