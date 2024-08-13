//
//  HabitView.swift
//  Habits+
//
//  Created by Caique Ferraz on 13/08/24.
//

import SwiftUI

struct HabitView: View {
    
    let userHabits: UserHabits
    let habitId: UUID
    
    var habit: Habit {
        userHabits.getHabit(id: habitId)
    }
    
    var body: some View {
        List {
            Section("Description: ") {
                Text(habit.description)
            }
            Section("Count:") {
                Stepper( onIncrement:{ self.modifyCount(by: +1) }, onDecrement: { self.modifyCount(by: -1) }, label: { 
                    Text("Completed \(habit.count) times")
                }
                    )
            }
        }
        .navigationTitle(habit.name)
    }
    
    func modifyCount(by change: Int) {
        var activity = self.habit
        activity.count += change
        userHabits.update(habit: activity)
    }
}

#Preview {
    let habit = Habit(name: "helo", description: "trying to preview xcode")
    
    return HabitView(userHabits: UserHabits(), habitId: habit.id)
}
