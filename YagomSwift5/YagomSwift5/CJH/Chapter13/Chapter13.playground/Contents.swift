import UIKit

// MARK: 기본 클로저
let names: [String] = ["wizplan", "eric", "yagom", "jenny"]

var reversed: [String] = names.sorted(by: { (first: String, second: String) -> Bool in
    return first > second
})
print(reversed)

// MARK: 후행 클로저
reversed = names.sorted { (first: String, second: String) -> Bool in
    return first > second
}
print(reversed)

// MARK: 클로저 표현 간소화
// 문맥을 이용한 타입 유추
reversed = names.sorted { (first, second) in
    return first > second
}

// 단축 인자 이름
reversed = names.sorted {
    return $0 > $1
}

// 암시적 반환 표현
reversed = names.sorted { $0 > $1 }

// 연산자 함수
reversed = names.sorted(by: >)
print(reversed)

// MARK: 값 획득
func makeIncrementer(forIncrement amount: Int) -> (() -> Int) {
    var runningTotal = 0
    func incrementer() -> Int {
        runningTotal += amount
        return runningTotal
    }
    return incrementer
}

let incrementByTwo: (() -> Int) = makeIncrementer(forIncrement: 2)

let first: Int = incrementByTwo()
let second: Int = incrementByTwo()
let third: Int = incrementByTwo()

let incrementByTen: (() -> Int) = makeIncrementer(forIncrement: 10)

let ten: Int = incrementByTen()
let twenty: Int = incrementByTen()
let thirty: Int = incrementByTen()

// MARK: 클로저는 참조 타입
let sameWithIncrementByTwo: (() -> Int) = incrementByTwo

let first2: Int = incrementByTwo()
let second2: Int = sameWithIncrementByTwo()

// MARK: 탈출 클로저
var completionHandlers: [() -> Void] = []

func someFunctionWithEscapingClosure(completionHandler: @escaping () -> Void) {
    completionHandlers.append(completionHandler)
}

typealias VoidVoidClosure = () -> Void
let firstClosure: VoidVoidClosure = {
    print("Closure A")
}
let secondClosure: VoidVoidClosure = {
    print("Closure B")
}

// first와 second 매개변수 클로저는 함수의 반환 값으로 사용될 수 있으므로 탈출 클로저입니다.
func returnOneClosure(first: @escaping VoidVoidClosure, second: @escaping VoidVoidClosure, shouldReturnFirstClosure: Bool) -> VoidVoidClosure {
    // 전달인자로 받은 클로저를 함수 외부로 다시 반환하기 때문에 함수를 탈출하는 클로저입니다.
    return shouldReturnFirstClosure ? first : second
}

// 함수에서 반환한 클로저가 함수 외부의 상수에 저장되었습니다.
let returnedClosure: VoidVoidClosure = returnOneClosure(first: firstClosure, second: secondClosure, shouldReturnFirstClosure: true)

returnedClosure()

var closures: [VoidVoidClosure] = []

// closure 매개변수 클로저는 함수 외부의 변수에 저장될 수 있으므로 탈출 클로저입니다.
func appendClosure(closure: @escaping VoidVoidClosure) {
    // 전달인자로 전달받은 클로저가 함수 외부의 변수 내부에 저장되므로 함수를 탈출합니다.
    closures.append(closure)
}

func functionWithNoescapeClosure(closure: VoidVoidClosure) {
    closure()
}

func functionWithEscapingClosure(completionHandler: @escaping VoidVoidClosure) -> VoidVoidClosure {
    return completionHandler
}

class SomeClass {
    var x = 10
    
    func runNoescapeClosure() {
        // 비탈출 클로저에서 self 키워드 사용은 선택 사항입니다.
        functionWithNoescapeClosure {
            x = 200
        }
    }
    
    func runExcapingClosure() -> VoidVoidClosure {
        // 탈출 클로저에서는 명시적으로 self를 사용해야 합니다.
        functionWithEscapingClosure {
            self.x = 100
        }
    }
}

let instance: SomeClass = SomeClass()
instance.runNoescapeClosure()
print(instance.x)

let returnedClosure2: VoidVoidClosure = instance.runExcapingClosure()
returnedClosure2()
print(instance.x)

// withoutActuallyEscaping
//func hasElements(in array: [Int], match predicate: (Int) -> Bool) -> Bool {
//    return (array.lazy.filter { predicate($0) }.isEmpty == false)
//}

let numbers: [Int] = [2, 4, 6, 8]

let evenNumberPredicate = { (number: Int) -> Bool in
    return number % 2 == 0
}

let oddNumberPredicate = { (number: Int) -> Bool in
    return number % 2 == 1
}

func hasElements(in array: [Int], match predicate: (Int) -> Bool) -> Bool {
    return withoutActuallyEscaping(predicate) { escapablePredicate in
        return (array.lazy.filter{ escapablePredicate($0) }.isEmpty == false)
    }
}

let hasEvenNumber = hasElements(in: numbers, match: evenNumberPredicate)
let hasOddNumber = hasElements(in: numbers, match: oddNumberPredicate)

print(hasEvenNumber)
print(hasOddNumber)

// MARK: 자동 클로저
var customersInLine: [String] = ["YoangWha", "SangYong", "SungHun", "HaMi"]
print(customersInLine.count)

// 클로저를 만들어두면 클로저 내부의 코드를 미리 실행(연산)하지 않고 가지고만 있습니다.
let customerProvider: () -> String = {
    return customersInLine.removeFirst()
}
print(customersInLine.count)

// 실제로 실행합니다.
print("Now serving \(customerProvider())!")
print(customersInLine.count)

customersInLine = ["YoangWha", "SangYong", "SungHun", "HaMi"]

func serveCustomer(_ customerProvider: () -> String) {
    print("Now serving \(customerProvider())!")
}

serveCustomer({ customersInLine.removeFirst() })

customersInLine = ["YoangWha", "SangYong", "SungHun", "HaMi"]

func serveCustomer(_ customerProveder: @autoclosure () -> String) {
    print("Now serving \(customerProvider())!")
}

serveCustomer(customersInLine.removeFirst())

customersInLine = ["minjae", "innoceive", "sopress"]

func returnProvider(_ customerProvider: @autoclosure @escaping () -> String) -> (() -> String) {
    return customerProvider
}
let customerProvider2: () -> String = returnProvider(customersInLine.removeFirst())
print("Now serving \(customerProvider2())!")
