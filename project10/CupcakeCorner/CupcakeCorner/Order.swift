//
//  Order.swift
//  CupcakeCorner
//
//  Created by Caique Ferraz on 16/08/24.
//

import Foundation


// challenge 3
struct userInfo: Codable {
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var hasValidAddress: Bool {
        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty {
            return false
        }
        if name.isAllSpace || streetAddress.isAllSpace || city.isAllSpace || zip.isAllSpace {
            return false
        }
        
        return true
    }
    
    init() {
        if let savedInfo = UserDefaults.standard.data(forKey: "userInfo") {
            if let decodedInfo = try? JSONDecoder().decode(userInfo.self, from: savedInfo) {
                name = decodedInfo.name
                streetAddress = decodedInfo.streetAddress
                city = decodedInfo.city
                zip = decodedInfo.zip
                return
            }
        }
        
        name = ""
        streetAddress = ""
        city = ""
        zip = ""
    }
    
    func save() {
        if let encoded = try? JSONEncoder().encode(self) {
            UserDefaults.standard.set(encoded, forKey: "userInfo")
        }
    }
    
}

@Observable
class Order: Codable {
    enum CodingKeys: String, CodingKey {
        case _type = "type"
        case _quantity = "quantity"
        case _specialRequestEnabled = "specialRequestEnabled"
        case _extraFrosting = "extraFrosting"
        case _addSprinkles = "addSprinkles"
        case _user = "user"
    }
    
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
    
    var type = 0
    var quantity = 3
    
    var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
    
    var cost: Decimal {
        // 2$ per cake
        var cost = Decimal(quantity) * 2
        
        // more complicated cakes cost more
        cost += Decimal(type) / 2
        
        // $1 per cake for extra frosting
        if extraFrosting {
            cost += Decimal(quantity)
        }
        
        // $0.5 per cake for sprinkles
        if addSprinkles {
            cost += Decimal(quantity) / 2
        }
        
        return cost
    }
    
    // challenge 3
    var user = userInfo() {
        didSet {
            user.save()
        }
    }

}


// challenge 1

// this extension can only be used in this file (fileprivate)
fileprivate extension String {
    var isAllSpace: Bool {
        // if the string is empty, return false
        guard !self.isEmpty else { return false }
        // self.drop(while: {$0 == " "}) creates a empty substring if the string is only empty spaces
        return self.drop(while: {$0 == " "}).isEmpty
    }
}
