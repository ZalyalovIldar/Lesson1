
class Unit {
    
    var health: Int
    let damage: Int
    let protection: Int
    let agility: Int
    let nickname: String
    
    init(health: Int, damage: Int, protection: Int, agility: Int, nickname: String) {
        self.agility = agility
        self.damage = damage
        self.health = health
        self.nickname = nickname
        self.protection = protection
    }
    
    func attack(to enemy: inout Unit) -> Bool? {
        //True -> Succsess attack
        //nil -> Both are dead
        
        print("\(self.nickname) attacks \(enemy.nickname)")
        print("\(self.nickname) health is: \(self.health)")
        print("\(enemy.nickname) health is: \(enemy.health)")
        
        self.health += self.protection
        self.health -= (enemy.damage * enemy.agility)
        
        enemy.health += enemy.protection
        print("Debug: Enemy had \(enemy.health) health")
        enemy.health -= (self.damage * self.agility)
        print("Debug: ANd now \(enemy.health) health")
        
        if self.health <= 0 && enemy.health <= 0 {
            
            print("\(self.nickname) and \(enemy.nickname) killed eachother")
            print("")
            
            return nil
        }
        if enemy.health < 0 {
            
            print("\(self.nickname) eliminates \(enemy.nickname)")
            print("")
            
            return true
        }
        if self.health < 0 {
            
            print("\(enemy.nickname) eliminates \(self.nickname)")
            print("")
            
            return false
        }
        
        return nil
    }
    
}

class Animeshnik: Unit {
    
}

class Jedi: Unit {
    
}

class ChuckNorris: Unit {
    
}

class Zona51Guard: Unit {
    
}

class ZonaArea {
    
    var isFinished = false
    
    
    func beginBattle(attackers: [Unit], defenders: [Unit], wave: Int) -> [Unit] {
        
        var attackersInBattle = attackers
        var defendersInBattle = defenders
        
        //Wave buff for attackers
        for attacker in attackersInBattle {
            attacker.health += wave * 20
        }
        
        while !attackersInBattle.isEmpty || !defendersInBattle.isEmpty {
            
            let currentAttacker = attackersInBattle.randomElement()!
            var currentDefender = defendersInBattle.randomElement()!
            
            guard let resultOfAttack = currentAttacker.attack(to: &currentDefender) else {
                defendersInBattle.remove(at: defendersInBattle.firstIndex(where: { (Unit) -> Bool in
                    Unit === currentDefender
                }) ?? 0)
                attackersInBattle.remove(at: attackersInBattle.firstIndex(where: { (Unit) -> Bool in
                    Unit === currentAttacker
                }) ?? 0)
                continue
            }
            
            if resultOfAttack {
                defendersInBattle.remove(at: defendersInBattle.firstIndex(where: { (Unit) -> Bool in
                    Unit === currentDefender
                }) ?? 0)
            } else {
                attackersInBattle.remove(at: attackersInBattle.firstIndex(where: { (Unit) -> Bool in
                    Unit === currentAttacker
                }) ?? 0)
            }
            
        }

        return defendersInBattle

    }
    
}

let attacker1 = Animeshnik(health: 600, damage: 150, protection: 1, agility: 1, nickname: "JoJo")
let attacker2 = Jedi(health: 300, damage: 50, protection: 50, agility: 3, nickname: "Luke")
let attacker3 = ChuckNorris(health: 500, damage: 100, protection: 70, agility: 2, nickname: "Chuck Norris")
let attacker4 = Animeshnik(health: 100, damage: 80, protection: 1, agility: 1, nickname: "Dio")
let attacker5 = Animeshnik(health: 100, damage: 30, protection: 1, agility: 2, nickname: "SpeedWagon")
let attacker6 = Jedi(health: 300, damage: 50, protection: 50, agility: 2, nickname: "Yoda")
var attackers = [attacker1, attacker2, attacker3, attacker4, attacker5, attacker6]

let defendersNames = ["John", "Steven", "Mike", "Alfred"]
var defenders: [Unit] = []

for defenderName in defendersNames {
    defenders.append(Unit(health: 250, damage: 40, protection: 50, agility: 3, nickname: defenderName))
}

let zoneArea = ZonaArea()
let amountOfWaves = 4
var survivedDefenders: [Unit] = defenders

var survivedDefendersNames: [String] {
    var survivedDefendersNames: [String] = []
    for survivedDefender in survivedDefenders {
        survivedDefendersNames.append(survivedDefender.nickname)
    }
    return survivedDefendersNames
}

for wave in 1 ... amountOfWaves {
    
    print("Survived defenders: \(survivedDefendersNames)")
    
    print("Wave #\(wave) is started")
    print("------------------------")
    
    survivedDefenders = zoneArea.beginBattle(attackers: attackers, defenders: defenders, wave: wave)
    
    if survivedDefenders.isEmpty {
        print("Zone51 was successfully captured")
        break
    } else {
        print("Defenders survived")
    }
    
}

