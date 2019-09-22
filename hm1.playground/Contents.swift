import UIKit
class Car {
    private var colour: String
    private var tinted: Bool
    private var motor: String
    init(colour: String, tinted: Bool, motor: String) {
        self.colour = colour
        self.tinted = tinted
        self.motor = motor
    }
    func drive() {
        print("Машина поехала")
    }
    func changeMotor(newMotor: String) {
        self.motor = newMotor
    }
}
class Priora: Car {
    override func drive() {
        print("Дал дал ушёл")
        print("*Капиталочка*")
    }
}
var priora = Priora(colour: "black", tinted: true, motor: "ВАЗ 21126 1.6л")
priora.drive()
class TreeNode {
    var leftChildren: TreeNode?
    var rightChildren: TreeNode?
    var value: Int
    init(value: Int) {
        self.value = value
    }
}

class Tree {
    var root: TreeNode
    
    init(value: Int) {
        self.root = TreeNode(value: value)
    }
    
    func add(value: Int) {
        return add(root: root, value: value)
    }
    
    private func add(root: TreeNode, value: Int) {
        if(root == nil) {
            root.value = value
        }
        else {
            if(root.value>value) {
                if let left = root.leftChildren {
                    add(root: left, value: value)
                }
                else {
                    root.leftChildren = TreeNode(value: value)
                }
            }
            else {
                if let right = root.rightChildren {
                    add(root: right, value: value)
                }
                else {
                    root.rightChildren = TreeNode(value: value)
                }
            }
        }
    }
}
var tree = Tree(value: 4)
tree.add(value: 6)
tree.root.rightChildren?.value
