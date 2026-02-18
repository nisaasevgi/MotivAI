//
//  TargetModel.swift
//  MotivAI
//
//  Created by Nisa on 17.02.2026.
//

import Foundation
import SwiftUI
import SwiftData

@Model
class StudyTarget{
    var id: UUID
    var title: String
    var targetMinutes: Int
    var completedMinutes: Int
    var creationDate: Date
    
    init(title: String, completedMinutes: Int = 0, targetMinutes: Int){
        self.id = UUID()
        self.title = title
        self.targetMinutes = targetMinutes
        self.completedMinutes = completedMinutes
        self.creationDate = Date()
    }
    
    
    
    
}
