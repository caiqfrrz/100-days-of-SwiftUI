//
//  Habit.swift
//  Habits+
//
//  Created by Caique Ferraz on 12/08/24.
//

import Foundation

struct Habit: Identifiable, Codable, Equatable {
    var id = UUID()
    let name: String
    let description: String
    
    var count: Int = 0 {
        didSet {
            if count < 0 {
                count = 0
            }
        }
    }
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
    
    func addHabit(habit: Habit) {
        habits.append(habit)
    }
    
    func removeHabit(at offset: IndexSet) {
        habits.remove(atOffsets: offset)
    }
    
    func getHabit(id: UUID) -> Habit {
        guard let index = habits.firstIndex(where: {$0.id == id}) else { return Habit(name: "", description: "") }
        
        return habits[index]
    }
    
    func update(habit: Habit) {
        guard let index = getIndex(habit: habit) else { return }
        
        habits[index] = habit
    }
    
    func getIndex(habit: Habit) -> Int? {
        habits.firstIndex(where: {$0.id == habit.id})
    }
}
