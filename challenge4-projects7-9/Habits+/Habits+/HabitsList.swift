//
//  HabitsList.swift
//  Habits+
//
//  Created by Caique Ferraz on 12/08/24.
//

import SwiftUI

struct HabitsList: View {
    @State private var showingSheet = false
    
    let habits: UserHabits
    
    var body: some View {
        List {
            ForEach(habits.habits) { item in
                NavigationLink {
                    HabitView(userHabits: habits, habitId: item.id)
                } label: {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("\(item.name)")
                                .fontWeight(.bold)
                            
                            Text("Done \(item.count) times")
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }
            .onDelete(perform: habits.removeHabit)
        }
        Button {
            showingSheet = true
        } label: {
            VStack {
                Text("Add new habit!")
                    .fontWeight(.bold)
                    .foregroundStyle(.blue)
            }
            .padding()
        }
        .navigationTitle("Habits+")
        .navigationBarTitleDisplayMode(.inline)
        .sheet(isPresented: $showingSheet) {
            NewHabit(habits: habits)
        }
    }
}

#Preview {
    HabitsList(habits: UserHabits())
}
