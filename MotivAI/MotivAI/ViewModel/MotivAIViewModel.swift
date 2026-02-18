//
//  MotivAIViewModel.swift
//  MotivAI
//
//  Created by Nisa on 16.02.2026.
//

import Foundation
import Combine
import SwiftData

@MainActor

class MotivAIViewModel: ObservableObject{
    
    @Published var isRunning = false
    @Published var timeRemaining: Int
    @Published var motivationText = "Believe and you will achieve!"
    @Published var totalTime: Int = 1500
    @Published var sessionHistory: [HistorySession] = []
    @Published var currentWorkType: String = ""
    let geminiService = GeminiService()
    let focusData = MotivAIModel()
    
    init() {
        
        self.timeRemaining = focusData.defaultPomodoroTime
        
    }
    
    func updateTime(minutes: Int){
        let newTimeInSeconds = minutes * 60
        self.timeRemaining = newTimeInSeconds
        self.totalTime = newTimeInSeconds
    }
    
    
    
    func toggleTimer() {
        isRunning.toggle()
        
        if isRunning{
            fetchMotivation()
        }
    }
    
    func tick(context: ModelContext){
        if isRunning{
            if timeRemaining > 0{
                timeRemaining -= 1
                
            }else{
                isRunning = false
                
                let durationMinutes = totalTime / 60
                let finalWorkType = currentWorkType.isEmpty ? "General Study" : currentWorkType
                addSessionToHistory(workType: finalWorkType, duration: durationMinutes, context: context)
                currentWorkType = ""
            }
        }
    }
    
    func fetchMotivation(){
        motivationText = "Generating motivation..."
        Task{
            let response = await
            geminiService.fetchMotivation(workType: "motivation")
            motivationText = response
        }
    }
    func timeString(time: Int) -> String {
        let minutes = time / 60
        let seconds = time % 60
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    func addSessionToHistory(workType: String, duration: Int, context: ModelContext){
        let newSession = StudyTarget(title: workType, completedMinutes: duration, targetMinutes: duration)
        context.insert(newSession)
        print("Permanently saved to SwiftData: \(workType)")
    }
}
