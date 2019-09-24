import UIKit
public class Unit{
    var isAlive: Bool = true
    var health: Int
    var damage: Int
    let name: String
    var protection: Int
    let agility: Int
    
    init(name: String, protection: Int, agility: Int, health: Int, damage: Int) {
        self.name = name
        self.protection = protection
        self.agility = agility
        self.health = health
        self.damage = damage
    }
    func attack(unit: Unit){
        unit.health -= (damage*(agility+100)/100 - damage*unit.protection/100)
        health -= (unit.damage*(unit.agility+100)/100 - unit.damage*protection/100)
        if health <= 0{
            isAlive = false
        }
        if unit.health <= 0{
            unit.isAlive = false
        }
    }
}

class Guardian: Unit{
    override init(name: String, protection: Int = 25, agility: Int = 2, health: Int = 5000, damage: Int = 4000){
        super.init(name: name, protection: protection, agility: agility, health: health, damage: damage)
    }
}
class Assaulter: Unit{
    override init(name: String, protection: Int = 10, agility: Int = 3, health: Int = 3000, damage: Int = 50){
        super.init(name: name, protection: protection, agility: agility, health: health, damage: damage)
    }
}

class ElonMusk: Unit{
    override init(name: String, protection: Int = 50, agility: Int = 5, health: Int = 500, damage: Int = 70){
        super.init(name: name, protection: protection, agility: agility, health: health, damage: damage)
    }
}

class KeanuReeves: Unit{
    override init(name: String, protection: Int = 0, agility: Int = 10, health: Int = 500, damage: Int = 0){
        super.init(name: name, protection: protection, agility: agility, health: health, damage: damage)
    }
    override func attack(unit: Unit) {
        damage = unit.health
        unit.health -= damage
        health -= unit.damage
        if health <= 0{
            isAlive = false
        }
        if unit.health <= 0{
            unit.isAlive = false
        }
    }
}

class ZoneArea{
    var guardiansAreAlive = true
    func beginAssault(waves: [Array<Unit>]) {
        for i in 0 ..< waves.count{
            if guardiansAreAlive{
                beginBattle(attackers: waves[i], defenders: guardians)
            }
            else{
                print("Assaulters win ", i)
                break
            }
        }
        if guardiansAreAlive{
            print("guardians win")
        }
        else{
            print("Assaulters win ", waves.count)
        }
    }
    
    func beginBattle(attackers: [Unit], defenders: [Unit]){
        ex: for i in 0 ..< attackers.count{
            attackerIsAliveCheck:
            while attackers[i].isAlive{
                for j in 0 ..< defenders.count{
                    if defenders[j].isAlive{
                        while defenders[j].isAlive {
                            if attackers[i].isAlive{
                                attackers[i].attack(unit: defenders[j])
                                if !defenders[defenders.count - 1].isAlive{
                                    guardiansAreAlive = false
                                }
                                print(attackers[i].name, attackers[i].health, defenders[j].name,defenders[j].health, defenders[j].isAlive)
                            }
                            else {break attackerIsAliveCheck}
                        }
                    }
                    else if !defenders[defenders.count - 1].isAlive{
                        guardiansAreAlive = false
                        break ex
                    }
                }
            }
        }
    }
}
    
let assaulter1 = Assaulter(name: "assaulter1")
let assaulter2 = Assaulter(name: "assaulter2")
let assaulter3 = Assaulter(name: "assaulter3")

let elonMusk1 = ElonMusk(name: "Elon")
let elonMusk2 = ElonMusk(name: "Musk")

let keanuReeves = KeanuReeves(name: "Keanu")

let guardian1 = Guardian(name: "guardian1")
let guardian2 = Guardian(name: "guardian2")
let guardian3 = Guardian(name: "guardian3")
let guardian4 = Guardian(name: "guardian4")
let guardian5 = Guardian(name: "guardian5")
let guardian6 = Guardian(name: "guardian6")
let guardian7 = Guardian(name: "guardian7")
let guardian8 = Guardian(name: "guardian8")

var guardians = [guardian1]

let wave1 = [assaulter1, assaulter2, assaulter3]
let wave2 = [elonMusk1, elonMusk2]
let wave3 = [keanuReeves]
let waves = [[assaulter1, assaulter2, assaulter3], [elonMusk1, elonMusk2], [keanuReeves]]
var zone51 = ZoneArea()
zone51.beginAssault(waves: waves)
