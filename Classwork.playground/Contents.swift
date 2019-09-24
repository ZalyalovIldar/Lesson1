import UIKit

public class Player {
    var name: String
    var age: Int
    var number: Int
    
    init (name: String, age: Int,number: Int){
        self.name = name
        self.age = age
        self.number = number
    }
    
    func play(){
        print("I like sport!")
    }
    
    func play(player: Player){
        print(name, " give the ball to ", player.name)
    }
}

class FootballPlayer: Player{
    override init(name: String, age: Int,number: Int){
        super.init(name: name, age: age, number: number)
    }
    override func play() {
        print("I'm playing football")
    }
}




class Node {
    
    
    var left: Node?
    var right: Node?
    let value: Int
    
    
    init(value: Int) {
        
        left = nil
        right = nil
        self.value = value
      
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
                }else {
                    return true
                }
            }
            return false
        }
    }
}

var tree = BinaryTree()
tree.add(element: 10)
tree.add(element: 9)
print(String(tree.contains(element: 5)))
print(String(tree.contains(element: 10)))
