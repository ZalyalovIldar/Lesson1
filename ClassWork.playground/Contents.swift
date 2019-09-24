import UIKit

class Animal {
    var voice: String
    var age: Int
    
    init(voice: String, age: Int){
        self.voice = voice
        self.age = age
    }

    func giveVoice() {
        print(voice)
    }
}

class Dog : Animal {
    var name: String
    init(name:String, voice: String, age: Int){
        self.name = name
        super.init(voice: voice, age: age)
    }
    override func giveVoice() {
        print(name + " издал звук: " + voice)
    }

}

let DogAzat = Dog(name: "Azat", voice: "privet pasha", age: 19)
DogAzat.giveVoice()


class Man {
    private var name: String
    
    init(name: String) {
        self.name = name
    }
    
    func changeName(name: String) {
        self.name = name
    }
    func printName() {
        print(self.name)
    }
}

let ManAzat = Man(name: "Azat")
ManAzat.changeName(name: "Pasha")
ManAzat.printName()



class Node{
    var root: Node?
    var rightChild: Node?
    var leftChild: Node?
    var number: Int
    init(number: Int) {
        self.number = number
    }
    
    func addN(newNode: Node) {
        if(root != nil) {
            if(newNode.number < root!.number) {
                if(leftChild != nil) {
                    leftChild!.addN(newNode: newNode)
                }
                else{
                    leftChild = newNode
                }
            }
            else {
                if(rightChild != nil) {
                    rightChild!.addN(newNode: newNode)
                }
                else{
                    rightChild = newNode
                }
            }
        }
    }
}