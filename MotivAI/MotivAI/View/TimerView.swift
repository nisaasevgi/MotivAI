//
//  TimerView.swift
//  MotivAI
//
//  Created by Nisa on 17.02.2026.
//
import SwiftData
import SwiftUI
import Combine

struct TimerView: View {
    
    @StateObject private var viewModel = MotivAIViewModel()
    @State private var customMinute: String = ""
    @Environment(\.modelContext) private var context
    
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        Spacer(minLength: 40)
        VStack(spacing: 20) {
            Spacer(minLength: 5)
            
            TextField("What will you study?", text: $viewModel.currentWorkType)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 40)
                .multilineTextAlignment(.center)
                .disabled(viewModel.isRunning)
            
            ZStack {
                
                Circle()
                    .stroke(lineWidth: 40)
                    .foregroundColor(.black)
                    .opacity(0.09)
                
                Circle()
                    .trim(from: 0.0, to: CGFloat(viewModel.timeRemaining)/CGFloat(viewModel.totalTime))
                    .stroke(style: StrokeStyle(lineWidth: 40, lineCap: .round))
                    .foregroundStyle(Color.black)
                    .rotationEffect(.degrees(-90))
                    .animation(.linear(duration: 1.0), value: viewModel.timeRemaining)
                
                Text(viewModel.timeString(time : viewModel.timeRemaining))
                    .font(.system(size: 60, weight: .medium))
            }.frame(width: 300, height: 400)
                .padding()
            
            
            if !viewModel.isRunning{
                HStack(spacing:10){
                    TextField("Target Time(min)", text: $customMinute)
                        .keyboardType(.numberPad)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .frame(width: 120)
                        .multilineTextAlignment(.center)
                    
                    Button(action: {
                        if let newMinute = Int(customMinute) {
                            viewModel.updateTime(minutes: newMinute)
                            
                        }
                        customMinute = ""
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    })
                    {
                        Text("Apply")
                            .bold()
                            .foregroundStyle(Color.white)
                            .padding(.horizontal, 15)
                            .padding(.all, 7)
                            .background(Color.black.opacity(0.7))
                            .cornerRadius(10)
                        
                    }
                    
                }
                .padding(.top, -10)
                
            }   else {
                Spacer().frame(height: 40)
            }
            VStack{
                HStack{
                    Image(systemName: "quote.opening")
                        .foregroundStyle(Color.primary)
                        .font(.footnote)
                    Spacer()
                }
                
                
                Text(viewModel.motivationText)
                    .font(.subheadline)
                    .italic()
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)
                    .fontWeight(.medium)
                    .foregroundStyle(Color.black)
                
                HStack{
                    Spacer()
                    Image(systemName: "quote.closing")
                        .foregroundStyle(Color.primary)
                        .font(.footnote)
                }
            }
            .padding()
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color(.systemGray6))
                
                    .overlay(
                        RoundedRectangle(cornerRadius: 16)
                            .stroke(Color.black.opacity(0.3), lineWidth: 1)
                    )
            )
            .padding(.horizontal)
            Spacer()
            
            Button(action: {
                viewModel.toggleTimer()
            }) {
                
                Text(viewModel.isRunning ?"Pause" : "Focus")
                    .font(.title2).foregroundColor(.white)
                    .padding(.vertical, 15)
                    .padding(.horizontal, 50)
                    .background(viewModel.isRunning ? Color.red : Color.black)
                    .cornerRadius(30)
            }
            Spacer()
            
            
            
        }
        .onReceive(timer) { _ in
            viewModel.tick(context: context)
        }
        
    }
}
#Preview {
    TimerView()
}
