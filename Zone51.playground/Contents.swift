//MARK: - Units

class Unit {
    
    var health: Int
    let damage: Int
    var protection: Int
    let agility: Int
    let nickname: String
    
    init(health: Int, damage: Int, protection: Int, agility: Int, nickname: String) {
        
        self.agility = agility
        self.damage = damage
        self.health = health
        self.nickname = nickname
        self.protection = protection
        
        print("\(nickname) enters in the battle")
        
    }
    
    func attack(to enemy: inout Zona51Guard) -> ResultOfAttack {
        
        let attackerDamage = self.damage * self.agility
        let defenderDamage = enemy.damage * enemy.agility
        
        self.health -= defenderDamage - (defenderDamage * (1 / self.protection))
        enemy.health -= attackerDamage - (attackerDamage * (1 / enemy.protection))
        
        if self.health <= 0 && enemy.health <= 0 {
            return .bothDead
        }
        if enemy.health <= 0 {
            return .win
        }
        if self.health <= 0 {
            return .lost
        }
        
        return .bothAlive
    }
    
}

class Healer: Unit {
    func healTeam(team: inout [Unit]) {
        let healingValue = Int.random(in: 100...150)
        print("\(self.nickname) heals team for (\(healingValue))")
        for teammate in team {
            teammate.health += healingValue
        }
    }
}

class Ricardo: Unit {
    //His dance is so good -> enemy lost 5 protection
    func criticalDance(enemy: inout Zona51Guard) {
        print("Ricardo's critical dance decreases enemy protection")
        if enemy.protection < 5 {
            enemy.protection = 0
        } else {
            enemy.protection -= 5
        }
    }
}

class JoJo: Unit {
    //Is this JoJo reference?
}

class Jedi: Unit {
    func criticalAttack(enemy: inout Zona51Guard) -> Bool {
        //With 50% chance instantly attacks enemy through protection for 100 damage
        if Int.random(in: 1...2) == 1 {
            print("\(self.nickname) deals critical damage to \(enemy.nickname)")
            enemy.health -= 100
            return true
        } else {
            return false
        }
    }
}

class ChuckNorris: Unit {
    //With 10% chance destroys all enemy team
    func criticalAttack(enemys: inout [Zona51Guard]) -> Bool {
        if Int.random(in: 1...10) == 1 {
            print("\(self.nickname) uses extrapower and destroys all enemy team ")
            enemys.removeAll()
            return true
        } else {
            return false
        }
    }
}

class Zona51Guard: Unit {
}

//MARK: - Zona51

class ZonaArea {
    
    var isFinished = false
    
    func beginBattle(attackers: [Unit], defenders: [Zona51Guard], wave: Int) -> [Zona51Guard] {
        //Returns survived defenders
        
        var attackersInBattle = attackers
        var defendersInBattle = defenders
        
        //Wave buff for attackers
        for attacker in attackersInBattle {
            attacker.health += wave * 20
        }
        
        while !attackersInBattle.isEmpty && !defendersInBattle.isEmpty {
            
            let currentAttacker = attackersInBattle.randomElement()!
            var currentDefender = defendersInBattle.randomElement()!
            
            if let attacker = currentAttacker as? ChuckNorris {
                if attacker.criticalAttack(enemys: &defendersInBattle) { break }
            }
            
            if let attacker = currentAttacker as? Jedi {
                attacker.criticalAttack(enemy: &currentDefender)
            }
            
            if let attacker = currentAttacker as? Healer {
                attacker.healTeam(team: &attackersInBattle)
            }
            
            if let attacker = currentAttacker as? Ricardo {
                attacker.criticalDance(enemy: &currentDefender)
            }
            
            print("\(currentAttacker.nickname) attacks \(currentDefender.nickname)")
            
            let resultOfAttack = currentAttacker.attack(to: &currentDefender)
            
            switch resultOfAttack {
                
            case .win:
                defendersInBattle.remove(at: defendersInBattle.firstIndex(where: { (Unit) -> Bool in
                    Unit === currentDefender
                }) ?? 0)
                
                print("\(currentAttacker.nickname) wins")
                
            case .lost:
                attackersInBattle.remove(at: attackersInBattle.firstIndex(where: { (Unit) -> Bool in
                    Unit === currentAttacker
                }) ?? 0)
                
                print("\(currentDefender.nickname) wins")
                
            case .bothDead:
                defendersInBattle.remove(at: defendersInBattle.firstIndex(where: { (Unit) -> Bool in
                    Unit === currentDefender
                }) ?? 0)
                attackersInBattle.remove(at: attackersInBattle.firstIndex(where: { (Unit) -> Bool in
                    Unit === currentAttacker
                }) ?? 0)
                
                print("Both are dead")
                
            case .bothAlive:
                print("Both are survived")

            }
            print(" ")
            
        }

        return defendersInBattle

    }
    
}

enum ResultOfAttack {
    
    case win
    case lost
    case bothAlive
    case bothDead
    
}

//MARK: - Init Teams

let attacker1 = JoJo(health: 400, damage: 150, protection: 10, agility: 1, nickname: "JoJo")
let attacker2 = Jedi(health: 300, damage: 50, protection: 50, agility: 3, nickname: "Luke")
let attacker3 = ChuckNorris(health: 500, damage: 200, protection: 70, agility: 2, nickname: "Chuck Norris")
let attacker4 = Healer(health: 250, damage: 0, protection: 20, agility: 1, nickname: "Healer")
let attacker5 = Ricardo(health: 100, damage: 20, protection: 20, agility: 2, nickname: "Ricardo Milos")
var attackers = [attacker1, attacker2, attacker3, attacker4, attacker5]

var defenders: [Zona51Guard] = []
for i in 1...10 {
    defenders.append(Zona51Guard(health: 400, damage: 80, protection: 50, agility: 3, nickname: "Defender #\(i)"))
}

//MARK: - Start Zona51Battle

let zoneArea = ZonaArea()
let amountOfWaves = 7

for wave in 1 ... amountOfWaves {
    
    print("----------------------------------------")
    print("Wave #\(wave) is started")
    print("Survived defenders: \(defenders.count)")
    print("")
    
    defenders = zoneArea.beginBattle(attackers: attackers, defenders: defenders, wave: wave)
    
    if defenders.isEmpty {
        print("----------------------------------------")
        print("")
        print("Zone51 was successfully captured")
        break
    } else {
        print("Defenders survived")
    }
    
}
