import UIKit

//OOP example
class Programmer {
    
    public let programmingLanguage: String
    public let salary: Int
    
    private let idOfProgrammer: Int
    
    init(programmingLanguage: String, salary: Int, idOfProgrammer: Int) {
        self.programmingLanguage = programmingLanguage
        self.salary = salary
        self.idOfProgrammer = idOfProgrammer
    }
    
    public func scream() { }
}

class RubyDeveloper: Programmer {
    
    override func scream() {
        print("Ruby is the best!")
    }
}

class CPlusPlusDeveloper: Programmer {
    
    override func scream() {
        print("C++ is the speed!")
    }
}

let rubyDeveloper = RubyDeveloper(programmingLanguage: "Ruby", salary: 135000, idOfProgrammer: 1)
let cPlusPlusDeveloper = CPlusPlusDeveloper(programmingLanguage: "C++", salary: 95000, idOfProgrammer: 2)

rubyDeveloper.scream()
cPlusPlusDeveloper.programmingLanguage


//Binary Tree
class Node {
    
    var value: Int
    var left: Node?
    var right: Node?
    init(value: Int) {
        self.value = value
    }
}

class BinaryTree {
    
    var root: Node
    
    init(rootValue: Int) {
        self.root = Node(value: rootValue)
    }
    
    func search(_ value: Int) -> Bool {
        return preorderSearch(root, value: value)
    }
    
    func printTree() -> String {
        let result = preorderPrint(root, traverse: "")!
        return String(result[..<result.index(before: result.endIndex)])
    }
    
    func preorderSearch(_ start: Node?, value: Int) -> Bool {
        if let start = start {
            if start.value == value {
                return true
            } else {
                return preorderSearch(start.left, value: value) || preorderSearch(start.right, value: value)
            }
        }
        return false
    }
    
    func preorderPrint(_ start: Node?, traverse: String) -> String? {
        var result = traverse
        if let start = start {
            result += "\(start.value)-"
            if let newValue = preorderPrint(start.left, traverse: result) {
                result = newValue
            }
            if let newValue = preorderPrint(start.right, traverse: result) {
                result = newValue
            }
        }
        return result
    }
}

let tree = BinaryTree(rootValue: 1)
tree.root.left = Node(value: 2)
tree.root.right = Node(value: 3)
tree.root.left?.left = Node(value: 4)
tree.root.left?.right = Node(value: 5)

print(tree.search(4))
print(tree.search(6))
print(tree.printTree())
