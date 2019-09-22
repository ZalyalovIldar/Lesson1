import UIKit

class Unit {
    
    var hp: Double
    var damage: Double
    var defense: Double
    var agility: Double
    var strength: Double
    var nickname: String
    
    // if any customization is needed
    init(hp: Double, damage: Double, defense: Double, agility: Double, strength: Double, nickname: String) {
        
        self.hp = hp
        self.damage = damage
        self.defense = defense
        self.agility = agility
        self.strength = strength
        self.nickname = nickname
    }
    
    // default initializer
    init(nickname: String) {
        
        hp = 100
        damage = 100
        defense = 10
        agility = 10
        strength = 10
        self.nickname = nickname
    }
    
    func attack(to enemy: Unit) {
        
        let damage = self.damage * (1 + strength / 100)
        var reducedDamage = damage * (1 - enemy.defense / 100)
        if Double.random(in: 0 ..< 100) < enemy.agility {
            reducedDamage *= 0.5
        }
        enemy.hp -= reducedDamage
    }
}

class Weeb: Unit {
    
    // У анимешника снижена защита, но увеличена ловкость
    override init(nickname: String) {
        
        super.init(nickname: nickname)
        defense *= 0.75
        agility *= 1.5
    }
}

class Defender: Unit {
    
    // У защитника больше защиты и хп
    override init(nickname: String) {
        
        super.init(nickname: nickname)
        defense *= 2
        hp *= 2
    }
}

class Jedi: Unit {
    
    // У джедая снижена защита и хп, но серьезно увеличена ловкость и урон
    override init(nickname: String) {
        
        super.init(nickname: nickname)
        defense *= 0.5
        hp *= 0.7
        agility *= 1.5
        damage *= 1.5
        strength *= 1.25
    }
    
    // Есть также небольшой шанс на двойную атаку
    override func attack(to enemy: Unit) {
        
        if Double.random(in: 0 ..< 100) > 95 {
            super.attack(to: enemy)
            super.attack(to: enemy)
        }
        else {
            super.attack(to: enemy)
        }
    }
}

class ChuckNorris: Unit {
    
    // У Чака много хп и дамага, но шанс увернуться практически отсутствует
    override init(nickname: String) {
        
        super.init(nickname: nickname)
        hp *= 1.75
        damage *= 2
        agility *= 0.1
        strength *= 1.5
    }
}

class ZonaArea {
    
    class func beginBattle(with attackers: [Unit], and guardians: [Unit], wave: Int) {
        
        var attackersMutable = attackers
        var defendersMutable = guardians
        
        var uniqueId = 1
        
        for waveNumber in 0 ..< wave {
            while !defendersMutable.isEmpty && !attackersMutable.isEmpty {
                for guardian in defendersMutable {
                    if let target = attackersMutable.randomElement() {
                        guardian.attack(to: target)
                        if target.hp <= 0 {
                            // force-unwrapping, так как в данный момент времени такой атакующий всегда будет в массиве, ведь погиб он только что
                            attackersMutable.remove(at: attackersMutable.firstIndex(where: { $0.nickname == target.nickname })!)
                        }
                    }
                }
                for attacker in attackersMutable {
                    if let target = defendersMutable.randomElement() {
                        attacker.attack(to: target)
                        if target.hp <= 0 {
                            // force-unwrapping по аналогичной причине
                            defendersMutable.remove(at: defendersMutable.firstIndex(where: { $0.nickname == target.nickname })!)
                        }
                    }
                }
            }
            if defendersMutable.isEmpty {
                print("Атакующие победили на \(waveNumber) волне!")
                return
            }
            if attackersMutable.isEmpty {
                let numberOfReinforcements = 3 * (waveNumber + 1)
                print("Атакующие были разбиты на \(waveNumber) волне и теперь к ним идет подкрепление в размере \(numberOfReinforcements) юнитов")
                for _ in 0 ..< numberOfReinforcements {
                    let random = Int.random(in: 0 ..< 10)
                    if random <= 5 {
                        attackersMutable.append(Weeb(nickname: "Weeb_\(uniqueId)"))
                    }
                    else if random > 5 && random < 8 {
                        attackersMutable.append(Jedi(nickname: "Jedi_\(uniqueId)"))
                    }
                    else {
                        attackersMutable.append(ChuckNorris(nickname: "Chuck_\(uniqueId)"))
                    }
                    uniqueId += 1
                }
            }
        }
        if !defendersMutable.isEmpty {
            print("Защитники продержались \(wave) волн и победили!")
        }
    }
}

var attackers = [Unit]()
var defenders = [Unit]()

for i in 1 ... 10 {
    attackers.append(Weeb(nickname: "Weeb\(i)"))
    defenders.append(Defender(nickname: "Defender\(i)"))
}

ZonaArea.beginBattle(with: attackers, and: defenders, wave: 4)

