//
//  ContentView.swift
//  iExpense
//
//  Created by Caique Ferraz on 31/07/24.
//

import SwiftUI

struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}

@Observable
class Expenses {
    var items = [ExpenseItem]() {
        didSet {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "Items")
            }
        }
    }
    
    init() {
        if let savedItems = UserDefaults.standard.data(forKey: "Items") {
            if let decodedItems = try? JSONDecoder().decode([ExpenseItem].self, from: savedItems) {
                items = decodedItems
                return
            }
        }
        items = []
    }
}

struct ContentView: View {
    @State private var expenses = Expenses()
    
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(expenses.items) { item in
                    HStack {
                        VStack(alignment: .leading) {
                            Text("\(item.name)")
                                .font(.headline)
                            
                            Text("\(item.type)")
                        }
                        
                        Spacer()
                        
                        Text(item.amount, format: .currency(code: "BRL"))
                    }
                }
                .onDelete(perform: removeItem)
            }
            .navigationTitle("iExpense")
            .toolbar {
//                 Changed to a navigation link due to project 9's challenges
                
                NavigationLink {
                    AddView(expenses: expenses)
                } label: {
                    Image(systemName: "plus")
                }
                
//                 Button("Add expense", systemImage: "plus") {
//                    showingAddExpense = true
//                }
            }
        }
//        .sheet(isPresented: $showingAddExpense) {
//            AddView(expenses: expenses)
//        }
    }
    func removeItem(at offset: IndexSet) {
        expenses.items.remove(atOffsets: offset)
    }
}

#Preview {
    ContentView()
}
