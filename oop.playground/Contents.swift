import UIKit
public class Person{
    internal var name: String
    internal let gender: Bool
    internal var age: Int
    init(name: String, age: Int, gender: Bool) {
        self.name = name
        self.age = age
        self.gender = gender
    }
    open func speak(){
        print("Меня зовут: ", name)
    }
    func speak(person: Person){
        print("Здравствуй, ", person.name)
    }
}
public class Student: Person{
    override init(name:String, age: Int, gender: Bool) {
        super.init(name: name, age: age, gender: gender)
    }
    override public func speak() {
        print(name, " хочет кушать")
    }
}
