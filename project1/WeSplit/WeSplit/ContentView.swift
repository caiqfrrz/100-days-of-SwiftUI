//
//  ContentView.swift
//  WeSplit
//
//  Created by Caique Ferraz on 12/07/24.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var amountPeople = 2
    @State private var tipSelected = 20
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [0, 10, 15, 20, 25]
    
    var totalValue: Double {
        ((checkAmount / 100) * Double(tipSelected)) + checkAmount
    }
    
    var perPerson: Double {
        totalValue / Double(amountPeople + 2)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "BRL"))
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    
                    Picker("Number of People", selection: $amountPeople) {
                        ForEach(2..<10) {
                            Text("\($0) people")
                        }
                    }
                }
                Section("How much do you want to tip?") {
                    Picker("Amount of tip", selection: $tipSelected) {
                        ForEach(0..<101) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                Section("Total amount") {
                    Text(totalValue, format: .currency(code: Locale.current.currency?.identifier ?? "BRL"))
                        .foregroundColor(tipSelected == 0 ? .red : .black)
                }
                Section("Amount per person:") {
                    Text(perPerson, format: .currency(code: Locale.current.currency?.identifier ?? "BRL"))
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                if amountIsFocused {
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
