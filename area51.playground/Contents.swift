import UIKit

// Армор уменьшает в n раз урон, скиллы увеличивают

class Unit {
    var health: Int = 100
    var damage: Int = 1
    var armour: Int = 1
    var skills: Int = 1
    var name: String
    var isLive: Bool = true
    
    init(name: String) {
        self.name = name
    }
    
    func attack(to enemy: Unit){
        let attackerDamage = self.damage * self.skills
        let defenderDamage = enemy.damage * enemy.skills
        
        self.health -= defenderDamage / armour
        enemy.health -= attackerDamage / armour
    }
}

class Narutorunners: Unit{
    // Быстро бегают тем самым нанося двойной урон
    override init(name: String) {
        super.init(name: name)
        skills = 2
    }
}

class Kazahi: Unit{
    override init(name: String) {
        super.init(name: name)
        print("Выпил бутылку кумыса, + 300 к урону")
        damage += 300
    }
    
}

class Army: Unit{
    override init(name: String) {
        super.init(name: name)
        armour = 3
        skills = 2
    }
    
}

var attackers = [Unit]()
var defenders = [Unit]()

func prepare(numberOfNarutorunners: Int, numberOfKazahi: Int, numberOfArmy: Int){
    var naruto = numberOfNarutorunners
    var kazahi = numberOfKazahi
    var army = numberOfArmy
    
    while army > 0{
        defenders.append(Army(name: "Армия Ирана"))
        army -= 1
    }
    
    while naruto > 0{
        attackers.append(Narutorunners(name: "НАРУТО!"))
        naruto -= 1
    }
    
    while kazahi > 0{
        attackers.append(Kazahi(name: "Тимек бар ма?"))
        kazahi -= 1
    }
}

class ZoneArea{
    
    
    func beginBattle(with attackers: [Unit], guardians: [Unit], wave: Int){
        
        let hitList = attackers
        let defenseList = guardians
        var checker = false
            
        for attacker in hitList{
            for guardian in defenseList{
                if guardian.isLive && attacker.isLive{
                    attacker.attack(to: guardian)
                }
                
                if (guardian.health <= 0) {
                    guardian.isLive = false
                    break
                }
                
                if attacker.health <= 0 {
                    attacker.isLive = false
                    continue
                }
            }
        
            for guardian in defenseList {
                if guardian.isLive && !checker {
                    print("Оборона истребила всех!")
                    checker = true
                    
            }
                
        }
            if !checker{
                print("Нападающие победили!")
            }
    }
}
}
    

var area51 = ZoneArea()
prepare(numberOfNarutorunners: 1, numberOfKazahi: 2, numberOfArmy: 3)

let numWaves = 3
var wave = 1

while wave <= numWaves{
    print("Волна \(wave) началась")
    area51.beginBattle(with: attackers, guardians: defenders, wave: wave)
    wave += 1
}









