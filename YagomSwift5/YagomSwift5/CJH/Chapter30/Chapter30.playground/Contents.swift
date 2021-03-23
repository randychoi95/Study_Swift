import UIKit

// MARK: 불명확 타입
// 포장된 상품을 표현
protocol WrappedPrize {
    associatedtype Prize
    
    var wrapColor: String! { get }
    var prize: Prize! { get }
}

protocol Gundam { }
protocol Pokemon { }

struct WrappedGundam: WrappedPrize {
    var wrapColor: String!
    var prize: Gundam!
}

struct WrappedPokemon: WrappedPrize {
    var wrapColor: String!
    var prize: Pokemon!
}

struct PrizeMachine {
    func dispenseRandomPrize() -> some WrappedPrize {
        return WrappedGundam()
    }
}

let machine: PrizeMachine = PrizeMachine()
let wrappedPrize = machine.dispenseRandomPrize()
