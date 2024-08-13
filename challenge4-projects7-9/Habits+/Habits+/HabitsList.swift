//
//  HabitsList.swift
//  Habits+
//
//  Created by Caique Ferraz on 12/08/24.
//

import SwiftUI

struct HabitsList: View {
    let habits: UserHabits
    
    var body: some View {
        List {
            ForEach(habits.habits) { item in
                NavigationLink {
                    Text("oii")
                } label: {
                    HStack {
                        VStack(alignment: .leading) {
                            Text("\(item.name)")
                                .fontWeight(.bold)
                            
                        }
                    }
                }
            }
            .onDelete(perform: habits.removeHabit)
        }
        List {
            NavigationLink {
                NewHabit(habits: habits)
            } label: {
                VStack {
                    Text("Add new habit!")
                        .fontWeight(.bold)
                }
            }
        }
        
        .navigationTitle("Habits+")
    }
}

#Preview {
    HabitsList(habits: UserHabits())
}
