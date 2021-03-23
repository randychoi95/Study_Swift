import UIKit

// MARK: 오류처리
enum VendingMachineError: Error {
    case invalidSelectin
    case insufficientFunds(coinsNeeded: Int)
    case outOfStock
}

// 함수에서 발생한 오류 알리기
// do - catch 구문을 이용하여 오류처리
struct Item {
    var price: Int
    var count: Int
}

class VendingMachine {
    var inventory = [
        "Candy Bar": Item(price: 12, count: 7),
        "Chips": Item(price: 10, count: 4),
        "Biscuit": Item(price: 7, count: 11)
    ]
    
    var coinsDeposited = 0
    
    func dispense(snack: String) {
        print("\(snack) 제공")
    }
    
    func vend(itemNamed name: String) throws {
        guard let item = self.inventory[name] else {
            throw VendingMachineError.invalidSelectin
        }
        
        guard item.count > 0 else {
            throw VendingMachineError.outOfStock
        }
        
        guard item.price <= self.coinsDeposited else {
            throw VendingMachineError.insufficientFunds(coinsNeeded: item.price - self.coinsDeposited)
        }
        
        self.coinsDeposited -= item.price
        
        var newItem = item
        newItem.count -= 1
        self.inventory[name] = newItem
        
        self.dispense(snack: name)
    }
}

let favoriteSnacks = [
    "yagom": "Chips",
    "jinsung": "Biscuit",
    "heejin": "Chocolate"
]

func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) {
    let snackName = favoriteSnacks[person] ?? "Candy Bar"
    tryingVend(itemdNamed: snackName, vendingMachine: vendingMachine)
}

struct PurchasedSnack {
    let name: String
    init(name: String, vendingMachine: VendingMachine) {
        tryingVend(itemdNamed: name, vendingMachine: vendingMachine)
        self.name = name
    }
}

func tryingVend(itemdNamed: String, vendingMachine: VendingMachine) {
    do{
        try vendingMachine.vend(itemNamed: itemdNamed)
    } catch VendingMachineError.invalidSelectin {
        print("유효하지 않은 선택")
    } catch VendingMachineError.outOfStock {
        print("품절")
    } catch VendingMachineError.insufficientFunds(let coinsNeeded) {
        print("자금 부족 - 동전 \(coinsNeeded)개를 추가로 지급해주세요.")
    } catch {
        print("그 외 오류 발생 : ", error)
    }
}

let machine: VendingMachine = VendingMachine()
machine.coinsDeposited = 20

var purchase: PurchasedSnack = PurchasedSnack(name: "Biscuit", vendingMachine: machine)

print(purchase.name)

purchase = PurchasedSnack(name: "Ice Cream", vendingMachine: machine)

print(purchase.name)

for (person, favoriteSnack) in favoriteSnacks {
    print(person, favoriteSnack)
    try buyFavoriteSnack(person: person, vendingMachine: machine)
}

// 옵셔널 값으로 오류처리
func someThrowingFunction(shouldThrowError: Bool) throws -> Int {
    if shouldThrowError {
        enum SomeError: Error {
            case justSomeError
        }
        throw SomeError.justSomeError
    }
    return 100
}

let x: Optional = try? someThrowingFunction(shouldThrowError: true)
print(x)

var y: Optional = try? someThrowingFunction(shouldThrowError: false)
print(y)

// 오류가 발생하지 않을 것이라고 확신하는 방법
y = try! someThrowingFunction(shouldThrowError: false)
print(y)


// MARK: 다시 던지기
func someThrowingFuction() throws {
    enum SomeError: Error {
        case justSomeError
    }
    
    throw SomeError.justSomeError
}

// 다시 던지기 함수
func someFunction(callback: () throws -> Void) rethrows {
    enum AnotherError: Error {
        case justAnotherError
    }
    
    do {
        try callback()
    } catch {
        throw AnotherError.justAnotherError
    }
}

do {
    try someFunction(callback: someThrowingFuction)
} catch {
    print(error)
}

protocol SomeProtocol {
    func someThrowingFunctionFromProtocol(callback: () throws -> Void) throws
    func someRethrowingFunctionFromProtocol(callback: () throws -> Void) rethrows
}

class SomeClass: SomeProtocol {
    func someThrowingFunctionFromProtocol(callback: () throws -> Void) throws { }
    func someFunction(callback: () throws -> Void) rethrows { }
    
    // 던지기 메서드는 다시 던지기 메서드를 요구하는 프로토콜을 충족할 수 없습니다.
//    func someRethrowingFunctionFromProtocol(callback: () throws -> Void) throws { }
    func someRethrowingFunctionFromProtocol(callback: () throws -> Void) rethrows { }
    
    // 다시 던지기 메서드는 던지기 메서드를 요구하는 프로토콜의 요구사항에 부합합니다.
//    func someThrowingFunctionFromProtocol(callback: () throws -> Void) rethrows { }
}

class SomeChildClass: SomeClass {
    // 부모클래스의 던지기 메서드는 자식클래스에서 다시 던지기 메서드로 재정의할 수 있습니다.
    override func someThrowingFunctionFromProtocol(callback: () throws -> Void) rethrows { }
    
    // 부모클래스의 다시 던지기 메서드는 자식 클래스에서 던지기 메서드로 재정의할 수 없습니다.
//    override func someFunction(callback: () throws -> Void) throws { }
}

// MARK: 후처리 defer
for i in 0...2 {
    defer {
        print("A", terminator: " ")
    }
    print(i, terminator: " ")
    
    if i % 2 == 0 {
        defer {
            print("", terminator: "\n")
        }
        
        print("It's even", terminator: " ")
    }
}

func someThrowingFuction(shouldThrowError: Bool) throws -> Int {
    defer {
        print("First")
    }
    
    if shouldThrowError {
        enum SomeError: Error {
            case justSomeError
        }
        
        throw SomeError.justSomeError
    }
    
    defer {
        print("Second")
    }
    
    defer {
        print("Third")
    }
    
    return 100
}

// 오류를 던지기 직전까지 작성된 defer 구문까지만 실행됩니다.
try? someThrowingFuction(shouldThrowError: true)

try? someThrowingFuction(shouldThrowError: false)
