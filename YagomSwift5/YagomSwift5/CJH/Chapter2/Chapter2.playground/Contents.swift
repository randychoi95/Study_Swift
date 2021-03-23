import UIKit

// MARK: 콘솔 로그
struct BasicInformation {
    let name: String
    var age: Int
}

var yagomInfo: BasicInformation = BasicInformation(name: "yagom", age: 99)

class Person {
    var height: Float = 0.0
    var weight: Float = 0.0
}

let yagom : Person = Person()
yagom.height = 182.5
yagom.weight = 78.5

print(yagomInfo)
dump(yagomInfo)

print(yagom)
dump(yagom)

// MARK: 문자열 보간법
let name: String = "yagaom"
print("My name is \(name)")

// MARK: 주석
// 한 줄 주석

/* 여러 줄 주석을 시작할 때는 슬래시와 별표를 사용합니다.
 이 줄의 앞에는 별다른 표기가 없지만 이줄도 주석으로 인식합니다.
 주석을 끝내고 싶을 때는 별표를 먼저 쓰면 됩니다. */

/*
 한 줄만 주석을 달아도 무방합니다.
 */

/* 여러 줄 주석 안쪽에
/* 추가로 여러 줄 주석을 포함할 수 있으며
// 그 안에 한 줄 주석을 추가하여도 무방합니다.
*/
이 부분도 주석처리 됩니다.
*/

// MARK: 변수와 상수
let name2: String = "yagom"
var age: Int = 100
var job = "iOS Programmer"
let height2 = 181.5
print(type(of: height2))
age = 99
job = "Writer"
print("저의 이름은 \(name2)이고, 나이는 \(age)세이며, 직업은 \(job)입니다. 비밀이지만, 키는 \(height2)센티미터입니다.")
