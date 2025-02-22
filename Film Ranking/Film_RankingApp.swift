//
//  Film_RankingApp.swift
//  Film Ranking
//
//  Created by Manoah Ruiz Rodriguez on 12/19/24.
//

import SwiftUI
import SwiftData

@main
struct Film_RankingApp: App {
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            MediaItem.self,
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(sharedModelContainer)
    }
}
