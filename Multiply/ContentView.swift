//
//  ContentView.swift
//  Multiply
//
//  Created by Aaron Medina on 6/29/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var tableSelection = 2
    @State private var numQuestions = 5
    
    let numQuestionsOptions = [5, 10, 15, 20]
    let tables = Array(2...15)
    
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
                ForEach(2..<21) { number in
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
            
            Text("How many problems do you want to practice?")
                .padding(.bottom, 15)
                .font(.headline)
            
            Picker("How many problems do you want to practice?", selection: $numQuestions) {
                ForEach(numQuestionsOptions, id: \.self) { option in
                    Text("\(option)")
                }
            }
            .pickerStyle(.segmented)
            
            Spacer()
            Button(action: {
                // Start game
            }, label: {
                HStack {
                    Text("START")
                        .fontWeight(.bold)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .foregroundStyle(.white)
                        .background(.purple)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            })
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
