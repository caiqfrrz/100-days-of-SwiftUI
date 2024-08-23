//
//  AddBookView.swift
//  Bookworm
//
//  Created by Caique Ferraz on 23/08/24.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var genre = "Fantasy"
    @State private var review = ""
    @State private var rating = 3
    
    // challenge 1
    var validBook: Bool {
        if title.isNotValidString || author.isNotValidString {
            return false
        }
        return true
    }
    
    let genres = ["Fantasy", "Horror", "Mistery", "Kids", "Poetry", "Action", "Adventure", "Romance"]
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Book's title", text: $title)
                    TextField("Author's name", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                Section("Write a review") {
                    TextEditor(text: $review)
                    
                    RatingView(rating: $rating)
                }
                Section {
                    Button("Save") {
                        let newBook =  Book(title: title, author: author, genre: genre, review: review, rating: rating)
                        
                        modelContext.insert(newBook)
                        dismiss()
                    }
                    .disabled(!validBook)
                }
            }
            .navigationTitle("Add book")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Cancel", role: .destructive) {
                        dismiss()
                    }
                    .foregroundStyle(.red)
                }
            }
        }
    }
}

#Preview {
    AddBookView()
}

// challenge 1
fileprivate extension String {
    var isNotValidString: Bool {
        guard !self.isEmpty else { return true }
        
        return self.drop(while: { $0 == " " }).isEmpty
    }
}
