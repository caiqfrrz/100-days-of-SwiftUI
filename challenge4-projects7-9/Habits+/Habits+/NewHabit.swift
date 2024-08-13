//
//  NewHabit.swift
//  Habits+
//
//  Created by Caique Ferraz on 12/08/24.
//

import SwiftUI

struct NewHabit: View {
    @Environment(\.dismiss) var dismiss
    
    var habits: UserHabits
    
    @State private var name: String = "Activity name"
    @State private var description: String = "Description"
    
    var body: some View {
        NavigationStack {
            Form {
                TextField("Description", text: $description, axis: .vertical)
            }
            .navigationTitle($name)
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        let item = Habit(name: name, description: description)
                        
                        habits.addHabit(habit: item)
                        dismiss()
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel", role: .cancel) {
                        dismiss()
                    }
                }
            }
        }
    }
}

#Preview {
    NewHabit(habits: UserHabits())
}
