//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Caique Ferraz on 18/07/24.
//

import SwiftUI

struct FlagImage: View {
    var image: String
    @State private var amountRotation: Double = 0
    
    var body: some View {
        Image(image)
            .clipShape(.capsule)
            .shadow(radius: 5)
            .rotation3DEffect(
                .degrees(amountRotation),
                                      axis: (x: 0.0, y: 1.0, z: 0.0)
            )
    }
    
}

struct ContentView: View {
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var score: Int = 0
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State private var endGame = false
    @State private var numRounds: Int = 0
    
    @State private var rotationAmount = [0.0, 0.0, 0.0]
    
    @State private var animateScoreUp: Bool = false
    @State private var animateScoreDown: Bool = false
    @State private var animateWrong: Bool = false
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.3, blue: 0.7), location: 0.25),
                .init(color: Color(red: 0.05, green: 0.1, blue: 0.4), location: 0.6)
            ], center: .top, startRadius: 10, endRadius: 800)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the flag!")
                    .font(.title3)
                    .foregroundStyle(.thinMaterial)
                    .shadow(color: .pink, radius: 15)
            
                
                VStack(spacing: 20) {
                    VStack {
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.bold))
                            .padding(.bottom, 20)
                            .foregroundStyle(.regularMaterial)
                            .shadow(color: .pink, radius: 15)
                    }
                    ForEach(0..<3) { number in
                        FlagImage(image: countries[number])
                            .rotation3DEffect(
                                .degrees(rotationAmount[number]),
                                                      axis: (x: 0.0, y: 1.0, z: 0.0)
                            )
                            .opacity(animateWrong ? (number == correctAnswer ? 1 : 0.25) : 1)
                            .scaleEffect(animateWrong ? (number == correctAnswer ? 1 : 0.9) : 1)
                            .onTapGesture {
                                flagTapped(number)
                                withAnimation(Animation.easeInOut) {
                                    animateWrong = true
                                }
                            }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                
                VStack {
                    ZStack {
                        Text("+10")
                            .foregroundStyle(.green)
                            .font(.title3)
                            .offset(x: 40, y: -5)
                            .opacity(animateScoreUp ? 1 : 0)
                        
                        Text("-10")
                            .foregroundStyle(.red)
                            .font(.title3.bold())
                            .offset(x: 40, y: 68)
                            .opacity(animateScoreDown ? 1 : 0)
                    }
                    
                    Text("Score: \(score)")
                        .font(.title.bold())
                        .foregroundStyle(.regularMaterial)
                        .shadow(color: .blue, radius: 15)
                    
                }
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is now \(score)")
        }
        .alert("End Game", isPresented: $endGame ) {
            Button("Restart", action: restart)
        } message: {
            Text("Score: \(score)")
        }
    }
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            
            withAnimation {
                rotationAmount[number] += 360
            }
            withAnimation(.easeIn) {
                animateScoreUp = true
            }
            scoreTitle = "Correct"
            score += 10
            
        } else {
            withAnimation(.easeIn) {
                animateScoreDown = true
            }
            
            scoreTitle = "Wrong, that is the flag of \(countries[number])"
            
            score -= 10;
            
        }
        showingScore = true
        numRounds += 1
        
        if numRounds == 8 {
            endGame = true
        }
    }
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        animateWrong = false
        animateScoreUp = false
        animateScoreDown = false
    }
    func restart() {
        score = 0;
        numRounds = 0;
        showingScore = false
        endGame = false
        askQuestion()
    }
}

#Preview {
    ContentView()
}
