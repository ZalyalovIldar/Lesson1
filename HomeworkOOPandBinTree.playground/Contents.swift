import UIKit

var str = "Hello, playground"

class Animal {
    
    public var color: String
    public var numberOfPaws: Int
    
    private let idOfAnimal: Int
    
    init(color: String, numberOfPaws: Int, idOfAnimal: Int) {
        self.color = color
        self.numberOfPaws = numberOfPaws
        self.idOfAnimal = idOfAnimal
    }
    
    public func voice() {
        print(" I am Animal")
    }
    
}

class Dog: Animal {
    
    public override func voice() {
        print("Gav gav")
    }
    
}

class Cat: Animal {
    
    public override func voice() {
        print("Miau miau")
    }
    
}

var dog: Animal = Dog(color: "brown", numberOfPaws: 4, idOfAnimal: 1)

var cat: Animal = Cat(color: "black", numberOfPaws: 4, idOfAnimal: 2)


dog.voice()
cat.voice()


class Node {
    
    var value: Int
    var left: Node
    var right: Node
    var parent: Node
    
    init(value: Int, left: Node, right: Node, parent: Node) {
        self.value = value
        self.left = left
        self.right = right
        self.parent = parent
    }
    
}

class Tree {
    
    private var value: Int
    private var left: Tree?
    private var right: Tree?
    private var parent: Tree?
    
    init(value: Int, parent: Tree?) {
        self.value = value
        self.parent = parent
        self.left = nil
        self.right = nil
    }
    
    func add(value: Int) {
        if value < self.value {
            if self.left != nil {
                self.left!.add(value: value)
            }
            else {
                self.left = Tree(value: value, parent: self)
            }
        }
        else {
            if self.right != nil {
                self.right!.add(value: value)
            }
            else {
                self.right = Tree(value: value, parent: self)
            }
        }

    }
    
    func contains(value: Int) -> Bool {
        return contains(value: value, tree: self)
    }
    
    func contains(value: Int, tree: Tree?) -> Bool {
        if tree == nil {
            return false
        }
        else {
            if value > tree!.value {
                return contains(value: value, tree: tree?.right)
            }
            else if value < tree!.value {
                return contains(value: value, tree: tree?.left)
            }
            else if value == tree!.value {
                return true
            }
        }
        return false
    }
    
}


var tree: Tree = Tree(value: 1, parent: nil)

tree.add(value: 2)
tree.add(value: 5)

print(tree.contains(value: 2))
print(tree.contains(value: 5))
print(tree.contains(value: 3))
print(tree.contains(value: 1))
print(tree.contains(value: 6))


