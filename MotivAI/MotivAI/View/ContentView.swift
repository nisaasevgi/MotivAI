//
//  ContentView.swift
//  MotivAI
//
//  Created by Nisa on 15.02.2026.
//

import SwiftUI
import Combine

struct ContentView: View {
    
    var body: some View {
        TabView{
            TimerView()
                .tabItem {
                    Label("Stopwatch", systemImage: "timer")
                    
                }
            AddTargetView()
                .tabItem {
                    Label("Add Record", systemImage: "plus.circle")
                }
            HistoryView()
                .tabItem {
                    Label("History", systemImage: "clock.fill")
                }
        }
        .accentColor(.black)
    }
}

#Preview {
    ContentView()
}
