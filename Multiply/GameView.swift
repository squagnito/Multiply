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
    
    @State private var firstNumber: Int = 2
    @State private var secondNumber: Int = 2
    @State private var answer: String = ""
    
    @State private var score: Int = 0
    
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
                    
                    Button {
                        // Dismiss keyboard
                    } label: {
                        Text("Done")
                            .font(.title)
                            .foregroundStyle(.purple)
                    }

                }
                Spacer()
            }
            .padding()
            
            VStack {
                Text("What is \(firstNumber) x \(secondNumber) ?")
                    .font(.title)
                    .padding()
                
                Spacer()
                
                Text("Answer:")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                TextField("Enter your answer here", text: $answer)
                    .padding()
                    .keyboardType(.numberPad)
                    .textFieldStyle(.roundedBorder)
                    .multilineTextAlignment(.center)
                Button {
                        
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
                
                Spacer()
            }
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
    
    func generateQuestion() {
        firstNumber = Int.random(in: 2...tableSelection)
        secondNumber = Int.random(in: 2...tableSelection)
    }
}

#Preview {
    GameView(
        tableSelection: .constant(12),
        numQuestions: .constant(5),
        difficulty: .constant(DifficultyOptions.hard)
    )
}
