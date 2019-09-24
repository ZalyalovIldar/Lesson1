import UIKit

class Unit {
    
    fileprivate var hp: Double
    fileprivate var damage: Double
    fileprivate var protection: Double
    fileprivate var agility: Double
    fileprivate var nickName: String
    fileprivate var isDied: Bool
    
    init(nickName: String) {
        
        self.hp = 200
        self.damage = 10
        self.protection = 30
        self.agility = 20
        self.nickName = nickName
        self.isDied = false
    }
    
    init(hp: Double, damage: Double, protection: Double, agility: Double, nickName: String, isDied: Bool) {
        
        self.hp = hp
        self.damage = damage
        self.protection = protection
        self.agility = agility
        self.nickName = nickName
        self.isDied = false
    }
    
    func attack(to_enemy: Unit){
        
        if to_enemy.protection > 0 {
            to_enemy.protection -= self.damage
        }
        else {
            to_enemy.hp -= self.damage - 0.1 * agility
        }
        if to_enemy.hp <= 0 {
            to_enemy.isDied = true
        }
    }
}

class SoldierOfZone51: Unit {
    
    override init(nickName: String) {
        super.init(nickName: nickName)
    }
}

class KungFuMaster: Unit {
    
    override init(nickName: String) {
        
        super.init(nickName: nickName)
        self.hp = 150
        self.damage = 50
        self.protection = 30
        self.agility = 50
    }
}

class Putin: Unit {
    
    override init(nickName: String) {
        
        super.init(nickName: nickName)
        self.hp = 500
        self.damage = 5
        self.protection = 50
        self.agility = 5
    }
}

class BrusLi: Unit {
    
    override init(nickName: String) {
        
        super.init(nickName: nickName)
        self.hp = 150
        self.damage = 100
        self.protection = 30
        self.agility = 70
    }
}

class Grazdan: Unit {
    
    override init(nickName: String) {
        
        super.init(nickName: nickName)
        self.hp = 70
        self.damage = 5
        self.protection = 5
        self.agility = 15
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
        
        for x in units {
            if !x.isDied {
                return false
            }
        }
        
        return true
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
            return allAttackers
        }
        
        return [Unit]()
    }
    
    private func startOneWave(wave: Int, difficulty: LevelOfDifficulty)  -> Bool{
        
        let attackers = getAttackers(difficulty: difficulty, allAttackers: self.allAttackers)
        
        for x in attackers {
            if guardians[countGuardians].isDied && countGuardians < guardians.count - 1 {
                countGuardians += 1
            }
            x.attack(to_enemy: guardians[countGuardians])
        }
        
        if checkAllDied(units: guardians) {
            return false
        }
        
        return true
    }
    
    func beginBattle(with_attackers: [Unit], guardians: [Unit], wave: Int) -> String {
        
        self.guardians = guardians
        self.allAttackers = with_attackers
        
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
                return "Атакующие победили на \(i) волне и прорвались в Зону 51!!!"
            }
        }
        
        return "В Зону 51 не прорвались!!!"
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
            units.append(SoldierOfZone51(nickName: "Soldier_\(x)"))
        }
    case .attackers:
        for x in 1 ... 4 {
            units.append(Grazdan(nickName: "Grazdan_\(x)"))
        }
        for x in 1 ... 2 {
            units.append(Putin(nickName: "Putin_\(x)"))
        }
        for x in 1 ... 2 {
            units.append(BrusLi(nickName: "Brus_\(x)"))
        }
        for x in 1 ... 2 {
            units.append(KungFuMaster(nickName: "Master_\(x)"))
        }
        for x in 3 ... 15 {
            units.append(KungFuMaster(nickName: "Master_\(x)"))
        }
    }
    
    return units
}

var battleZone = ZonaArea()
var guardians = createUnits(kind: .guardians)
var attackers = createUnits(kind: .attackers)

print(battleZone.beginBattle(with_attackers: attackers, guardians: guardians, wave: 15))
