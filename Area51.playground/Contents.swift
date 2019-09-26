import UIKit

class Unit {
    let nickname: String
    var healthPoint: Int
    let damage: Int
    let armor: Int
    let agility: Int
    var isAlive: Bool = true
    
    init(nickname: String, healthPoint: Int, damage:Int, armor: Int, agility: Int) {
        self.nickname = nickname
        self.healthPoint = healthPoint
        self.damage = damage
        self.armor = armor
        self.agility = agility
    }
    func attack(enemy: Unit) {
        enemy.healthPoint -= damage
        
    }
    
}

class Naruto: Unit {
    override func attack(enemy: Unit) {
        enemy.healthPoint -= damage
        print (nickname + ": Йоу, собаки, я - Наруто Узумаки! Даттебаё!!!")
    }
}


class Jiraiya: Unit {
    override func attack(enemy: Unit) {
        enemy.healthPoint -= damage
        print (nickname + ": А я — Джирайя, всегда отдыхаю. Супер-Саннин, лягушек уважаю")
    }
}

class Sasuke: Unit {
    override func attack(enemy: Unit) {
        enemy.healthPoint -= damage
        print (nickname + ": Йоу, всё классно, меня зовут Саске. Ненавижу Итачи — брата из «Акацуки»")
    }
}

class Pikachu: Unit {
    override func attack(enemy: Unit) {
        enemy.healthPoint -= damage
        print (nickname + ": Pika Pika")
    }
}
class Defender51: Unit {
    override func attack(enemy: Unit) {
        enemy.healthPoint -= damage
        print (nickname + ": Слава Америке!")
    }
}
class ZoneArea {
    var attackersWaves = [[Unit]]()
    var defenders = [Unit]()
    
    func areAlive(units:[Unit]) -> Bool {
        var liveCheck: Bool = false
        for counter in units {
            if counter.isAlive == true {
                liveCheck = true
            }
        }
        return liveCheck
        
    }
    
    func initialize () {
        for _ in (0...10) {
            defenders.append(Defender51(nickname: "Defender", healthPoint: 10, damage: 3, armor: 5, agility: 3))
        }
        
        attackersWaves.append([Naruto(nickname:"Naruto", healthPoint:10, damage:5, armor:5, agility:4), Pikachu(nickname:"Pikachu", healthPoint:10, damage:4, armor:4, agility:4)])
        
        attackersWaves.append([Naruto(nickname:"Naruto", healthPoint:10, damage:5, armor:5, agility:4), Pikachu(nickname:"Pikachu", healthPoint:10, damage:4, armor:4, agility:4), Sasuke(nickname:"Sasuke", healthPoint:10, damage:5, armor:4, agility:5) ])
        attackersWaves.append([Naruto(nickname:"Naruto", healthPoint:10, damage:5, armor:5, agility:4), Pikachu(nickname:"Pikachu", healthPoint:10, damage:4, armor:4, agility:4), Sasuke(nickname:"Sasuke", healthPoint:10, damage:5, armor:4, agility:5), Jiraiya(nickname:"Jiraiya", healthPoint:10, damage:6, armor:6, agility:6)])
        
    }
    func beginWar () {
        initialize()
        var waveNum: Int = beginBattle()
        if(waveNum-1 == attackersWaves.count) {
            print("Защитники победили.")
        }
        else {
            print("Атакующие победили на ", waveNum, "волне.")
        }
        
        
        
        
    }
    func beginBattle () -> Int {
        var waveNum: Int = 1
        for attackWave in attackersWaves {
            for attacker in attackWave {
                for defender in defenders {
                    if (defender.isAlive && attacker.isAlive) {
                        defender.attack(enemy: attacker)
                        attacker.attack(enemy: defender)
                    }
                    if (defender.healthPoint <= 0) {
                        defender.isAlive = false
                    }
                    if (attacker.healthPoint <= 0) {
                        attacker.isAlive = false
                    }
                    if !defender.isAlive {
                        continue // защитник умер, то нужен следующий защитник, отправляется в следующую итерацию defenders
                    }
                    if !attacker.isAlive {
                        break // атакующий умер, то нужен новый атакующий, отправляется в следующую итерацию attackers
                    }
                }
                if !areAlive(units: defenders) {
                    return waveNum
                }
            }
            waveNum += 1
        }
        return waveNum
    }
}

var game = ZoneArea()
game.beginWar()
