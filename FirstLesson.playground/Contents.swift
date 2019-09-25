import UIKit

public class Unit {
    
    var name: String
    var typeOfAttack: String
    var HP: Int
    var damage: Int
    var armor: Int
    var agility: Int
    var isAlive: Bool = true
    
    init(name: String, typeOfAttack: String, HP: Int, damage: Int, armor: Int,agility: Int) {
        self.name = name
        self.typeOfAttack = typeOfAttack
        self.HP = HP
        self.damage = damage
        self.armor = armor
        self.agility = agility
    }
    
    func attack(enemy: Unit) {
        if typeOfAttack == "melee" {
            enemy.HP = enemy.HP + armor - damage
        }
        else {                                      //Heroes hwo have range type of attack can miss
            if Int.random(in:0...100) < agility {   // if not missed
        enemy.HP = enemy.HP + armor - damage
        }
            else{                                      // if missed
            enemy.HP = enemy.HP + (enemy.HP * 10)/100
            }
        }
    }
    
    func lifeCheck() -> Bool {
             if(HP >= 0) {
                isAlive = true
             }
             else {
                 isAlive = false
             }
             return isAlive
    }
}
     
    class Jedi: Unit {
        override init ( name: String, typeOfAttack: String = "melee", HP: Int = 100,damage: Int = 65, armor: Int = 20, agility: Int = 90) {
            super.init(name: name,typeOfAttack: typeOfAttack,HP: HP, damage: damage,
                       armor: armor, agility: agility)
        }
        override func attack(enemy: Unit) {
            if Int.random(in: 40...100)>20{
                damage * 2
                print("Critical damage")
            }
        }
    }
    
    class Clone: Unit {
        override init( name: String, typeOfAttack: String = "range", HP: Int = 50, damage: Int = 35, armor: Int = 10, agility: Int = 1) {
            super.init(name: name,typeOfAttack: typeOfAttack,HP: HP, damage: damage,
            armor: armor, agility: agility)
        }
        override func attack(enemy: Unit) {
            if Int.random(in: 0...100)>50 {
                agility *= 100
                print("Oh, you missed")
            }
        }
    }

    class zone51Defender: Unit {
        override init( name: String, typeOfAttack: String = "melee", HP: Int = 1, damage: Int = 150, armor: Int = 1, agility: Int = 0) {
        super.init(name: name,typeOfAttack: typeOfAttack,HP: HP, damage: damage,
        armor: armor, agility: agility)
        }
        override func attack(enemy: Unit) {
            if Int.random(in: 0 ... 100)>20 {
                HP += 1000
                armor *= 2
                print("I became stronger")
            }
        }
    }

    class ZonaArea{
        func beginBattle(with attackers: [Unit], guardians: [Unit], wave: Int) {
            var newWave: Int = 1
            var lastWave: Int = 0
            let guardiansNumber: Int = Int.random(in: 0..<guardians.count)
            let attackersNumber: Int = Int.random(in: 0..<attackers.count)
            var counterWinGuardians: Int = 0
            var counterWinAttackers: Int = 0

            while newWave < wave {
                attackers[attackersNumber].attack(enemy: guardians[guardiansNumber])
                if guardians[guardiansNumber].lifeCheck() == true {
                    counterWinGuardians += 1
                       } else {
                    counterWinAttackers += 1
                    lastWave += 1
                        }
                if counterWinGuardians > counterWinAttackers {
                    print(guardians[guardiansNumber].name + "Wins " )
                } else {
                    print("You lose on " + "\(lastWave)" + " wave")
                }
                newWave += 1
            }
        }
    }

let lukeSkywalker = Jedi(name: "Luke Skywalker")
let obiWanKenobi = Jedi(name: "Obi-Wan Kenobe")
let yoda = Jedi(name: "Yoda")
let finn = Clone(name: "Finn")
let clone = Clone(name:"Clone")
let defender = zone51Defender(name: "IMMORTAL DEFENDER")

let zonearea51 = ZonaArea()
zonearea51.beginBattle(with: [lukeSkywalker, obiWanKenobi,yoda,finn], guardians: [clone, defender], wave: 2)


