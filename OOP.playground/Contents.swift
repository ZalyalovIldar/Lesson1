import UIKit

class Vehicle {
    
    public var horsePower: Int
    fileprivate var color: String
    var name: String
    var hasEngine: Bool
    
    init(horsePower: Int, color: String, name: String, hasEngine: Bool) {
        self.horsePower = horsePower
        self.color = color
        self.name = name
        self.hasEngine = hasEngine
    }
    
    func engineSound() {
        print("Engine sound")
    }
}

class Car: Vehicle {
    override func engineSound() {
        print("Vrum-vrum, I'm \(name) mafaka")
    }
}

class SportCar: Car {
    var maxSpeed: Int
    init(maxSpeed: Int, horsePower: Int, color: String, name: String, hasEngine: Bool) {
        self.maxSpeed = maxSpeed
        super.init(horsePower: horsePower, color: color, name: name, hasEngine: hasEngine)
    }
    override func engineSound() {
        print("I'm \(name) an I have \(maxSpeed) km/h max speed")
    }
}

class Bycycle: Vehicle {
    override func engineSound() {
        print("No engine")
    }
}


var lada = Car(horsePower: 87, color: "Black", name: "lada", hasEngine: true)
lada.engineSound()
var ferrari = SportCar(maxSpeed: 300, horsePower: 600, color: "red", name: "Ferrari", hasEngine: true)
ferrari.engineSound()
var stels = Bycycle(horsePower: 0, color: "Gray", name: "Stels", hasEngine: false)
stels.engineSound()


// Binary Tree

class Node {
    
    var left: Node?
    var right: Node?
    var value: Int
    
    init(_ value: Int) {
        self.left = nil
        self.right = nil
        self.value = value
    }
}

class BinaryTree {
    var root : Node?
    
    init() {
        root = nil
    }
    
    func insert(_ newNode: Node!) {
        guard root != nil else { root = newNode; return }
        self.insert(root!, newNode)
    }
    
   private func insert(_ currentRoot: Node, _ newNode: Node){
        if (newNode.value == currentRoot.value) {
            return
        }
        if (newNode.value > currentRoot.value) {
            if let right = currentRoot.right {
                insert(right, newNode)
            }
            else {
                currentRoot.right = newNode
            }
        }
        else {
            if let left = currentRoot.left {
                insert(left, newNode)
            }
            else {
                currentRoot.left = newNode
            }
        }
        
    }
}


var tree = BinaryTree()
tree.insert(Node(12))
tree.insert(Node(3))
tree.insert(Node(10))
tree.insert(Node(7))

print("\(String(describing: tree.root?.left?.value))")
