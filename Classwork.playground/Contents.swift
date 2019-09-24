import UIKit

public class Dancer {
    
    private var name: String
    private var age: Int
    
    init (name: String, age: Int){
        self.name = name
        self.age = age
    }
    
    func dance(){
        print("I'm dancing")
    }
    
    func dance(tired: Bool){
        
        if tired {
            print("I don't wanna dance")
        } else {
            print("I'm dancing")
        }
    }
}

class DancerTango : Dancer {
    
    override func dance(){
        print("I'm dancing tango")
    }
}

class Node {
    
    let value: Int
    var left: Node?
    var right: Node?
    
    init(value: Int) {
        
        self.value = value
        left = nil
        right = nil
    }
}

class BinaryTree {
    
    var root: Node?
    
    init(value: Int) {
        root = Node(value: value)
    }
    
    init() {
        root = nil
    }
    
    func add(element: Int) {
        
        if root == nil {
            root = Node(value: element)
        }
        else {
            var iterator = root
            while true {
                if element > iterator!.value {
                    if iterator!.right == nil {
                        iterator!.right = Node(value: element)
                        return
                    }
                    else {
                        iterator = iterator!.right
                    }
                }
                else {
                    if iterator!.left == nil {
                        iterator!.left = Node(value: element)
                        return
                    }
                    else {
                        iterator = iterator!.left
                    }
                }
            }
        }
    }
    
    func contains(element: Int) -> Bool {
        
        if root == nil {
            return false
        }
        else {
            var iterator = root
            while iterator != nil {
                if element > iterator!.value {
                    iterator = iterator!.right
                }
                else if element < iterator!.value {
                    iterator = iterator!.left
                }
                else {
                    return true
                }
            }
            return false
        }
    }
}

var tree = BinaryTree()
tree.add(element: 0)
tree.add(element: 1)
print(String(tree.contains(element: 1)))
print(String(tree.contains(element: 2)))
