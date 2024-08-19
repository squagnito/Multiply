//
//  GameView.swift
//  Multiply
//
//  Created by Aaron Medina on 7/2/24.
//

import SwiftUI

struct GameView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var tableSelection: Int
    @Binding var numQuestions: Int
    @Binding var difficulty: DifficultyOptions
    
    @State private var firstNumber: Int = 4
    @State private var secondNumber: Int = 4
    @State private var answer: String = ""
    @State private var answerChoices: [Int] = []
    @State private var score: Int = 0
    @State private var attempts: Int = 0
    @State private var gameEnded: Bool = false
    
    @FocusState private var isTextFieldFocused: Bool
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Button(action: {
                        dismiss()
                    },
                           label: {
                        Image(systemName: "xmark")
                            .font(.largeTitle)
                            .foregroundStyle(.purple)
                    })
                    
                    Spacer()
                    
                    Text("Score: \(score) / \(attempts)")
                        .font(.title2)
                }
                Spacer()
            }
            .padding()
            
            if gameEnded == true {
                VStack(spacing: 20) {
                    Text("Game over!")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding()
                    
                    Text("You got \(score) out of \(attempts) correct")
                        .fontWeight(.semibold)
                        .padding()
                    
                    Button {
                        dismiss()
                    } label: {
                        Text("Exit")
                            .font(.headline)
                            .padding()
                            .padding(.horizontal)
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(.purple)
                            )
                            .foregroundStyle(.white)
                    }

                }
            }
            
            else {
                VStack {
                    Spacer()
                    
                    Text("What is \(firstNumber) x \(secondNumber) ?")
                        .font(.title)
                        .padding()
                    
                    Spacer()
                    
                    Text("Answer:")
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .fontWeight(.semibold)
                
                    // Hard difficulty
                    if difficulty == DifficultyOptions.hard {
                        TextField("", text: $answer)
                            .padding()
                            .keyboardType(.numberPad)
                            .textFieldStyle(.roundedBorder)
                            .multilineTextAlignment(.center)
                            .font(.title)
                            .focused($isTextFieldFocused)
                        
                        Button {
                            submitAnswer(userAnswer: Int(answer) ?? 0)
                        } label: {
                            Text("Submit")
                                .font(.headline)
                                .padding()
                                .padding(.horizontal)
                                .background(
                                    RoundedRectangle(cornerRadius: 10)
                                        .fill(.purple)
                                )
                                .foregroundStyle(.white)
                        }
                    }
                    
                    // Easy difficulty
                    else {
                        HStack {
                            ForEach(answerChoices, id: \.self) { choice in
                                    Button {
                                        submitAnswer(userAnswer: choice)
                                    } label: {
                                        Text("\(choice)")
                                            .font(.headline)
                                            .padding()
                                            .padding(.horizontal)
                                            .background(
                                                RoundedRectangle(cornerRadius: 10)
                                                    .fill(.purple)
                                            )
                                            .foregroundStyle(.white)
                                    }
                                }
                        }
                        .padding()
                    }
                    
                    
                    
                    Spacer()
                }
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .onAppear {
            generateQuestion()
            isTextFieldFocused = true
        }
    }
    
    func generateQuestion() {
        firstNumber = Int.random(in: 2...tableSelection)
        secondNumber = Int.random(in: 2...tableSelection)
        
        let correctAnswer = firstNumber * secondNumber
        answerChoices = generateAnswerChoices(correctAnswer: correctAnswer)
    }
    
    func generateAnswerChoices(correctAnswer: Int) -> [Int] {
        var choices = [correctAnswer]
        
        while choices.count < 3 {
            let wrongAnswer = Int.random(in: max(correctAnswer - 10, 1)...correctAnswer + 10)
            if wrongAnswer != correctAnswer && !choices.contains(wrongAnswer) {
                choices.append(wrongAnswer)
            }
        }
        
        return choices.shuffled()
    }
    
    func submitAnswer(userAnswer: Int) {
        if userAnswer == firstNumber * secondNumber {
            score += 1
        }
        attempts += 1
        answer = ""
        
        if attempts >= numQuestions {
            // Game ends
            gameEnded = true
        }
        else {
            generateQuestion()
            isTextFieldFocused = true
        }
    }
}

#Preview {
    GameView(
        tableSelection: .constant(12),
        numQuestions: .constant(5),
        difficulty: .constant(DifficultyOptions.easy)
    )
}
