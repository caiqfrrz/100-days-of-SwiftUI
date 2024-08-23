//
//  DetailView.swift
//  Bookworm
//
//  Created by Caique Ferraz on 23/08/24.
//

import SwiftData
import SwiftUI

struct DetailView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var showingDeleteAlert = false
    
    let book: Book
    
    
    var body: some View {
        ScrollView {
            ZStack {
                Image(book.genre)
                    .frame(height: 100)
                    .clipped()
                
                VStack {
                    Text(book.genre.uppercased())
                        .font(.system(size: 55))
                        .fontWeight(.black)
                        .foregroundStyle(.regularMaterial)
                    
                }
            }
            
            Text(book.author)
                .font(.title)
                .foregroundStyle(.secondary)
            
            Text(book.review)
                .font(.title3)
                .padding()
            
            RatingView(rating: .constant(book.rating))
                .font(.largeTitle)
            
            // challenge 3
            Text(book.date.formatted(date: .abbreviated, time: .omitted))
                .padding()
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .navigationTitle(book.title)
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Delete book", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive, action: deleteBook)
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("Are you sure?")
        }
        .toolbar {
            Button("Delete this book", systemImage: "trash") {
                showingDeleteAlert = true
            }
        }
    }
    
    func deleteBook() {
        modelContext.delete(book)
        dismiss()
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Book.self, configurations: config)
        let example = Book(title: "Test Book", author: "Test Author", genre: "Fantasy", review: "Awful book", rating: 4)
        
        return DetailView(book: example)
            .modelContainer(container)
    } catch {
        return Text("Text failed to create preview: \(error.localizedDescription)")
    }
}
