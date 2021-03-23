import UIKit

// MARK: Int와 UInt
var integer: Int = -100
let unsignedInteger: UInt = 50
print("integer 값: \(integer), unsignedInteger 값: \(unsignedInteger)")
print("Int 최댓값: \(Int.max), Int 최솟값: \(Int.min)")
print("UInt 최댓값: \(UInt.max), UInt 최솟값: \(UInt.min)")
let largeInteger: Int64 = Int64.max
let smallInteger: UInt8 = UInt8.max
print("Int64 최댓값: \(largeInteger), UInt8 최댓값: \(smallInteger)")

//let tooLarge: Int = Int.max + 1
//let cannotBeNegetive: UInt = -5

//integer = unsignedInteger
integer = Int(unsignedInteger)

// MARK: Bool
var boolean: Bool = true
boolean.toggle() // true - false 반전
let iLoveYou: Bool = true
let isTimeUnlimited: Bool = false
print("시간은 무한합니까?: \(isTimeUnlimited)")

// MARK: Float, Double
// Float이 수용할 수 있는 범위를 넘어섭니다.
// 자신이 감당할 수 있는 만큼만 남기므로 정확도가 떨어집니다.
var floatValue: Float = 1234567890.1

// Double은 충분히 수용할 수 있습니다.
let doubleValue: Double = 1234567890.1

print("floatValue: \(floatValue), doubleValue: \(doubleValue)")

// Float이 수용할 수 있는 범위의 수로 변경합니다.
floatValue = 123456.1

// 문자열 보간법을 사용하지 않고 단순히 변수 또는 상수의 값만 보고 싶으면
// print 함수의 전달인자로 변수 또는 상수를 전달하면 됩니다.
print(floatValue)
Int.random(in: -100...100)

// MARK: Character
let alphabetA: Character = "A"
print(alphabetA)

// Character 값에 유니코드 문자를 사용할 수 있습니다.
let commandCharacter: Character = "❤️"
print(commandCharacter)

let 한글변수이름: Character = "ㄱ"
print("한글의 첫 자음: \(한글변수이름)")

// MARK: String
// 상수로 선언된 문자열은 변경이 불가능합니다.
let name: String = "yagom"

// 이니셜라이저를 사용하여 빈 문자열을 생성할 수 있습니다.
// var 키워드를 사용하여 변수를 생성했으므로 문자열의 수정 및 변경이 가능합니다.
var introduce: String = String()

// append() 메서드를 사용하여 문자열을 이어붙일 수 있습니다.
introduce.append("제 이름은")

// + 연산자를 통해서도 문자열을 이어붙일 수 있습니다.
introduce = introduce + " " + name + "입니다."
print(introduce)

// name에 해당하는 문자의 수를 셀 수 있습니다.
print("name의 글자 수 : \(name.count)")
// 빈 문자열인지 확인해볼 수 있습니다.
print("introduce가 비어있습니까?: \(introduce.isEmpty)")

// 유니코드의 스칼라값을 사용하려면 값에 해당하는 표현이 출력됩니다.
let unicodeScalarValue: String = "\u{2665}"
print("unicodeScalarValue: \(unicodeScalarValue)")

// 연산자를 통한 문자열 결합
let hello: String = "Hello"
let yagom: String = "yagom"
var greeting: String = hello + " " + yagom + "!"
print(greeting)

greeting = hello
greeting += " "
greeting += yagom
greeting += "!"
print(greeting)

// 연산자를 통한 문자열 비교
var isSameString: Bool = false
isSameString = hello == "Hello"
print(isSameString)

isSameString = hello == "hello"
print(isSameString)

isSameString = yagom == "yagom"
print(isSameString)

isSameString = yagom == "hello"
print(isSameString)

// 메서드를 통한 접두어, 접미어 확인
var hasPrefix: Bool = false
hasPrefix = hello.hasPrefix("He")
print(hasPrefix)

hasPrefix = greeting.hasPrefix("HE")
print(hasPrefix)

hasPrefix = greeting.hasPrefix("Hello ")
print(hasPrefix)

hasPrefix = yagom.hasPrefix("gom")
print(hasPrefix)

hasPrefix = hello.hasPrefix("Hello")
print(hasPrefix)

var hasSuffix: Bool = false
hasSuffix = hello.hasSuffix("He")
print(hasSuffix)

hasSuffix = hello.hasSuffix("llo")
print(hasSuffix)

hasSuffix = hello.hasSuffix("He")
print(hasSuffix)

hasSuffix = greeting.hasSuffix("yagom")
print(hasSuffix)

hasSuffix = greeting.hasSuffix("yagom!")
print(hasSuffix)

hasSuffix = yagom.hasSuffix("gom")
print(hasSuffix)

// 메서드를 통한 대소문자 변환
var convertedString: String = ""
convertedString = hello.uppercased()
print(convertedString)

convertedString = hello.lowercased()
print(convertedString)

convertedString = yagom.uppercased()
print(convertedString)

convertedString = yagom.lowercased()
print(convertedString)

convertedString = greeting.uppercased()
print(convertedString)

convertedString = greeting.lowercased()
print(convertedString)

// 프로퍼티를 통한 빈 문자열 확인
var isEmptyString: Bool = false
isEmptyString = greeting.isEmpty
print(isEmptyString)

greeting = "안녕"
isEmptyString = greeting.isEmpty
print(isEmptyString )

greeting = ""
isEmptyString = greeting.isEmpty
print(isEmptyString)

// 프로퍼티를 이용해 문자열 길이 확인
print(greeting.count)

greeting = "안녕하세요"
print(greeting.count)

greeting = "안녕!"
print(greeting.count)

// 코드상에서 여러 줄의 문자열을 직접 쓰고 싶다면 큰따옴표 세 개를 사용하면 됩니다.
// 큰 따옴표 세 개를 써주고 한 줄을 내려써야 합니다.
// 마지막 줄도 큰따옴표 세 개는 한 줄 내려써야 합니다.
greeting = """
안녕하세요 저는 야곰입니다.
스위프트 잘하고 싶어요!
잘 부탁드립니다!
"""
print(greeting)

// 특수문자
print("문자열 내부에\n 이런 \"특수문자\"를\t사용하면 \\이런 놀라운 결과를 볼 수 있습니다.")
print(#"문자열 내부에서 특수문자를 사용하기 싫다면 문자열 앞, 뒤에 #을 붙여주세요"#)
let number: Int = 100
print(#"특수문자를 사용하지 않을 때도 문자열 보간법을 사용하고 싶다면 \#(number) 해보세요"#)

// MARK: Any, AnyObject와 nil
var someVar: Any = "yagom"
someVar = 50
someVar = 100.1
