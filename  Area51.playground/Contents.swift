import UIKit


class Unit {
    let nickname: String
    var health: Int
    var damage: Int
    var protection: Int
    var agility: Int
    var alive: Bool = true // жив ли?
    
    init(name: String, health: Int, damage: Int, protection: Int, agility: Int) {
        self.nickname = name
        self.health = health
        self.damage = damage
        self.protection = protection
        self.agility = agility
    }
    
    func attack(enemy: Unit) {
        if damage > enemy.health && health > enemy.health {
            health = health + 4
            enemy.health = 0
        }else{
            health = 0
            enemy.health = enemy.health + 2
            
        }
    }
    
    func lifeCheck() -> Bool {
        
        if health == 0 ||  health < 0 {
            alive = false
        }
        else {
            alive = true
        }
        return alive
    }
}

class HomerSimpson: Unit{
    override func lifeCheck() -> Bool{
        if health == 0 || health < 0 || protection == 0 || protection < 0 {
            alive = false
            print(nickname + " Все я больше не могу идти! Идите дальше сами....а меня несите!")
        }
        return alive
    }
    
}

class Stitch: Unit{
    override func attack(enemy: Unit) {
        
        if damage > enemy.protection {
            health = health + enemy.health
            enemy.health = 0
        }
        else {
            enemy.health = enemy.health + 2
            
        }
    }
}

class PinkPanther: Unit{
    override func attack(enemy: Unit) {
        
        if health + damage > enemy.health {
            enemy.health = 0
        }
        else {
            enemy.health = enemy.health + 1
        }
    }
}

class Squidward: Unit {
}

class ZoneArea51 {
    func beginBattle(with attackers: [Unit], guardians: [Unit], wave: Int) {
        
        var newWave: Int = 0
        var printWave: Int = 0
        let numGuardians: Int = Int.random(in: 0..<guardians.count)
        let numAttackers: Int = Int.random(in: 0..<attackers.count)
        
        
        var countWinGuardians: Int = 0
        var countWinAttackers: Int = 0
        
        while(newWave < wave) {
            
            attackers[numAttackers].attack(enemy: guardians[numGuardians])
            if(guardians[numGuardians].lifeCheck()) {
                attackers[numAttackers].health = 0
                countWinGuardians += 1
            }
            else{
                countWinAttackers += 1
                printWave += 1
            }
            
            if(countWinGuardians > countWinAttackers) {
                print("Защитил и затащил: " + guardians[numGuardians].nickname)
            }
            else {
                print("Зона пала в " + "\(printWave)" + " волне")
            }
            newWave += 1
        }
    }
}

let homerSimpson = HomerSimpson(name: "Homer", health: 3, damage: 5, protection: 4, agility: 5)
let stitch = Stitch(name: "Stitch", health: 2, damage: 3, protection: 4, agility: 2)
let pinkPanther = PinkPanther(name: "PinkPanter", health: 6, damage: 4, protection: 5, agility: 7)
let squidward = Squidward(name: "Squidward", health: 2, damage: 7, protection: 7, agility: 3)

let area51 = ZoneArea51()
area51.beginBattle(with: [stitch, pinkPanther], guardians: [homerSimpson, squidward], wave: 3)
