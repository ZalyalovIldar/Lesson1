import UIKit

class Car{
    fileprivate var colour : String?
    private var plateNumber : Int?
    
    public func sound(){
        print("Vroom")
    }
    
    init(plateNumber : Int) {
        self.plateNumber = plateNumber
    }
    
    public func paintCar(colour : String){
        self.colour = colour
        print("New colour is " + colour)
    }
}
class SportCar : Car{
    override func sound() {
        print("Rooooom")
    }
}

class Truck : Car{
    override func sound() {
        print("Rrrrrrom")
    }
}

// ~~~~~~~~~~~~~~~~~~~~~~~~~ BST ~~~~~~~~~~~~~~~~~~~~~~~~~

class TreeNode {
    
    var element: Int
    var leftNode: TreeNode?
    var rightNode: TreeNode?
    
    init(element: Int, leftNode: TreeNode? = nil, rightNode: TreeNode? = nil) {
        self.element = element
        self.leftNode = leftNode
        self.rightNode = rightNode
    }
}

class BinarySearchTree {
    
    private var rootNode: TreeNode?
    
    func insert(element: Int) {
        let node = TreeNode(element: element)
        if let rootNode = self.rootNode {
            insert(rootNode: rootNode, node: node)
        } else {
            self.rootNode = node
        }
    }
    
    private func insert(rootNode: TreeNode, node: TreeNode) {
        if rootNode.element > node.element {
            if let leftNode = rootNode.leftNode {
                insert(rootNode: leftNode, node: node)
            } else {
                rootNode.leftNode = node
            }
        } else {
            if let rightNode = rootNode.rightNode {
                insert(rootNode: rightNode, node: node)
            } else {
                rootNode.rightNode = node
            }
        }
    }
    
    func search(element: Int) {
        search(rootNode: self.rootNode, element: element)
    }
    
    private func search(rootNode: TreeNode?, element: Int) {
        
        guard let rootNode = rootNode else {
            print("Can't find \(element)")
            return
        }
        
        if element > rootNode.element {
            search(rootNode: rootNode.rightNode, element: element)
        } else if element < rootNode.element {
            search(rootNode: rootNode.leftNode, element: element)
        } else {
            print("Successfully found \(rootNode.element)")
        }
    }
}








