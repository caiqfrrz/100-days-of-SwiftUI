//
//  Book.swift
//  Bookworm
//
//  Created by Caique Ferraz on 23/08/24.
//

import Foundation
import SwiftData

@Model
class Book {
    var title: String
    var author: String
    var genre: String
    var review: String
    var rating: Int
    
    // challenge 3
    let date: Date
    
    init(title: String, author: String, genre: String, review: String, rating: Int) {
        self.title = title
        self.author = author
        self.genre = genre
        self.review = review
        self.rating = rating
        
        self.date = Date.now
    }
}
