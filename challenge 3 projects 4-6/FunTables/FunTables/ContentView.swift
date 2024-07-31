//
//  ContentView.swift
//  FunTables
//
//  Created by Caique Ferraz on 29/07/24.
//

import SwiftUI

struct Question {
    let text: String
    let answer: Int
}

struct ContentView: View {
    @State private var selected: Int = 2
    @State private var numQuestions: Int = 5
    @State private var arrayQuestions: [Question] = []
    
    @FocusState private var answerIsFocused: Bool
    @State private var playerAnswer: Int = 0
    
    @State private var didAnswer: Bool = false
    @State private var correctAnswer: Bool = false
    @State private var playerScore: Int = 0
    @State private var wrongAnswer: Bool = false
    @State private var currentQuestion: Int = 0
    
    @State private var gameActive: Bool = false
    @State private var endGame: Bool = false
    
    let possibleNumQuestions = [5, 10, 20]
    
    var body: some View {
        NavigationStack {
            ZStack {
                RadialGradient(stops: [
                    .init(color: .blue, location: 0.1),
                    .init(color: .white, location: 0.6),
                ],center: .top, startRadius: 5, endRadius: 800)
                .ignoresSafeArea()
                
                if gameActive {
                    VStack {
                        ZStack {
                            Text("Wrong!")
                                .font(.system(size: 30))
                                .foregroundStyle(.red)
                                .opacity(wrongAnswer ? 0.9 : 0)
                                .animation(.easeInOut, value: wrongAnswer)
                            
                            Text("Correct!")
                                .font(.system(size: 30))
                                .foregroundStyle(.green)
                                .opacity(correctAnswer ? 0.9 : 0)
                                .animation(.easeInOut, value: correctAnswer)
                        }
                        HStack {
                            
                            Text("\(arrayQuestions[currentQuestion].text) = ")
                                .font(.system(size: 50).bold())
                                .foregroundStyle(.blue)
                                .shadow(radius: 15)
                            
                            //                            Text("9 * 2 = ")
                            //                                .font(.system(size: 50).bold())
                            //                                .foregroundStyle(.blue)
                            //                                .shadow(radius: 15)
                            
                            TextField("Answer", value: $playerAnswer, format: .number)
                                .frame(width: 65)
                                .keyboardType(.decimalPad)
                                .font(.system(size: 50))
                                .shadow(radius: 15)
                                .focused($answerIsFocused)
                            
                        }
                        
                        Button(didAnswer ? "Next Question" : "Answer", action: didAnswer ? nextQuestion : verifyAnswer)
                            .padding()
                            .background(didAnswer ? (correctAnswer ? .green : .red) : .blue)
                            .foregroundStyle(.thickMaterial)
                            .clipShape(.rect(cornerRadius: 20))
                            .animation(.easeInOut, value: didAnswer)
                        
                    }
                } else {
                    VStack {
                        VStack {
                            Text("Up to the \(selected)th multiplication table?")
                                .font(.title2.bold())
                                .foregroundStyle(.ultraThickMaterial)
                            
                            HStack {
                                Button("-") {
                                    if selected > 2 {
                                        selected -= 1
                                    }
                                }
                                .padding(20)
                                .background(.orange)
                                .clipShape(.circle)
                                .overlay(Circle().stroke(.red, lineWidth: 6))
                                .font(.system(size: 30))
                                .foregroundStyle(.black)
                                
                                
                                Button("+") {
                                    if selected < 12 {
                                        selected += 1
                                    }
                                }
                                .padding(20)
                                .background(.green)
                                .clipShape(.circle)
                                .overlay(Circle().stroke(Color(red: 0.1, green: 0.5, blue: 0.32), lineWidth: 6))
                                .font(.system(size: 19))
                                .foregroundStyle(.black)
                            }
                        }
                        .padding()
                        
                        VStack {
                            Text("Number of questions")
                                .font(.title2.bold())
                                .foregroundStyle(.ultraThickMaterial)
                                .shadow(color: .blue, radius: 10)
                            
                            HStack {
                                ForEach(possibleNumQuestions, id: \.self) { number in
                                    Button("\(number)") {
                                        numQuestions = number
                                    }
                                    .frame(minWidth: 30, minHeight: 30)
                                    .padding()
                                    .background(.green)
                                    .clipShape(.rect(cornerRadius: 10))
                                    .shadow(radius: 10)
                                    .foregroundStyle(.ultraThickMaterial)
                                    .opacity(numQuestions == number ? 1 : 0.6)
                                    .animation(.default, value: numQuestions)
                                }
                            }
                            
                            .pickerStyle(.segmented)
                            .padding(.horizontal, 40)
                        }
                        .padding()
                        
                        Button("Start game", action: startGame)
                            .padding()
                            .background(.blue)
                            .foregroundStyle(.white)
                            .font(.system(size: 20).bold())
                            .clipShape(.rect(cornerRadius: 20))
                            .padding(.top, 70)
                    }
                }
            }
            .toolbar {
                if answerIsFocused {
                    Button("Done") {
                        answerIsFocused = false
                    }
                    .foregroundStyle(.green)
                    .fontWeight(.bold)
                }
            }
            .alert("End Game!", isPresented: $endGame) {
                Button("Restart", action: resetGame)
            } message: {
                Text("You got \(playerScore) right out of \(numQuestions)!")
            }
        }
    }
    
    func startGame() {
        gameActive = true
        
        for _ in 0..<numQuestions {
            let rand1 = Int.random(in: 2...selected)
            let rand2 = Int.random(in: 2...12)
            
            arrayQuestions.append(Question(text: "\(rand1) * \(rand2)", answer: rand1*rand2))
        }
    }
    
    func verifyAnswer() {
        
        if playerAnswer == arrayQuestions[currentQuestion].answer {
            correctAnswer = true
            playerScore += 1
        } else {
            wrongAnswer = true
        }
        didAnswer = true
    }
    
    func nextQuestion() {
        
        if currentQuestion == numQuestions - 1 {
            endGame = true
            return
        }
        
        currentQuestion += 1
        playerAnswer = 0
        didAnswer = false
        correctAnswer = false
        wrongAnswer = false
        
    }
    
    func resetGame() {
        arrayQuestions.removeAll()
        playerAnswer = 0
        didAnswer = false
        correctAnswer = false
        wrongAnswer = false
        currentQuestion = 0
        
        endGame = false
        gameActive = false
    }
}

#Preview {
    ContentView()
}
