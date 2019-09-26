import UIKit

class AbstractPhone {     //абстракция
    let year: Int
    
    init (year: Int) {
        self.year = year
    }
    
    func call(outputNumber: Int) {
        print("Позвонить по номеру " + "\(outputNumber)")
    }
    
    public func ring(inputNumber: Int) {
        print("Дзынь-дзынь")
    }
}

class SomePhone {     //инкапсуляция
    private let macAddress: Int
    private let company: String
    
    init(macAddress: Int, company: String) {
        self.macAddress = macAddress
        self.company = company
    }
    
    private func openConnection() {
        //findComutator
        //openNewConnection
    }
    public func call() {
        openConnection()
        print("Вызываю номер")
    }

    public func ring() {
        print("Дзынь-дзынь")
    }
}

class WirelessPhone: AbstractPhone {     //наследование
    private var hour: Int
    
    init(year: Int, hour: Int) {
        self.hour = hour
        super.init(year: year)
    }
    
    override func ring(inputNumber: Int) {
        print("Вам звонит абонент " + "\(inputNumber)")
    }
}

class Phone: AbstractPhone {
    override init(year: Int) {
        super.init(year: year)
    }
    
    override func call(outputNumber: Int) {
        print("Вызываю номер" + "\(outputNumber)")
    }
    
    override func ring(inputNumber: Int) {
        print("Телефон звонит")
    }
}

class VideoPhone: AbstractPhone {
    override init(year: Int) {
        super.init(year: year)
    }
    override func call(outputNumber: Int) {
        print("Подключаю видеоканал для абонента " + "\(outputNumber)")
    }
    
    override func ring(inputNumber: Int) {
        print("У вас входящий видеовызов..." + "\(inputNumber)")
    }
    
}

class User {
    let name: String
    init(name: String) {
        self.name = name
    }
    func callAnotherUser(number: Int, phone: AbstractPhone) {
        //полиморфизм
        phone.call(outputNumber: number)
    }
}
