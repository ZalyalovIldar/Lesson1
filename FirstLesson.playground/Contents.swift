import UIKit

var str = "Hello, playground"
let someInt = 10

print(str + " \(someInt)")

let array = [1,2,3,4,5]

var newArray = [Int]()
var newArray2: [Int] = []
var newArray3: Array<Int> = []
var newArray4 = Array<Int>()

newArray.append(contentsOf: array)

for value in newArray.enumerated() {
    newArray2.insert(value.element, at: value.offset)
}

for var value in (0 ..< 5).reversed() {
    
    value += 1
    print(value)
}

var dictionary = ["key":12, "key2":13]

dictionary["key2"] = 14

dictionary

if someInt > 10 {
    
}

var optionalValue: Int?
var forceUnwrapValue: Int!

optionalValue = 5

if var unwrapedOptionalValue = optionalValue {
    unwrapedOptionalValue += 5
    newArray2.append(unwrapedOptionalValue)
}

class SomeClassRoot: SomeProtocol {
    var someValue: Int = 10
    
    func sayHello() {
        print("Hello world!")
    }
}

protocol SomeProtocol {
    var someValue: Int { get set }
    
    func sayHello()
}

class SomeClass: SomeClassRoot {
    
    fileprivate var name: String = String()
    var age: Int
    
    init(age: Int) {
        self.age = age
    }
    
    override func sayHello() {
        print("Hello world!")
    }
    
    func calculateSum(with z: Double, and f: Double) -> Double {
        return z + f
    }
}

let someClassValue = SomeClass(age: 18)

someClassValue.name = "Mark"

someClassValue.sayHello()

someClassValue.calculateSum(with: 32, and: 31)

struct SomeStruct {
    var field1: String = ""
    var field2: String = ""
    var field3: String
    
    init(value: String) {
        field3 = value
    }
}

var myStruct = SomeStruct(value: "32")

let array3 = ["",1,2,3,4,5, "asd"] as [Any]

let firstValue = array3.first as! Int

if let firstValue = array3.first as? Int {
    print()
}
