//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Caique Ferraz on 19/07/24.
//

import SwiftUI

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
}

extension View {
    func titleProeminent() -> some View {
        modifier(Title())
    }
}

struct ContentView: View {
    var body: some View {
        VStack {
            Text("Hello, world!")
                .titleProeminent()
        }

    }
}

#Preview {
    ContentView()
}
