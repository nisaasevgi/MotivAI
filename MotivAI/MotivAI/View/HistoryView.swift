//
//  HistoryView.swift
//  MotivAI
//
//  Created by Nisa on 17.02.2026.
//

import SwiftUI
import SwiftData

struct HistoryView: View {
    
    @Query(sort: \StudyTarget.creationDate, order: .reverse)  var pastSessions: [StudyTarget]
    var body: some View {
        NavigationStack{
            List{
                ForEach(pastSessions) {session in
                    HStack{
                        VStack(alignment: .leading)
                        {
                            Text(session.title)
                                .font(.headline)
                        }
                        Spacer()
                        
                        Text("\(session.completedMinutes) / \(session.targetMinutes) min")
                            .foregroundColor(session.completedMinutes >= session.targetMinutes ? .green : .red)
                        
                    }
                    .padding(.vertical, 4)
                }
            }
            .navigationTitle("History")
        }
    }
}

#Preview {
    HistoryView()
}
