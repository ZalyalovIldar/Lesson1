import UIKit

class Node{
    
    var value: Int
    var left: Node?
    var right: Node?
       
    init(value: Int) {
           self.value = value
    }
}

class BinaryTree {
    
    var root: Node

    init(root: Int) {
        self.root = Node(value: root)
    }
    
    func insert(newValue: Int){
        return insertToBT(value: newValue, root: root)
    }

    func insertToBT(value: Int, root: Node) {
        
        let currentValue = root.value
        if currentValue != value {
            if (value < currentValue) {
                if let left = root.left {
                    insertToBT(value: value, root: left);
                }
                else {
                    root.left = Node(value: value);
                }
            }
            if value > currentValue {
                if let right = root.right {
                    insertToBT(value: value, root: right)
                }
                else {
                    root.right = Node(value: value)
                }
            }
        }
        else {
            root.value = value;
        }
    }
    
    func search(value: Int) -> Bool {
        return searchToBT(start: root, value: value)
    }
    
    func searchToBT(start: Node?, value: Int) -> Bool {
        
        if let start = start {
            if start.value == value {
                return true
            }
            else {
                return searchToBT(start: start.left, value: value) || searchToBT(start: start.right, value: value)
            }
        }
        return false
    }
}

let array = [10, 20, 5, 21, 8, 4]
var tree = BinaryTree(root: 7)

for element in array {
    tree.insert(newValue: element)
}

print(tree.search(value: 21))

