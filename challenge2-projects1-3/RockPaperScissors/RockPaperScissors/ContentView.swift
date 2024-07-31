//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Caique Ferraz on 19/07/24.
//
// 🪨 📄 ✂️

import SwiftUI

struct EmojiButton: View {
    var text: String = ""
    
    var emoji: String {
        switch text {
        case "Rock":
            return "🪨"
        case "Paper":
            return "📄"
        case "Scissors":
            return "✂️"
        default:
            return ""
        }
    }
    
    var body: some View {
        Text(emoji)
            .font(.system(size: 50))
            .padding()
            .background(LinearGradient(colors: [.orange, .blue], startPoint: .bottomLeading, endPoint: .top))
            .clipShape(.circle)
            .shadow(radius: 5)
    }
}

struct ContentView: View {
    @State var pcMove = Int.random(in: 0..<3)
    @State var playerShouldWin = Bool.random()
    @State var scoreTitle = ""
    @State var showingScore = false
    
    @State var gameCount = 0
    
    @State var endGame: Bool = false
    
    @State var playerScore: Int = 0
    
    let moves = ["Paper", "Rock", "Scissors"]
    
    var winningMove: String {
        if moves[pcMove] == "Paper" {
            return "Scissors"
        } else if moves[pcMove] == "Rock" {
            return "Paper"
        } else {
            return "Rock"
        }
    }
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: .blue, location: 0.1),
                .init(color: .white, location: 0.7)
            ], center: .top, startRadius: 1, endRadius: 500)
            .ignoresSafeArea()
            
            RadialGradient(stops: [
                .init(color: .orange, location: 0.1),
                .init(color: Color(red: 0, green: 0, blue: 0, opacity: 0), location: 0.7)
            ], center: .bottom, startRadius: 1, endRadius: 500)
            .ignoresSafeArea()
            
            
            VStack {
                Spacer()
                
                HStack {
                    Text("Computer's move:")
                        .font(.title2)
                        .foregroundStyle(.orange)
                    
                    EmojiButton(text: moves[pcMove])
                }
                .padding()
                .background(.ultraThinMaterial)
                .clipShape(.rect(cornerRadius: 20))
                .shadow(radius: 5)
                
                Spacer()
                
                
                Text(playerShouldWin ? "You should win" : "You should lose")
                    .font(.title3)
                    .foregroundStyle(playerShouldWin ? .green : .red)
                    .padding()
                
                
                Text("Select your move")
                    .font(.title.bold())
                    .foregroundStyle(.blue)
                
                HStack {
                    ForEach(0..<3) { number in
                        Button {
                            verify(number)
                        } label: {
                            EmojiButton(text: moves[number])
                        }
                    }
                }
                Text("Score: \(playerScore)")
                    .font(.title)
                    .foregroundStyle(.orange)
                
                Spacer()
                Spacer()
                Spacer()
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is now \(playerScore)")
        }
        .alert("End game", isPresented: $endGame) {
            Button("Restart game", action: restart)
        } message: {
            Text("Your final score was \(playerScore)")
        }
    }
    func askQuestion() {
        pcMove = Int.random(in: 0..<3)
        playerShouldWin.toggle()
    }
    func verify(_ number: Int) {
        if playerShouldWin {
            if moves[number] == winningMove {
                scoreTitle = "Victory!"
            } else {
                scoreTitle = "Defeat!"

            }
        }
        else {
            if moves[number] != winningMove {
                scoreTitle = "Victory!"

            } else {
                scoreTitle = "Defeat!"
            }
        }
        if scoreTitle == "Victory!" {
            playerScore += 1
        } else {
            playerScore -= 1
        }
        showingScore = true
        gameCount += 1
        
        if gameCount == 8 {
            endGame = true
            showingScore = false
        }
    }
    func restart() {
        gameCount = 0
        playerScore = 0
        askQuestion()
    }
}

#Preview {
    ContentView()
}
