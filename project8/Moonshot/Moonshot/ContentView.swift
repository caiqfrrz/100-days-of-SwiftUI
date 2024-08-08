//
//  ContentView.swift
//  Moonshot
//
//  Created by Caique Ferraz on 05/08/24.
//

import SwiftUI

struct ContentView: View {
    let astronauts: [String: Astronaut] = Bundle.main.decode("astronauts.json")
    let missions: [Mission] = Bundle.main.decode("missions.json")
    
    @State private var isList = false
    
    var body: some View {
        NavigationStack {
            Group {
                if isList {
                    ListLayout(missions: missions, astronauts: astronauts)
                } else {
                    GridLayout(missions: missions, astronauts: astronauts)
                }
            }
            .toolbar {
                Button(isList ? "Grid" : "List") {
                    isList.toggle()
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
