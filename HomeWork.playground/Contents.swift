import UIKit

/*                      ~ Area 51 Storm Game ~
 
                            Правила битвы:
1. Каждый нападающий атакует каждого защитника зоны пока не умрет.
2. Порядок атаки: первый атакует защитник зоны, в ответ атакует нападающий.
3. В случае, если при прохождении полного круга в живых остались как защитники, так и нападающие, нападение продолжается по новому кругу.
4. Если защитник зоны погибает, на его место встает другой защитник и круг атакующих начинается заного, но с уже полученными увечьями, если таковые имеются.
5. Если погибает атакующий, круг атакующих продолжается дальше.
6. Броня снижает получаемый урон в соотношении 1 к 1 (1 броня - 1 единица урона).
 
*/

class Unit{
    var health : Int!
    var armor : Int!
    var damage : Int!
    var name : String!
    
    func attack(target : Unit) {
        target.takeDamage(amountOfDamage: self.damage!)
    }
    
    func takeDamage(amountOfDamage : Int) {
        var damage = amountOfDamage - self.armor!
        if damage>0{
            self.health-=damage
        }
    }
}

class Kyle : Unit{
    override init() {
        super.init()
        self.health = 20
        self.armor = 3
        self.damage = 6
        self.name = "Kyle"
    }
}

class NarutoRunner : Unit{
    override init() {
        super.init()
        self.health = 5
        self.armor = 1
        self.damage = 4
        self.name = "Naruto Runner"
    }
}

class RockThrower : Unit{
    override init() {
        super.init()
        self.health = 10
        self.armor = 0
        self.damage = 10
        self.name = "Rock Thrower"
    }
}

class Zone51Guardian : Unit{
    override init() {
        super.init()
        self.health = 100
        self.armor = 3
        self.damage = 8
        self.name = "Zone 51 Guardian"
    }
}
var waveCounter = 1
  /*=================
    Game Settings
=================*/
var guardianCounter = 10
var kyleCounter = 9
var narutorunnerCounter = 15
var rockthrowerCounter = 5

var guardianArray : [Unit] = []
var attackerArray : [Unit] = []

func guardiansFactory() -> [Unit]{
    for _ in 1..<guardianCounter {
        guardianArray.append(Zone51Guardian())
    }
    
    return guardianArray
}

func attackersFactory() -> [Unit]{
    
    attackerArray.removeAll()
    
    for _ in 1..<narutorunnerCounter {
        attackerArray.append(NarutoRunner())
    }
    
    for _ in 1..<kyleCounter {
        attackerArray.append(Kyle())
    }
    
    for _ in 1..<rockthrowerCounter {
        attackerArray.append(RockThrower())
    }
    
    return attackerArray
}

class ZonaArea{
    func beginBattle(with attackers: [Unit] = attackersFactory(), guardians: [Unit] = guardiansFactory(), wave: Int = waveCounter) {
        repeat{
            repeat{
                for guardian in guardianArray {
                    for attacker in attackerArray {
                        
                        guardian.attack(target: attacker)
                        if attacker.health<=0{
                            attackerArray.remove(at: attackerArray.firstIndex{$0 === attacker}!)
                            continue
                        }
                        
                        attacker.attack(target: guardian)
                        if guardian.health<=0{
                           guardianArray.remove(at: guardianArray.firstIndex{$0 === guardian}!)
                           break
                        }
                    }
                }
            } while guardianArray.count != 0 && attackerArray.count != 0
        
            if guardianArray.count != 0 {
            waveCounter += 1
            narutorunnerCounter += waveCounter*3
            kyleCounter += waveCounter*2
            rockthrowerCounter += waveCounter
            attackerArray = attackersFactory()
            } else {
                print("Attackers WIN in \(waveCounter) wave(s)!")
                print("        (￣^￣)ゞ")
                return
              }
            
        } while waveCounter <= 10
        print("Guardians WIN!")
        print(" ¯＼_(ツ)_/¯")
    }
}

var battleInitializer = ZonaArea()
battleInitializer.beginBattle()


