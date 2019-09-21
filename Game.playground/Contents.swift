import UIKit

class Unit {
    var hp: Double
    var damage: Double
    var defense: Double
    var agility: Double
    var strength: Double
    var nickname: String
    
    init(hp: Double, damage: Double, defense: Double, agility: Double, strength: Double, nickname: String) {
        self.hp = hp
        self.damage = damage
        self.defense = defense
        self.agility = agility
        self.strength = strength
        self.nickname = nickname
    }
    func attack(to enemy: Unit) {
        let damage = self.damage * (1 + strength/100)
        var reducedDamage = damage * (1 - enemy.defense/100)
        if Double.random(in: 0..<100) < enemy.agility {
            reducedDamage *= 0.5
        }
        enemy.hp -= reducedDamage
    }
}

class Weeb: Unit {
    // У анимешника снижена защита, но увеличена ловкость
    override init(hp: Double, damage: Double, defense: Double, agility: Double, strength: Double, nickname: String) {
        super.init(hp: hp, damage: damage, defense: defense, agility: agility, strength: strength, nickname: nickname)
        self.defense *= 0.75
        self.agility *= 1.5
    }
}

class Defender: Unit {
    // У защитника больше защиты и хп
    override init(hp: Double, damage: Double, defense: Double, agility: Double, strength: Double, nickname: String) {
        super.init(hp: hp, damage: damage, defense: defense, agility: agility, strength: strength, nickname: nickname)
        self.defense *= 2
        self.hp *= 2
    }
}

class Jedi: Unit {
    // У джедая снижена защита и хп, но серьезно увеличена ловкость и урон
    override init(hp: Double, damage: Double, defense: Double, agility: Double, strength: Double, nickname: String) {
        super.init(hp: hp, damage: damage, defense: defense, agility: agility, strength: strength, nickname: nickname)
        self.defense *= 0.5
        self.hp *= 0.7
        self.agility *= 1.5
        self.damage *= 1.5
        self.strength *= 1.25
    }
    
    // Есть также небольшой шанс на двойную атаку
    override func attack(to enemy: Unit) {
        print("attacking in a jedi way")
        if Double.random(in: 0..<100) > 95 {
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
    override init(hp: Double, damage: Double, defense: Double, agility: Double, strength: Double, nickname: String) {
        super.init(hp: hp, damage: damage, defense: defense, agility: agility, strength: strength, nickname: nickname)
        self.hp *= 1.75
        self.damage *= 2
        self.agility *= 0.1
        self.strength *= 1.5
    }
}

class ZonaArea {
    class func beginBattle(with attackers: [Unit], and guardians: [Unit], wave: Int) {
        var attackersMutable = attackers
        var defendersMutable = guardians
        
        var uniqueId = 1
        
        for waveNumber in 0..<wave {
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
                let numberOfReinforcements = 3 * (waveNumber+1)
                print("Атакующие были разбиты на \(waveNumber) волне и теперь к ним идет подкрепление в размере \(numberOfReinforcements) юнитов")
                for _ in 0..<numberOfReinforcements {
                    let random = Int.random(in: 0..<10)
                    if random <= 5 {
                        attackersMutable.append(Weeb(hp: 100, damage: 100, defense: 10, agility: 10, strength: 10, nickname: "Weeb_\(uniqueId)"))
                        uniqueId += 1
                    }
                    else if random > 5 && random < 8 {
                        attackersMutable.append(Jedi(hp: 100, damage: 100, defense: 10, agility: 10, strength: 10, nickname: "Jedi_\(uniqueId)"))
                        uniqueId += 1
                    }
                    else {
                        attackersMutable.append(ChuckNorris(hp: 100, damage: 100, defense: 10, agility: 10, strength: 10, nickname: "Chuck_\(uniqueId)"))
                        uniqueId += 1
                    }
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

attackers.append(Weeb(hp: 100, damage: 100, defense: 10, agility: 10, strength: 10, nickname: "Weeb1"))
attackers.append(Weeb(hp: 100, damage: 100, defense: 10, agility: 10, strength: 10, nickname: "Weeb2"))
attackers.append(Weeb(hp: 100, damage: 100, defense: 10, agility: 10, strength: 10, nickname: "Weeb3"))
attackers.append(Weeb(hp: 100, damage: 100, defense: 10, agility: 10, strength: 10, nickname: "Weeb4"))
attackers.append(Weeb(hp: 100, damage: 100, defense: 10, agility: 10, strength: 10, nickname: "Weeb5"))
attackers.append(Weeb(hp: 100, damage: 100, defense: 10, agility: 10, strength: 10, nickname: "Weeb6"))
attackers.append(Weeb(hp: 100, damage: 100, defense: 10, agility: 10, strength: 10, nickname: "Weeb7"))
attackers.append(Jedi(hp: 100, damage: 100, defense: 10, agility: 10, strength: 10, nickname: "Jedi1"))
attackers.append(Jedi(hp: 100, damage: 100, defense: 10, agility: 10, strength: 10, nickname: "Jedi2"))
attackers.append(Jedi(hp: 100, damage: 100, defense: 10, agility: 10, strength: 10, nickname: "Jedi3"))

defenders.append(Defender(hp: 100, damage: 100, defense: 10, agility: 10, strength: 10, nickname: "Defender1"))
defenders.append(Defender(hp: 100, damage: 100, defense: 10, agility: 10, strength: 10, nickname: "Defender2"))
defenders.append(Defender(hp: 100, damage: 100, defense: 10, agility: 10, strength: 10, nickname: "Defender3"))
defenders.append(Defender(hp: 100, damage: 100, defense: 10, agility: 10, strength: 10, nickname: "Defender4"))
defenders.append(Defender(hp: 100, damage: 100, defense: 10, agility: 10, strength: 10, nickname: "Defender5"))
defenders.append(Defender(hp: 100, damage: 100, defense: 10, agility: 10, strength: 10, nickname: "Defender6"))
defenders.append(Defender(hp: 100, damage: 100, defense: 10, agility: 10, strength: 10, nickname: "Defender7"))
defenders.append(Defender(hp: 100, damage: 100, defense: 10, agility: 10, strength: 10, nickname: "Defender8"))
defenders.append(Defender(hp: 100, damage: 100, defense: 10, agility: 10, strength: 10, nickname: "Defender9"))
defenders.append(Defender(hp: 100, damage: 100, defense: 10, agility: 10, strength: 10, nickname: "Defender10"))

ZonaArea.beginBattle(with: attackers, and: defenders, wave: 10)

