import UIKit

class Unit {
    var armor: Int
    var attackPower: Int
    var health: Int
    var name: String
    var wave = 0
    
    init(name: String, armor: Int, attackPower: Int, health: Int) {
        self.name = name
        self.armor = armor
        self.attackPower = attackPower
        self.health = health
    }
    
    func updatePowerBy(wave: Int) {
        self.attackPower += wave
        self.health += wave
    }
    
    func attacks(whom: Unit) {
        whom.health -= self.attackPower + whom.armor
        print(self.name + " attacks " + whom.name + " for " + String(self.attackPower - whom.armor) + " damage. " + String(whom.armor) + " damage blocked")
        whom.react()
    }
    
    func react() {
        print(self.name + ": Oh you motherfucker. " + String(self.health) + " HP left.\n")
    }
}

var teamAssaulters = [] as [Unit]
var teamDefenders = [] as [Unit]

class MageAssaulter: Unit {
    var spellPower = 1
    
    func castSpellTo(whom: Unit) {
        whom.health -= (self.spellPower + self.attackPower - whom.armor)
        print(self.name + " attacks " + whom.name + " for " + String(self.spellPower) + " damage.")
        whom.react()
    }
    
    override func react() {
        print(self.name + ": You damn insect. " + String(self.health) + " HP left.\n")
    }
}

class Celebrity: Unit {
    func inspire() {
        print(self.name + ": I'm in!")
        for assaulter in teamAssaulters {
            assaulter.attackPower += 1
        }
        print("Assaulters inspired! Attack power is increased by 1.")
    }
}

class SuperHero: Unit {
    override func react() {
        print(self.name + ": Ouch! " + String(self.health) + " HP left.\n")
        print(self.name + ": Avengers Assemble!")
        for defender in teamDefenders {
            defender.health -= 1
        }
        print("Each defender got 1 damage.")
    }
}

func initTeams() {
    teamDefenders = []
    teamAssaulters = []
    for i in 1...5 {
        teamDefenders.append(Unit(name: "Zone Defender " + String(i), armor: 3, attackPower: 6, health: 20))
    }
    
    let doctorStrange = MageAssaulter(name: "Doctor Strange", armor: 2, attackPower: 1, health: 15)
    doctorStrange.spellPower = 7
    
    let harryPotter = MageAssaulter(name: "Harry Potter", armor: 1, attackPower: 0, health: 12)
    harryPotter.spellPower = 5
    
    let elonMusk = Celebrity(name: "Elon Musk", armor: 0, attackPower: 0, health: 10)
    elonMusk.name = "Elon Musk"
    
    let ironMan = SuperHero(name: "Iron Man", armor: 5, attackPower: 9, health: 20)
    
    teamAssaulters.append(doctorStrange)
    teamAssaulters.append(harryPotter)
    teamAssaulters.append(elonMusk)
    teamAssaulters.append(ironMan)
}

class BattleForArea51 {
    func increaseAssauletsPowerBy(assaulters: [Unit], wave: Int) {
        for assaulter in assaulters {
            assaulter.updatePowerBy(wave: wave)
        }
    }
    
    func beginBattle(oldAssaulters: [Unit], oldDefenders: [Unit], wave: Int) {
        increaseAssauletsPowerBy(assaulters: oldAssaulters, wave: wave)
        var assaulters = oldAssaulters
        var defenders = oldDefenders
        while defenders.count != 0 && assaulters.count != 0 {
            var currentAttacker = assaulters.randomElement()
            var defender = defenders.randomElement()!
            if currentAttacker is MageAssaulter {
                (currentAttacker as! MageAssaulter).castSpellTo(whom: defender)
                if defender.health <= 0 {
                    print(defender.name + " is dead\n\n")
                    defenders.remove(at: defenders.firstIndex(where: {$0 === defender})!)
                }
            }
            else if currentAttacker is Celebrity {
                (currentAttacker as! Celebrity).inspire()
            }
            else if currentAttacker is SuperHero {
                (currentAttacker as! SuperHero).attacks(whom: defender)
                if defender.health <= 0 {
                    print(defender.name + " is dead\n\n")
                    defenders.remove(at: defenders.firstIndex(where: {$0 === defender})!)
                }
            }
            if defenders.count == 0 || assaulters.count == 0 {
                break
            }
            currentAttacker = defenders.randomElement()
            defender = assaulters.randomElement()!
            currentAttacker!.attacks(whom: defender)
            if defender.health <= 0 {
                print(defender.name + " is dead\n\n")
                assaulters.remove(at: assaulters.firstIndex(where: {$0 === defender})!)
            }
        }
        if defenders.count != 0 {
            print("----------------------")
            print("DEFENDERS WON ON WAVE " + String(wave) + "... Going on.\n")
            let newWave = wave + 1
            initTeams()
            beginBattle(oldAssaulters: teamAssaulters, oldDefenders: teamDefenders, wave: newWave)
        }
        else {
            print("----------------------")
            print("ASSAULTERS WON ON WAVE " + String(wave))
        }
    }
}

print("MAY THE FIGHT BEGIN!\n")

initTeams()
var battle1 = BattleForArea51()
battle1.beginBattle(oldAssaulters: teamAssaulters, oldDefenders: teamDefenders, wave: 0)






