import UIKit

class Unit{
    var health: Int
    var attack: Int
    var defense: Int
    var name: String
    var isAlive: Bool

    
    init(health: Int, attack: Int, defense: Int, name: String, isAlive: Bool){
        self.health = health
        self.attack = attack
        self.defense = defense
        self.name = name
        self.isAlive = isAlive
    }
    

    func attackEnemy(unit: Unit) -> Int {
        return (unit.health - (attack - unit.defense))
    }
    func isActive() {
        if (health <= 0) {
            isAlive = false
            print(self.name + " умер")
        }
    }
}

class Bad: Unit {
    func heal(health: Int){
        self.health += 15
        print("Бад-эль-Казар восстанавливает себе 15 здоровья")
    }
}
var bad = Bad(health: 100, attack: 30, defense: 20, name: "Bad-el-Kazar", isAlive: true)

class Mortu: Unit {
    
}
var mortu = Mortu(health: 1000, attack: 20, defense: 20, name: "Mortu-Macaab", isAlive: true)

class Soldier51: Unit {
    
}
var soldier51 = Soldier51(health: 3000, attack: 5000, defense: 10, name: "Soldier51", isAlive: true)

class Boss: Unit {
    
}

var boss = Boss(health: 1000, attack: 50, defense: 10, name: "Fibal Boss", isAlive: true)


class ZonaArea{
    var n: Int = 1
    func beginBattle(with attackers: Unit, guardians: Unit) {
        print("Волна 1 начинается")
        while ((attackers.isAlive == true) && (guardians.isAlive == true)) {
            guardians.health = attackers.attackEnemy(unit: guardians)
            attackers.health = guardians.attackEnemy(unit: attackers)
            attackers.isActive()
            guardians.isActive()
            if (attackers.isAlive == false) {
                print("Защитники Зоны 51 победили на первой волне")
                break
            }
            if (guardians.isAlive == false) {
                print("Атакующие Зону 51 победили первую волну")
                print("Волна 2 начинается")
                guardians.health = soldier51.health
                guardians.isAlive = true
                break
            }
            
        }
        
        while ((attackers.isAlive == true) && (guardians.isAlive == true)) {
            guardians.health = soldier51.health
            guardians.health = attackers.attackEnemy(unit: guardians)
            attackers.health = guardians.attackEnemy(unit: attackers)
            attackers.isActive()
            guardians.isActive()
            if (attackers.isAlive == false) {
                print("Защитники Зоны 51 победили на второй волне")
                break
            }
            if (guardians.isAlive == false) {
                print("Атакующие Зону 51 победили вторую волну")
                print("Файнал босс")
            }
        }
        
        guardians.health = boss.health
        guardians.attack = boss.attack
        guardians.defense = boss.defense
        guardians.isAlive = boss.isAlive
        while ((attackers.isAlive == true) && (guardians.isAlive == true)) {
            guardians.health = attackers.attackEnemy(unit: guardians)
            attackers.health = guardians.attackEnemy(unit: attackers)
            attackers.isActive()
            guardians.isActive()
            if (attackers.isAlive == false) {
                print("Файнал босс защитил Зону 51")
            }
            if (guardians.isAlive == false) {
                print("Атакующие Зону 51 победили файнал босса")
            }
        }
    }
}

var zonaArea = ZonaArea()
zonaArea.beginBattle(with: mortu, guardians: soldier51)
