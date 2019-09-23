import UIKit

class Node {
    var value: Int
    var leftChild: Node?
    var rightChild: Node?
    
    init(value: Int) {
        self.value = value
    }
}

func buildNewTree(root: Node, indent: Int) {
    var isThereLeftChild = Bool.random()
    var isThereRightChild = Bool.random()
    
    if indent == 5 {
        isThereLeftChild = false
        isThereRightChild = false
    }
    else if indent <= 2 {
        isThereLeftChild = true
        isThereRightChild = true
    }
    
    var leftChildValue = -1
    var rightChildValue = -1
    
    if isThereLeftChild {
        leftChildValue = Int.random(in: 0 ... 10)
        root.leftChild = Node(value: leftChildValue)
        buildNewTree(root: root.leftChild!, indent: indent + 1)
    }
    if isThereRightChild {
        rightChildValue = Int.random(in: 0 ... 10)
        root.rightChild = Node(value: rightChildValue)
        buildNewTree(root: root.rightChild!, indent: indent + 1)
    }
}

func printTree(root: Node, indent: Int) {
    var output = ""
    for _ in 0..<indent {
        output += "  "
    }
    if root.leftChild != nil {
        print(output + String(root.leftChild!.value))
        printTree(root: root.leftChild!, indent: indent + 1)
    }
    if root.rightChild != nil {
        print(output + String(root.rightChild!.value))
        printTree(root: root.rightChild!, indent: indent + 1)
    }
}

let root = Node(value: 5)
buildNewTree(root: root, indent: 0)
print(root.value)
printTree(root: root, indent: 1)


