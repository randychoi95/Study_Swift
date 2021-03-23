import UIKit

// MARK: private, fileprivate
public struct SomeType {
    private var privateVariable = 0
    fileprivate var fileprivateVariable = 0
}

extension SomeType {
    public func publicMethod() {
        print("\(self.privateVariable), \(self.fileprivateVariable)")
    }
    
    private func privateMethod() {
        print("\(self.privateVariable), \(self.fileprivateVariable)")
    }
    
    fileprivate func fileprivateMethod() {
        print("\(self.privateVariable), \(self.fileprivateVariable)")
    }
}

struct AnotherType {
    var someInstance: SomeType = SomeType()
    
    mutating func someMethod() {
        self.someInstance.publicMethod()
        self.someInstance.fileprivateVariable = 100
        self.someInstance.fileprivateMethod()
    }
}
var anotherInstance = AnotherType()
anotherInstance.someMethod()

// MARK: 읽기 전용 구현
public struct SomeType2 {
    // 비공개 접근수준 저장 프로퍼티 count
    private var count: Int = 0
    
    // 공개 접근수준 저장 프로퍼티 publicStoredProperty
    public var publicStoredProperty: Int = 0
    
    // 공개 접근수준 저장 프로퍼티 publicGetOnlyStoredProperty
    // 설정자는 비공개 접근수준
    public private(set) var publicGetOnlyStoredProperty: Int = 0
    
    // 내부 접근수준 저장 프로퍼티 internalComputedProperty
    internal var internalComputedProperty: Int {
        get {
            return count
        }
        set {
            count += 1
        }
    }
    
    // 내부 접근수준 저장 프로퍼티 internalGetOnlyComputedProperty
    // 설정자는 비공개 접근수준
    internal private(set) var internalGetONlyComputedProperty: Int {
        get{
            return count
        }
        set {
            count += 1
        }
    }
    
    public subscript() -> Int {
        get{
            return count
        }
        set{
            count += 1
        }
    }
    
    // 공개 접근수준 서브스크립트
    // 설정자는 내부 접근수준
    public internal(set) subscript(some: Int) -> Int {
        get{
            return count
        }
        set{
            count += 1
        }
    }
}

var someInstance: SomeType2 = SomeType2()

// 외부에서 접근자, 설정자 모두 사용 가능
print(someInstance.publicStoredProperty)
someInstance.publicStoredProperty = 100

// 외부에서 접근자만 사용가능
print(someInstance.publicGetOnlyStoredProperty)
//someInstance.publicGetOnlyStoredProperty = 100

// 외부에서 접근자, 설정자 모두 사용 가능
print(someInstance.internalComputedProperty)
someInstance.internalComputedProperty = 100

// 외부에서 접근자만 사용가능
print(someInstance.internalGetONlyComputedProperty)
//someInstance.internalGetONlyComputedProperty = 100

// 외부에서 접근자, 설정자 모두 사용 가능
print(someInstance[])
someInstance[] = 100

// 외부에서 접근자만, 같은 모듈 내에서는 설정자도 사용 가능
print(someInstance)
someInstance[0] = 100
