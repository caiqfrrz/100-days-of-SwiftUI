//
//  ContentView.swift
//  Navigation
//
//  Created by Caique Ferraz on 08/08/24.
//

import SwiftUI

class MyPath {
    var path: NavigationPath {
        didSet {
            save()
        }
    }
    
    private let savePath = URL.documentsDirectory.appending(path: "SavedPath")
    
    init() {
        if let data = try? Data(contentsOf: savePath) {
            if let decoded = try? JSONDecoder().decode(NavigationPath.CodableRepresentation.self, from: data) {
                path = NavigationPath(decoded)
                return
            }
        }
        
        path = NavigationPath()
    }
    
    func save() {
        guard let representation = path.codable else { return }
        
        do {
            let data = try? JSONEncoder().encode(representation)
            try data?.write(to: savePath)
        } catch {
            print("Failed to save navigation path.")
        }
    }
    
}

struct DetailView: View {
    let number: Int
    
    var body: some View {
        NavigationLink("Go to new view", value: Int.random(in: 1...100))
            .navigationTitle("Number: \(number)")
    }
}

struct ContentView: View {
    @State private var myPath = MyPath()
    
    var body: some View {
        NavigationStack(path: $myPath.path) {
            DetailView(number: 0)
                .navigationDestination(for: Int.self) { i in
                    DetailView(number: i)
                }
        }
    }
}

#Preview {
    ContentView()
}
