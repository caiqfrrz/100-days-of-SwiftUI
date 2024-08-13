//
//  ContentView.swift
//  Habits+
//
//  Created by Caique Ferraz on 12/08/24.
//

import SwiftUI

struct ContentView: View {
    @State private var habits = UserHabits()
    
    var body: some View {
        NavigationStack {
            HabitsList(habits: habits)
        }
    }
}

#Preview {
    ContentView()
}
