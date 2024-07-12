//
//  ContentView.swift
//  Multiply
//
//  Created by Aaron Medina on 6/29/24.
//

import SwiftUI

enum DifficultyOptions: String, CaseIterable {
    case easy
    case hard
}

struct ContentView: View {
    
    @State private var showSheet: Bool = false
    @State private var tableSelection: Int = 4
    @State private var numQuestions: Int = 5
    
    let numQuestionsOptions = [5, 10, 15, 20]
    
    @State private var difficulty: DifficultyOptions = DifficultyOptions.easy
    
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    
    var body: some View {
        
        Text("Multiply")
            .padding(.vertical, 30)
            .kerning(4)
            .fontDesign(.monospaced)
            .frame(maxWidth: .infinity)
            .font(.title)
            .fontWeight(.bold)
            .background(.cyan)
            .foregroundStyle(.white)
        
        VStack {
            Text("Which table do you want to practice?")
                .padding(.vertical, 30)
                .font(.headline)
            
            LazyVGrid(columns: columns, spacing: 20) {
                ForEach(4..<21) { number in
                    Button(action: {
                        tableSelection = number
                    }, label: {
                        Text("\(number)")
                            .fontWeight(tableSelection == number ? .bold : .semibold)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(tableSelection == number ? .purple : .orange)
                            .foregroundStyle(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 5))
                    })
                }
            }
            
            Spacer()
            
            HStack {
                Text("# of Problems")
                    .font(.headline)
                
                Picker("How many problems do you want to practice?", selection: $numQuestions) {
                    ForEach(numQuestionsOptions, id: \.self) { option in
                        Text("\(option)")
                    }
                }
                .pickerStyle(.palette)
            }
            
            Spacer()
            
            HStack {
                Text("Difficulty: ")
                    .font(.headline)
                
                Picker("Difficulty", selection: $difficulty) {
                    ForEach(DifficultyOptions.allCases, id: \.self) { option in
                        Text(option.rawValue.capitalized)
                    }
                }
                .pickerStyle(.palette)
            }
            
            Spacer()
            
            Button(action: {
                showSheet.toggle()
            }, label: {
                Text("Start".uppercased())
                    .fontWeight(.bold)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .foregroundStyle(.white)
                    .background(.purple)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
            })
            .fullScreenCover(isPresented: $showSheet, content: {
                GameView(tableSelection: $tableSelection, numQuestions: $numQuestions, difficulty: $difficulty)
            })
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
