import UIKit

// MARK: 구조체
// 구조체 정의
struct BasicInformation {
    var name: String
    var age: Int
}

// 구조체 인스턴스의 생성 및 초기화
var yagomInfo: BasicInformation = BasicInformation(name: "yagom", age: 99)
yagomInfo.age = 100
yagomInfo.name = "Seba"

// MARK: 클래스
class Person {
    var height: Float = 0.0
    var weight: Float = 0.0
}

// 클래스 인스턴스의 생성과 초기화
var yagom: Person = Person()
yagom.height = 123.4
yagom.weight = 123.4

let jenny: Person = Person()
jenny.height = 123.4
jenny.weight = 123.4

// 클래스 인스턴스의 소멸
class Person2 {
    var height: Float = 0.0
    var weight: Float = 0.0
    
    deinit {
        print("Person 클래스의 인스턴스가 소멸됩니다.")
    }
}

var yagom2: Person2? = Person2()
yagom2 = nil

// MARK: 구조체와 클래스의 차이
struct BasicInformation2 {
    let name: String
    var age: Int
}

var yagomInfo2: BasicInformation2 = BasicInformation2(name: "yagom", age: 99)
yagomInfo2.age = 100

var friendInfo: BasicInformation2 = yagomInfo2

print("yagom's age: \(yagomInfo2.age)")
print("friend's age: \(friendInfo.age)")

friendInfo.age = 999

print("yagom's age: \(yagomInfo2.age)")
print("friend's age: \(friendInfo.age)")

class Person3 {
    var height: Float = 0.0
    var weight: Float = 0.0
}

var yagom3: Person3 = Person3()
var friend: Person3 = yagom3

print("yagom's height: \(yagom3.height)")
print("friend's height: \(friend.height)")

friend.height = 185.5

print("yagom's height: \(yagom3.height)")
print("friend's height: \(friend.height)")

func changeBasicInfo(_ info: BasicInformation2) {
    var copiedInfo: BasicInformation2 = info
    copiedInfo.age = 1
}
func changePersonInfo(_ info: Person3) {
    info.height = 155.3
}

// 전달인자는 값이 복사되어 전달되기 때문에 yagomInfo2의 값만 전달되는 것입니다.
changeBasicInfo(yagomInfo2)
print("yagom's age: \(yagomInfo2.age)")

// 전달인자로 yagom3의 참조가 전달되었기 때문에 yagom3이 참조하는 값들에 변화가 생깁니다.
changePersonInfo(yagom3)
print("yagom's height: \(yagom3.height)")

var yagom4: Person3 = Person3()
let friend2: Person3 = yagom4
let anotherFrirend: Person3 = Person3()

print(yagom4 === friend2)
print(yagom === anotherFrirend)
print(friend !== anotherFrirend)
