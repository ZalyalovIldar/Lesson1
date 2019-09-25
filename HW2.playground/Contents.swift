import UIKit

class Person{
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
         
class CompanyMember : Person{
    var company: String
    init(name: String, age: Int, company: String) {
        self.company = company
        super.init(name:name, age: age)
    }
    override func display(){
        print("Имя: \(name)  Возраст: \(age)  Сотрудник компании: \(company)")
    }
}
         
class CompanyManager : CompanyMember{
    override func display(){
        print("Имя: \(name)  Возраст: \(age)  Менеджер компании: \(company)")
    }
}

let fedor: Person = Person(name:"Fedor", age: 18)
let alex: Person = CompanyMember(name: "Alex", age: 21, company: "Apple")
let vika: Person = CompanyManager(name: "Vika", age: 23, company: "Microsoft")

fedor.display()
alex.display()
vika.display()
