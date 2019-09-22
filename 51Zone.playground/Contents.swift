class Unit{
    var name: String
    var isAlive: Bool
    var health: Int
    var attack: [Int]
    var SPECIAL: [Int]
    var defense: Int
    
    init(name: String, health: Int, attack: [Int], SPECIAL: [Int], defense: Int) {
        self.isAlive = true
        self.attack = attack
        self.SPECIAL = SPECIAL
        self.defense = defense
        self.health = health
        self.name = name
    }
    
    func atackEnemy(unit: Unit) -> Int {
        return unit.health - (Int.random(in: attack[0]...attack[1]))+SPECIAL[5]-unit.defense
    }
    func specialAbility() -> Int {
        return 0;
    }
    func checkHP() {
        if(health<1) {
            print("\(self.name) - откинулся")
            isAlive = false
        }
    }
}
class Putin: Unit {
    override func specialAbility() -> Int {
        print("Путин крадет здоровье")
        self.health += 15
        return 15;
    }
}
class Navalnii: Unit {
    override func specialAbility() -> Int {
        print("Обливается зеленкой, впадает в ярость и убивает Путина(если он есть в команде)")
        return 10
    }
}
class VaultBoy: Unit {
    override func specialAbility() -> Int {
        print("VaultBuy использует VATS")
        return 20
    }
    
}
class Ricardo: Unit {
    override func specialAbility() -> Int {
        print("Рикардо начинает флексить сотрясая землю под врагами")
        return 20
    }
}
class Soldier: Unit {
}
var putin = Putin(name: "VVP", health: 100, attack: [10,15], SPECIAL: [6,6,6,6,6,6,6], defense: 10)

var vaultBoy = VaultBoy(name: "VaultBoy", health: 120, attack: [12,16], SPECIAL: [5,4,3,6,7,2,4], defense: 8)

var navalnii = Navalnii(name: "Леха Навальный", health: 150, attack: [8,12], SPECIAL: [1,4,8,8,3,2,2], defense: 15)

var ricardo = Ricardo(name: "Рикардо", health: 200, attack: [14, 16], SPECIAL: [5,5,5,5,5,5,5], defense: 12)



var soldier = Soldier(name: "МВД США", health: 50, attack: [5,6], SPECIAL: [1,1,1,1,1,1,1], defense: 4)
class ZoneArea {
    var units: [Unit] = [soldier]
    var guardians: [Unit] = [soldier]
    func collectTeam() {
        self.units = [navalnii, ricardo]
    }
    
    func wave1() -> [Unit] {
        return [Soldier(name: "МВД США", health: 50, attack: [5,6], SPECIAL: [1,1,1,1,1,1,1], defense: 4), Soldier(name: "МВД США", health: 50, attack: [5,6], SPECIAL: [1,1,1,1,1,1,1], defense: 4)]
    }
    
    func wave2() -> [Unit] {
        return [Soldier(name: "Космонавт росгвардии", health: 20, attack: [5,6], SPECIAL: [1,1,1,1,1,1,1], defense: 0), Soldier(name: "Вася", health: 60, attack: [5,6], SPECIAL: [1,1,1,1,1,1,1], defense: 2)]
    }
    
    func wave3() -> [Unit] {
        if Int.random(in: 1...2)>1 {
            return [Soldier(name: "Космонавт росгвардии", health: 20, attack: [5,6], SPECIAL: [1,1,1,1,1,1,1], defense: 0), putin]
        }
        else {
            return [Soldier(name: "Космонавт росгвардии", health: 20, attack: [5,6], SPECIAL: [1,1,1,1,1,1,1], defense: 0), vaultBoy]
        }
    }
    func beginBattle(attackers: [Unit]) {
        var wave: Int = 1
        while wave < 4 {
            if(wave == 1) {
                print("Из казарм выбегает 1 волна защитников Зоны 51")
                guardians = wave1()
            }
            if(wave == 2) {
                print("Из казарм выбегает 2 волна защитников Зоны 51")
                guardians = wave2()
            }
            if(wave == 3) {
                print("Выходит Босс")
                guardians = wave3()
            }
            while (guardians[0].isAlive || guardians[1].isAlive) && (attackers[0].isAlive || attackers[1].isAlive) {
                if(attackers[0].isAlive) {
                    if(guardians[0].isAlive) {
                        guardians[0].health = attackers[0].atackEnemy(unit: guardians[0])
                        guardians[0].checkHP()
                        
                    }
                    else {
                        guardians[1].health = attackers[0].atackEnemy(unit: guardians[1])
                        guardians[1].checkHP()
                    }
                }
                if(attackers[1].isAlive) {
                    if(guardians[0].isAlive) {
                        guardians[0].health = attackers[1].atackEnemy(unit: guardians[0])
                        guardians[0].checkHP()
                    }
                    else {
                        guardians[1].health = attackers[1].atackEnemy(unit: guardians[1])
                        guardians[1].checkHP()
                    }
                }
                if(guardians[0].isAlive) {
                    if(attackers[0].isAlive) {
                        attackers[0].health = guardians[0].atackEnemy(unit: attackers[0])
                        attackers[0].checkHP()
                    }
                    else {
                        attackers[1].health = guardians[0].atackEnemy(unit: attackers[1])
                        attackers[1].checkHP()
                    }
                }
                if(guardians[1].isAlive) {
                    if(attackers[0].isAlive) {
                        attackers[0].health = guardians[1].atackEnemy(unit: attackers[0])
                        attackers[0].checkHP()
                    }
                    else {
                        attackers[1].health = guardians[1].atackEnemy(unit: attackers[1])
                        attackers[1].checkHP()
                    }
                }
                
            }
            wave += 1
        }
    }
}

var zone = ZoneArea()
zone.collectTeam()
zone.beginBattle(attackers: zone.units)


