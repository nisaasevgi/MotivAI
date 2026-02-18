//
//  AddTargetView.swift
//  MotivAI
//
//  Created by Nisa on 17.02.2026.
//

import SwiftUI
import SwiftData

struct AddTargetView: View {
    
    @Environment(\.modelContext) private var context
    
    @State private var targetTitle: String = ""
    @State private var targetMinutes: String = ""
    
    var body: some View {
        Form{
            Section(header: Text("Create New Target")){
                TextField("Enter Target Name", text:$targetTitle)
                
                TextField("Target Duration (min)", text: $targetMinutes)
                    .keyboardType(.numberPad)
            }
            Button("Save"){
                saveTarget()
            }
        }
    }
    func saveTarget() {
        if let minutes = Int(targetMinutes){
            
            let newTarget = StudyTarget(title: targetTitle, completedMinutes: 0, targetMinutes: minutes)
            context.insert(newTarget)
            
            targetTitle = ""
            targetMinutes = ""
            
            print("Target saved successfully")
        }
    }
}

#Preview {
    AddTargetView()
}
