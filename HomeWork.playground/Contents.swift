
//MARK: - ООП

//Наследование
class Car: Transport {
    
    var model = String()
    
}

class Transport {
    
    var speed = Int()
    var amountOfWheels = Int()
    
}

let tesla = Car()
tesla.model = "Tesla"
tesla.amountOfWheels = 4
tesla.speed = 100

//Инкапсуляция
class TimeInterval {
    
    private let Minutes: Double
    
    init(minutes: Double) {
        self.Minutes = minutes
    }
    
    var seconds: Double {
        return Minutes * 60.0
    }
    
    var hours: Double {
        return Minutes / 60.0
    }
    
    var minutes: Double {
        return self.Minutes
    }
    
}

let timeInterval = TimeInterval(minutes: 60)
let minutes = timeInterval.minutes
let seconds = timeInterval.seconds
let hours = timeInterval.hours

//Полиморфизм
class Person {
    var name: String
    var age: Int
    
    init(name: String, age: Int){
        self.name = name
        self.age = age
    }
    func display(){
        print("Имя: \(name)  Возраст: \(age)")
    }
}

class Employee: Person {
    var company: String
    init(name: String, age: Int, company: String) {
        self.company = company
        super.init(name:name, age: age)
    }
    override func display(){
        print("Имя: \(name)  Возраст: \(age)  Сотрудник компании: \(company)")
    }
}

class Manager : Employee{
    override func display(){
        print("Имя: \(name)  Возраст: \(age)  Менеджер компании: \(company)")
    }
}

let tom: Person = Person(name:"Misha", age: 23)
let bob: Person = Employee(name: "Masha", age: 28, company: "Starbucks")
let alice: Person = Manager(name: "Sasha", age: 31, company: "Apple")

tom.display()
bob.display()
alice.display()

//MARK: - Tree
class Node {
    
    var value: String
    var children: [Node] = []
    var parent: Node?
    
    init(value: String) {
        self.value = value
    }
    
    func add(node: Node) {
        
        self.children.append(node)
        node.parent = node
        
    }
    
    func search(nodeValue: String) -> Node? {
        
        if self.value == nodeValue { return self }
        
        for child in children {
            if let found = child.search(nodeValue: value) {
                return found
            }
        }
        return nil
    }
    
}


