//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Caique Ferraz on 23/08/24.
//

import SwiftData
import SwiftUI

@main
struct BookwormApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Book.self)
    }
}
