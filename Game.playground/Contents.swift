import UIKit

class Unit {
    
    var health: Double = 100
    var damage: Double = 15
    var defense: Double = 10
    var sleight: Double = 10
    var name: String
    var isAlive = true
    var role = "Attacker"
    
    init(name: String) {
        self.name = name
    }
    
    func superpower(to enemy: Unit) {
        print("No superpower")
    }
    
    func attack(to enemy: Unit) {
        var damageGiven = self.damage
        
        // Если увернулся, то урона не получит
        if Double.random(in: 0..<100) < enemy.sleight {
            damageGiven = 0
        }
        
        if enemy.defense > 0 {
            enemy.defense -=  damageGiven
        } else {
            enemy.health -= damageGiven
        }
    }
}

// У защитников все-таки лучше защита но нет суперспособностей
class Defender: Unit {
    override init(name: String) {
        super.init(name: name)
        health *= 1.5
        defense *= 1.5
        role = "Defender"
    }
}

// Тут без комментариев
class Putin: Unit {
    override init(name: String) {
        super.init(name: name)
        health *= 1000
        damage *= 1000
        defense *= 1000
        sleight *= 1000
    }
    
    override func superpower(to enemy: Unit) {
        print("Повышены налоги на жизнь, жить стло сложнее")
        enemy.health -= 15
        enemy.damage -= 10
    }
}

// Голодный студент после сессии, умеет уворачиваться, но ценой здоровья
class HungryStudent: Unit {
    override init(name: String) {
        super.init(name: name)
        health *= 0.8
        sleight *= 2
    }
    override func superpower(to enemy: Unit) {
        print("Покушал и выпил банку энергетика")
        health += 20
        defense *= 1.5
    }
}

// Росгвардия
class RussianGuard: Unit {
    override init(name: String) {
        super.init(name: name)
        health *= 0.5
        defense *= 2
        damage *= 4
    }
    override func superpower(to enemy: Unit) {
        print("От росгвардии не убежать")
        enemy.sleight *= 0.6
    }
}

// I'll be back
class Terminator: Unit {
    override init(name: String) {
        super.init(name: name)
        health *= 6
        defense *= 10
    }
    override func superpower(to enemy: Unit) {
        print("Мне нужна твоя одежда")
        defense += enemy.defense
        enemy.defense = 0
    }
}

var attackers = [Unit]()
var guardians = [Unit]()

func prepareForBattle() {
    
    for num in 1...20 {
        guardians.append(Defender(name: "Defender #\(num)"))
    }
    
    attackers.append(Terminator(name: "Arnold"))
    attackers.append(RussianGuard(name: "Meeting Destroyer"))
    attackers.append(HungryStudent(name: "ITIS Student"))
    
    let randNum = Double.random(in: 0...1000)
    
    if randNum < 10 {
        attackers.append(Putin(name: "Vladimir Putin"))
        print("У защиты нет шансов")
        
        for number in 1...6 {
            attackers.append(RussianGuard(name: "Meeting Destroyer #\(number)"))
        }
        return
    } else {
        for number in 1...7 {
            attackers.append(RussianGuard(name: "Meeting Destroyer #\(number)"))
        }
    }
    print("Стороны разминаются и начинают биться\n")
}

class ZonaArea {
    
    func beginBattle(with attackers: [Unit], guardians: [Unit], wave: Int) {
        
        var attackersArray = attackers
        var guardiansArray = guardians
        var waveNum = 1
        
        while waveNum <= wave {
            while attackersArray.count != 0 && guardiansArray.count != 0 {
            
                // Сначала бьют захватчики
                if let attacker = attackersArray.randomElement() {
                    guard let aim = guardiansArray.randomElement() else {
                        attackersWon(on: waveNum)
                        return
                    }
                    
                    let randomNumber = Double.random(in: 0...100)
                    if randomNumber <= 7 {
                        attacker.superpower(to: aim)
                        print("Superpower from \(attacker.name) to \(aim.name)")
                    }
                    
                    attacker.attack(to: aim)
                    if aim.health <= 0 {
                        aim.isAlive = false
                        
                        print("\(aim.name) не смог выжить после \(attacker.name)")
                        print("____________________")
                        
                        guardiansArray.remove(at: guardiansArray.firstIndex(where: { !$0.isAlive })!)
                    }
                } else {
                    guardiansWon(after: waveNum)
                }
                
                // Потом отвечают защитники
                if let guardian = guardiansArray.randomElement() {
                    guard let aim = attackersArray.randomElement() else { return }
                    
                    guardian.attack(to: aim)
                    
                    if aim.health <= 0 {
                        aim.isAlive = false
                        
                        print("\(aim.name) не смог выжить после \(guardian.name)")
                        print("____________________")
                        
                        attackersArray.remove(at: attackersArray.firstIndex(where: { !$0.isAlive })!)
                    }
                } else {
                    attackersWon(on: waveNum)
                }
            }
            
            if attackersArray.isEmpty {
                
                let count = Int.random(in: 1...10)
                
                print("Атака отражена на \(waveNum) волне, вызываем подмогу в количестве \(count) росгвардейцев\n")
                
                for id in 0 ..< count  {
                    attackersArray.append(RussianGuard(name: "Russian Guard #\(id * 10)"))
                }
            }
            waveNum += 1
        }
    }
    
    func attackersWon(on wave: Int) {
        print("Победа атаки на \(wave) волне")
    }
    
    func guardiansWon(after wave: Int) {
        print("Защитники победили на \(wave) волнe!")
    }
    
}

var zone = ZonaArea()
prepareForBattle()
zone.beginBattle(with: attackers, guardians: guardians, wave: 4)



