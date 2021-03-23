import UIKit

// MARK: 입출력 매개변수에서의 메모리 접근 충돌
var step: Int = 1
var copyOfStep: Int = step

func incerment(_ number: inout Int) {
    number += copyOfStep
}

incerment(&step)

func balance(_ x: inout Int, _ y: inout Int) {
    let sum = x + y
    x = sum / 2
    y = sum - x
}

// MARK: 메서드 내부에서 self 접근의 충돌
struct GamePlayer {
    var name: String
    var health: Int
    var energy: Int
    
    static let maxHealth = 10
    
    mutating func restoreHealth() {
        self.health = GamePlayer.maxHealth
    }
    
    mutating func shareHealth(with teammate: inout GamePlayer) {
        balance(&teammate.health, &health)
    }
}

var oscar: GamePlayer = GamePlayer(name: "Oscar", health: 10, energy: 10)
var maria: GamePlayer = GamePlayer(name: "Maria", health: 5, energy: 10)
oscar.shareHealth(with: &maria)
//oscar.shareHealth(with: &oscar)

