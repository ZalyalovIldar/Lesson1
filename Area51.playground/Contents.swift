import UIKit

class Unit {
    
    fileprivate let nickname: String
    fileprivate var health: Double
    fileprivate var armor: Int
    fileprivate var damage: Int
    fileprivate var agility: Double
    fileprivate var isAlive: Bool = true
    
    func attack(to enemy: Unit) {
        if enemy.armor > 0 {
            enemy.armor -= self.damage
        }
        else {
            enemy.health -= self.health - 0.2 * agility
        }
    }
    
    init(nickname: String, health: Double, armor: Int, damage: Int, agility: Double) {
        self.nickname = nickname
        self.health = health
        self.armor = armor
        self.damage = damage
        self.agility = agility
    }
}

class Yoda: Unit {
    
    override func attack(to enemy: Unit) {
        if enemy.armor > 0 {
            enemy.armor -= self.damage
        }
        else {
            enemy.health -= self.health - 0.2 * agility
        }
        print("Luminous beings are us ... not this gross matter")
    }
}

class BenSolo: Unit {
    
    override func attack(to enemy: Unit) {
        if enemy.armor > 0 {
            enemy.armor -= self.damage
        }
        else {
            enemy.health -= self.health - 0.2 * agility
        }
        print("Yes, Master Skywalker. And me too...")
    }
}

class LukуSkywalker: Unit {
    
    override func attack(to enemy: Unit) {
        if enemy.armor > 0 {
            enemy.armor -= self.damage
        }
        else {
            enemy.health -= self.health - 0.2 * agility
        }
        print("I'm glad you came, Ben")
    }
}

class Stormtrooper: Unit {
    
    override func attack(to enemy: Unit) {
        if enemy.armor > 0 {
                enemy.armor -= self.damage
            }
            else {
                enemy.health -= self.health - 0.2 * agility
            }
            print("To battle! For the emperor!")
    }
}

class ChuckNorris: Unit {
    
    override func attack(to enemy: Unit) {
        if enemy.armor > 0 {
                enemy.armor -= self.damage
            }
            else {
                enemy.health -= self.health - 0.2 * agility
            }
            print("When the Boogeyman goes to sleep every night, he checks his closet for Chuck Norris.")
    }
}

class GuardianOfZone51: Unit {
    
    override func attack(to enemy: Unit) {
        if enemy.armor > 0 {
                enemy.armor -= self.damage
            }
            else {
                enemy.health -= self.health - 0.2 * agility
            }
            print("I always stand to the end, even if it's the end of my life")
    }
}

enum LevelOfDifficulty {
    
    case easy
    case mid
    case difficult
}

class ZonaArea {
    
    private var waveCount = 1
    private var countGuardians = 0
    private var guardians = [Unit]()
    private var allAttackers = [Unit]()
    
    private func checkAllDied(units: [Unit]) -> Bool {
        
        units.filter { $0.isAlive == false }
        
        if units.isEmpty {
            return true
        }
        
        return false
    }
    
    private func getAttackers(difficulty: LevelOfDifficulty, allAttackers: [Unit]) -> [Unit] {
        
        var attackers = [Unit]()
        var stepDifficulty = Int(allAttackers.count / 3)
        
        switch difficulty {
        case .easy:
            for x in 0 ... stepDifficulty {
                attackers.append(allAttackers[x])
            }
        case .mid:
            stepDifficulty *= 2
            for x in 0 ... stepDifficulty {
                attackers.append(allAttackers[x])
            }
        case .difficult:
            attackers = allAttackers
        }
        
        return attackers
    }
    
    private func startOneWave(wave: Int, difficulty: LevelOfDifficulty) -> Bool {
        
        let attackers = getAttackers(difficulty: difficulty, allAttackers: self.allAttackers)
        
        for oneAttacker in attackers {
            
            if guardians[countGuardians].isAlive && countGuardians < guardians.count - 1 {
                countGuardians += 1
            }
            
            oneAttacker.attack(to: guardians[countGuardians])
        }
        
        return !checkAllDied(units: guardians)
    }
    
    func beginBattle(withAttackers: [Unit], guardians: [Unit], wave: Int) -> String {
        
        self.guardians = guardians
        self.allAttackers = withAttackers
        
        for i in 1 ... wave {
            var check: Bool
            if i < 3 {
                check = startOneWave(wave: i, difficulty: .easy)
            }
            else if i < 10 {
                check = startOneWave(wave: i, difficulty: .mid)
            }
            else {
                check = startOneWave(wave: i, difficulty: .difficult)
            }
            
            if !check {
                return "The attackers won on the \(i) wave and broke into Area 51!"
            }
        }
        
        return "All attacks are successfully repulsed, the attackers laid down their arms and showed a white flag"
    }
}

enum KindOfUnits {
    
    case guardians
    case attackers
}

func createUnits(kind: KindOfUnits) -> [Unit] {
    
    var units = [Unit]()
    
    switch kind {
    case .guardians:
        for x in 1 ... 10 {
            units.append(GuardianOfZone51(nickname: "Soldier_\(x)", health: 500, armor: 200, damage: 25, agility: 30))
        }
    case .attackers:
        for x in 1 ... 4 {
            units.append(Stormtrooper(nickname: "Stormtrooper_\(x)", health: 200, armor: 100, damage: 25, agility: 5))
        }
        for x in 1 ... 2 {
            units.append(BenSolo(nickname: "Ben Solo_\(x)", health: 100, armor: 300, damage: 50, agility: 10))
        }
        for x in 1 ... 2 {
            units.append(LukуSkywalker(nickname: "Luky Skywalker_\(x)", health: 300, armor: 0, damage: 30, agility: 30))
        }
        for x in 1 ... 2 {
            units.append(Yoda(nickname: "Yoda_\(x)", health: 50, armor: 50, damage: 70, agility: 20))
        }
        for x in 3 ... 15 {
            units.append(ChuckNorris(nickname: "Chuck Norris_\(x)", health: 100, armor: 70, damage: 100, agility: 10))
        }
    }
    
    return units
}

var battleZone = ZonaArea()
var guardians = createUnits(kind: .guardians)
var attackers = createUnits(kind: .attackers)

print(battleZone.beginBattle(withAttackers: attackers, guardians: guardians, wave: 15))

