import UIKit

public class Unit {
    private var health: Int
    private var damage: Int
    private var protection: Int
    private var agility: Int
    
    init(health: Int, damage: Int, protection: Int, agility: Int) {
        self.health = health
        self.damage = damage
        self.protection = protection
        self.agility = agility
    }
    
    func addAgilityBuff(){
        damage += agility
        protection += agility
    }
    
    func getHealth() -> Int{
        return health
    }
    
    func attack(enemy: Unit){
        enemy.health -= damage + protection
    }
}

public class Animeshnick : Unit {
    private var name: String
    
    init(name: String){
        self.name = name
        super.init(health: 50, damage: 20, protection: 0, agility: 10)
        addAgilityBuff()
    }
}

public class Jedi : Unit {
    private var name: String
    
    init(name: String){
        self.name = name
        super.init(health: 80, damage: 15, protection: 5, agility: 5)
        addAgilityBuff()
    }
}

public class ChuckNorris : Unit {
    private var name: String
    
    init(name: String){
        self.name = name
        super.init(health: 100, damage: 10, protection: 10, agility: 0)
        addAgilityBuff()
    }
}

public class Area51Defenser : Unit {
    private var name: String
    
    init(name: String){
        self.name = name
        super.init(health: 60, damage: 10, protection: 5, agility: 5)
        addAgilityBuff()
    }
}

public class ZonaArea51Game {
    func beginBattle(with attackers: [Unit], guardians: [Unit], wave: Int){
        var aliveAttackers = attackers
        var aliveGuardians = guardians
        var currentWave = 1
        while aliveGuardians.count != 0 || aliveAttackers.count != 0 {
            let currentAttacker = aliveAttackers[0]
            let currentGuardian = aliveGuardians[0]
            var isAttackerLoser: Bool = false
            while (currentAttacker.getHealth()) <= 0 || (currentGuardian.getHealth()) <= 0 {
                currentAttacker.attack(enemy: currentGuardian)
                currentGuardian.attack(enemy: currentAttacker)
                if currentAttacker.getHealth() <= 0{
                    isAttackerLoser = true
                }
            }
            if isAttackerLoser == true {
                aliveAttackers.remove(at: aliveAttackers.firstIndex(where: {$0 === aliveAttackers[0]})!)
            } else {
                aliveGuardians.remove(at: aliveGuardians.firstIndex(where: {$0 === aliveGuardians[0]})!)
            }
            if aliveGuardians.count == 0{
                print("Нападающие победили на \(wave) волне")
                break
            }
            if aliveGuardians.count == 0 && aliveAttackers.count == 0{
                print("Ничья")
                break
            }
            aliveAttackers.append(ChuckNorris(name: "Chuck Norris"))
        }
        if aliveGuardians.count != 0 {
            print("Бойцы Зоны 51 отбили волну (\(currentWave))")
            currentWave += 1
            beginBattle(with: aliveAttackers, guardians: aliveGuardians, wave: currentWave)
        }
    }
}

var attackersGame1 = [] as [Unit]
var defensersGame1 = [] as [Unit]
attackersGame1.append(Animeshnick(name: "animeshnick"))
attackersGame1.append(Jedi(name: "jedi"))
defensersGame1.append(Area51Defenser(name: "defenser"))
let game1 = ZonaArea51Game()
game1.beginBattle(with: attackersGame1, guardians: defensersGame1, wave: 2)


