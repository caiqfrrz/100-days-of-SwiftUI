//
//  AddView.swift
//  iExpense
//
//  Created by Caique Ferraz on 02/08/24.
//

import SwiftUI

struct AddView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var name: String = "New expense"
    @State private var type: String = "Personal"
    @State private var amount: Double = 0.0
    
    var expenses: Expenses
    
    let types = ["Business", "Personal"]
    
    var body: some View {
        NavigationStack {
            Form {
                //TextField("Name", text: $name)
                
                Picker("Type", selection: $type) {
                    ForEach(types, id: \.self) {
                        Text($0)
                    }
                }
                
                TextField("Amount", value: $amount, format: .currency(code: "BRL"))
                    .keyboardType(.numbersAndPunctuation)
            }
            .navigationTitle($name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Save") {
                        let expense = ExpenseItem(name: name, type: type, amount: amount)
                        expenses.items.append(expense)
                        dismiss()
                    }
                }
                ToolbarItem(placement: .topBarLeading) {
                    Button("Cancel", role: .cancel) {
                        dismiss()
                    }
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
}

#Preview {
    AddView(expenses: Expenses())
}
