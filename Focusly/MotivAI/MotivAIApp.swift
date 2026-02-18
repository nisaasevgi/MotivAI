//
//  FocuslyApp.swift
//  Focusly
//
//  Created by Nisa on 15.02.2026.
//

import SwiftUI
import SwiftData

@main
struct MotivAIApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: StudyTarget.self)
    }
}
