import Cocoa

protocol Building {
    var rooms: Int { get }
    var cost: Int { get set }
    var agentName: String { get set }
    
    func salesSummary()
}
extension Building {
    func salesSummary(){
        print("This building has \(rooms) rooms and is available for $\(cost) contacting the salesman \(agentName)")    }
}

struct House : Building {
    let rooms = 3
    var cost = 100_000
    var agentName = "Caique Ferraz"
    
    func salesSummary() {
        print("This house has \(rooms) rooms and is available for $\(cost) contacting the salesman\(agentName)")
    }
}

struct Office : Building {
    let rooms = 1
    var cost = 50_000
    var agentName = "Caique Cornelio"
    
    func salesSummary() {
        print("This office has \(rooms) rooms and is available for $\(cost) contacting the salesman \(agentName)")
    }
}

var office = Office()

office.salesSummary()
