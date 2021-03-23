import UIKit

// 스위프트 주요 함수의 사용
abs(-100)
abs(100)

let int8: Int8 = 5
let int64: Int64 = numericCast(int8)

let zeroes = repeatElement(0, count: 5)
for x in zeroes {
    print(x)
}

var valueA: Int = 10
var valueB: Int = 10

assert(valueA == valueB, "valueA != valueB")

debugPrint(valueA, valueB, separator: ",", terminator: "")
debugPrint(valueA, valueB)

max(1, 3)
max(1,2,3,4,5,6,7,8)
min(1, 3)
min(1,2,3,4,5,6,7,8)

precondition(valueA ==  valueB, "value != value")

print(valueA, valueB, separator: ",", terminator: "")
print(valueA, valueB)

valueA = 100
valueB = 200

swap(&valueA, &valueB)
print(valueA, valueB)

let words = ["하나", "둘", "셋", "넷"]
let numbers = 1...4

for (word, number) in zip(words, numbers) {
    print("\(word): \(number)")
}

let naturalNumbers = 1...Int.max
let zipped = Array(zip(words, naturalNumbers))

print(zipped)

// 디버깅 식별자
func printDebugInfo() {
    print("\(#file) 파일의 \(#line)번 줄, \(#column)번 칸이고, \(#function) 함수 안에서 실행되고 있습니다.")
}

print(printDebugInfo())

#if os(Linux)
print("이 프로그램은 리눅스 환경을 위해 컴파일했습니다.")
#elseif os(macOS)
print("이 프로그램은 macOS 환경을 위해 컴파일했습니다.")
#elseif os(iOS)
print("이 프로그램은 iOS 환경을 위해 컴파일했습니다.")
#else
print("플랫폼을 인식할 수 없습니다.")
#endif

#if DEBUG
print("DEBUG 환경으로 컴파일했습니다.")
#elseif TEST_RELEASE
print("TEST RELEASE 환경으로 컴파일했습니다.")
#else
print("RELEASE 환경으로 컴파일했습니다.")
#endif

#if swift(>=3.0)
print("Swift 3.0과 같거나 높은 버전의 환경에서 컴파일했습니다.")
#elseif swift(>=2.0)
print("Swift 2.0과 같거나 높은 버전의 환경에서 컴파일했습니다.")
#else
print("Swift 2.0미만 버전의 환경에서 컴파일했습니다.")
#endif

#if compiler(>=5.0)
print("스위프트 5.0 이상의 컴파일러에서 컴파일했습니다.")
#elseif swift(>=4.2)
print("스위프트 4.2 이상의 버전에서 컴파일했습니다.")
#endif

// Encodable과 Decodable 프로토콜을 준수하는 타입 Person
struct Person: Codable {
    enum Gender: String, Codable {
        case male, female, unknown
    }
    
    var name: String
    var age: Int
    var gender: Gender
    var friends: [Person]
}

let yagom = Person(name: "yagom", age: 20, gender: .male, friends: [])
let hana = Person(name: "hana", age: 22, gender: .female, friends: [yagom])
let eric = Person(name: "eric", age: 25, gender: .male, friends: [yagom, hana])

// JSONEncoder 인스턴스 생성
var encoder  = JSONEncoder()

// JSONEncoder를 활용하여 Person 타입의 eric 인스턴스를 JSON문자열로 인코딩
let jsonData = try encoder.encode(eric)
let jsonString = String(data: jsonData, encoding: .utf8)
print(jsonString ?? "convert to json string failed")

// JSONEncoder를 활용하여 JSON 문자열을 Person타입의 인스턴스로 디코딩
let decoder = JSONDecoder()
let decoded: Person = try decoder.decode(Person.self, from: jsonData)
print(decoded.name)

struct Car: Codable {
    let wheelCount: Int
    let doorCount: Int
}

var snakeJsonString = "[{\"wheel_count\":4, \"door_count\":4},{\"wheel_count\":6, \"door_count\":2}]"
var snakeJsonData = snakeJsonString.data(using: String.Encoding.utf8)!

let snakeDecoder = JSONDecoder()
snakeDecoder.keyDecodingStrategy = JSONDecoder.KeyDecodingStrategy.convertFromSnakeCase

let cars = try snakeDecoder.decode([Car].self, from: snakeJsonData)
print(cars.count)

let snakeEncoder = JSONEncoder()

let nonSnakeJsonData = try snakeEncoder.encode(cars)
let nonSnakeJsonString = String(data: nonSnakeJsonData, encoding: .utf8)
print(nonSnakeJsonString ?? "convert to json string failed")

snakeEncoder.keyEncodingStrategy = JSONEncoder.KeyEncodingStrategy.convertToSnakeCase

snakeJsonData = try snakeEncoder.encode(cars)
snakeJsonString = String(data: snakeJsonData, encoding: .utf8)!
print(snakeJsonString)
