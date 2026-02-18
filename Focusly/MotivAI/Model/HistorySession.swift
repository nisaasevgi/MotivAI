//
//  HistorySession.swift
//  MotivAI
//
//  Created by Nisa on 17.02.2026.
//

import Foundation

struct HistorySession: Identifiable{
    
    let id = UUID()
    let workType: String
    let durationMinutes: Int
    let date: Date
    
}
