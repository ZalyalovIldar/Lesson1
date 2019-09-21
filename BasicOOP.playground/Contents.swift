import UIKit

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

tree.add(element: 1)
tree.add(element: 2)
print(tree.contains(element: 2))
print(tree.contains(element: 3))


protocol SimpleProtocol {
    func doStuff()
}

struct SimpleStruct: SimpleProtocol {
    func doStuff() {
        print("doing stuff")
    }
}

class SimpleRootClass: SimpleProtocol {
    func doStuff() {
        print("doing stuff in a root way")
    }
}

class AnotherClass: SimpleRootClass {
    override func doStuff() {
        print("doing stuff in a different way")
    }
}

class ModifiersExampleClass {
    open var simplePublicComputedProperty: String {
        get {
            return "I'm visible from everywhere"
        }
    }
    
    private var simplePrivateComputedProperty: String {
        get {
            return "I'm visible only inside of this class"
        }
    }
}

