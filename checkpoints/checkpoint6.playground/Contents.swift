import Cocoa

struct Car {
    let model: String //constant, won't change
    let numSeats: Int //constant as well
    private(set) var currentGear: Int = 1 //will change but it is good to be able to print it
    
    init(model: String, numSeats: Int) {
        self.model = model
        self.numSeats = numSeats
    }
    
    mutating func gearUp() {
        if currentGear == 10 {
            print("Invalid gear up")
        } else {
            currentGear += 1;
        }
    }
    
    mutating func gearDown() {
        if currentGear == 1 {
            print("Invalid gear down")
        } else {
            currentGear -= 1;
        }

    }
    
}
