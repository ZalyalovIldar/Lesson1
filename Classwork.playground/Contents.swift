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


enum BinaryTree<T> {
    case empty
    indirect case node(BinaryTree, T, BinaryTree)
}

let timesLeft = BinaryTree.node(.empty, "2", .empty)
let timesRight = BinaryTree.node(.empty, "3", .empty)
let tree = BinaryTree.node(timesLeft, "1", timesRight)

