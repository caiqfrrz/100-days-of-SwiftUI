//
//  Habit.swift
//  Habits+
//
//  Created by Caique Ferraz on 12/08/24.
//

import Foundation

struct Habit: Identifiable, Codable {
    var id = UUID()
    let name: String
    let description: String
}

@Observable
class UserHabits {
    
    var habits = [Habit]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(habits) {
                UserDefaults.standard.set(encoded, forKey: "Habits")
            }
        }
    }
    
    init() {
        if let savedHabits = UserDefaults.standard.data(forKey: "Habits") {
            if let decodedHabits = try? JSONDecoder().decode([Habit].self, from: savedHabits) {
                habits = decodedHabits
                return
            }
        }
        
        habits = []
    }
    
    func removeHabit(at offset: IndexSet) {
        habits.remove(atOffsets: offset)
    }
}
