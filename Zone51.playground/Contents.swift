enum ResultOfAttack {
    
    case win
    case lost
    case bothAlive
    case bothDead
    
}

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
    
    func attack(to enemy: inout Unit) -> ResultOfAttack {
        
        print("")
        print("\(self.nickname) attacks \(enemy.nickname)")
        
        self.health += self.protection
        print("Debug: \(self.nickname) had \(self.health) health")
        self.health -= (enemy.damage * enemy.agility)
        print("Debug: And now \(self.nickname) have \(self.health) health")
        
        enemy.health += enemy.protection
        print("Debug: \(enemy.nickname) had \(enemy.health) health")
        enemy.health -= (self.damage * self.agility)
        print("Debug: And now \(enemy.nickname) have \(enemy.health) health")
        
        if self.health <= 0 && enemy.health <= 0 {
            
            print("\(self.nickname) and \(enemy.nickname) killed eachother")
            //print("")
            
            return .bothDead
        }
        if enemy.health < 0 {
            
            print("\(self.nickname) eliminates \(enemy.nickname)")
            
            return .win
        }
        if self.health < 0 {
            
            print("\(enemy.nickname) eliminates \(self.nickname)")

            return .lost
        }
        
        return .bothAlive
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
            
            let resultOfAttack = currentAttacker.attack(to: &currentDefender)
            
            switch resultOfAttack {
                
            case .win:
                defendersInBattle.remove(at: defendersInBattle.firstIndex(where: { (Unit) -> Bool in
                    Unit === currentDefender
                }) ?? 0)
                
            case .lost:
                attackersInBattle.remove(at: attackersInBattle.firstIndex(where: { (Unit) -> Bool in
                    Unit === currentAttacker
                }) ?? 0)
                
            case .bothDead:
                defendersInBattle.remove(at: defendersInBattle.firstIndex(where: { (Unit) -> Bool in
                    Unit === currentDefender
                }) ?? 0)
                attackersInBattle.remove(at: attackersInBattle.firstIndex(where: { (Unit) -> Bool in
                    Unit === currentAttacker
                }) ?? 0)
                
            case .bothAlive:
                print("Both are survived")

            }
            
        }

        return defendersInBattle

    }
    
}

let attacker1 = Animeshnik(health: 600, damage: 150, protection: 1, agility: 1, nickname: "JoJo")
let attacker2 = Jedi(health: 300, damage: 50, protection: 50, agility: 3, nickname: "Luke")
let attacker3 = ChuckNorris(health: 500, damage: 200, protection: 70, agility: 2, nickname: "Chuck Norris")

var attackers = [attacker1, attacker2, attacker3]

let defendersNames = ["John", "Steven", "Mike", "Alfred"]
var defenders: [Unit] = []

for defenderName in defendersNames {
    defenders.append(Unit(health: 150, damage: 40, protection: 50, agility: 3, nickname: defenderName))
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

