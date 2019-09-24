import UIKit


class Human {
    private var sex: String
    
    init(sex: String) {
        self.sex = sex
    }
    func saySomething() -> String {
        return("\(sex)")
    }
}

class Student: Human {
    private var firstName: String
    private var lastName: String
    private var age: Int
    
    init(firstName: String, lastName: String, age: Int, sex: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
        super.init(sex: sex)
    }
    
    override func saySomething() -> String {
        let sex = super.saySomething()
        return("Hello! My name is \(firstName) \(lastName). I am \(age). I am \(sex)")
    }
}

let student1 = Student(firstName: "Katya", lastName: "Ivanova", age: 18, sex: "female")
print(student1.saySomething())
let student2 = Student(firstName: "Masha", lastName: "Ivanova", age: 18, sex: "female")
print(student2.saySomething())

// Binary Tree

class Node {
    let data: Int
    var leftChild: Node?
    var rightChild: Node?
    
    init(value: Int) {
        data = value
    }
    
    func insert(value: Int){
        if value <= data{
            if leftChild == nil {
                leftChild = Node(value: value)
            }
            else {
                leftChild?.insert(value: value)
            }
        }
        else{
            if rightChild == nil {
                rightChild = Node(value: value)
            }
            else {
                rightChild?.insert(value: value)
            }
        }
    }
    
    func contains(value: Int) -> Bool{
        if value == data {
            return true
        }
        else if value < data{
            if leftChild == nil{
                return false
            }
            else{
                return (leftChild?.contains(value: value))!
            }
        }
        else{
            if rightChild == nil{
                return false
            }
            else{
                return (rightChild?.contains(value: value))!
            }
        }
    }
}

var node = Node(value: 5)
node.insert(value: 6)
node.insert(value: 3)
node.insert(value: 7)
node.contains(value: 6)
node.contains(value: 8)
