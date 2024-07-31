//
//  ContentView.swift
//  Animations
//
//  Created by Caique Ferraz on 25/07/24.
//

import SwiftUI

struct ContentView: View {
    @State private var animation = 1.0
    @State private var animation3D = 0.0
    
    var body: some View {
        Button("Tap me"){
            withAnimation {
                animation3D += 360.0
            }
        }
        .padding(50)
        .background(.red)
        .foregroundStyle(.white)
        .clipShape(.circle)
        .rotation3DEffect(
            .degrees(animation3D),
                                  axis: (x: 0.0, y: 1.0, z: 0.0)
        )
        .overlay(
            Circle()
                .stroke(.red)
                .scaleEffect(animation)
                .opacity(2 - animation)
                .animation(
                    .easeOut(duration: 1)
                    .repeatForever(autoreverses: false),
                    value: animation
                )
        )
        .onAppear() {
            animation = 2.0
        }
        
    }
}

#Preview {
    ContentView()
}
