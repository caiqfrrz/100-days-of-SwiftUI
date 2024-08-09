//
//  ContentView.swift
//  Navigation
//
//  Created by Caique Ferraz on 08/08/24.
//

import SwiftUI

struct Student {
    var id = UUID()
    var name: String
    var age: Int
}

struct ContentView: View {
    var body: some View {
        NavigationStack {
            List(0..<100) { number in
                NavigationLink("Row \(number)", value: number)
            }
            .navigationDestination(for: Int.self) { selected in
                Text("Hello \(selected)")
            }
        }
    }
}

#Preview {
    ContentView()
}
