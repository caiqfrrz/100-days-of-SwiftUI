import Cocoa

class Animal {
    let numLegs: Int
    
    init(numLegs: Int) {
        self.numLegs = numLegs
    }
}

class Dog : Animal {
    
    func speak() {
        print("AuAu!")
    }
}

class Corgi : Dog {
    
    override func speak() {
        print("AuAu, i'm a Corgi!")
    }
}

class Poodle : Dog {
    
    override func speak() {
        print("AuAu, i'm a Poodle!")
    }
}

class Cat : Animal {
    let isTame: Bool
    
    init(numLegs: Int, isTame: Bool) {
        self.isTame = isTame
        super.init(numLegs: numLegs)
    }
    
    func speak() {
        print("Meow")
    }
}

class Persian : Cat {
    override func speak() {
        print("I'm a Persian cat")
    }
}

class Lion : Cat {
    override func speak() {
        print("I'm a Lion cat")
    }
}
