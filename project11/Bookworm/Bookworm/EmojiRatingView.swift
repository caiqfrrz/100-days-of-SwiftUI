//
//  EmojiRatingview.swift
//  Bookworm
//
//  Created by Caique Ferraz on 23/08/24.
//

import SwiftUI

struct EmojiRatingView: View {
    let rating: Int
    
    var body: some View {
        switch rating {
        case 1:
            Text("🤬")
        case 2:
            Text("🙁")
        case 3:
            Text("🤨")
        case 4:
            Text("😛")
        case 5:
            Text("😆")
        default:
            Text("")
        }
    }
}

#Preview {
    EmojiRatingView(rating: 5)
}

