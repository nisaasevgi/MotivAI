//
//  GeminiService.swift
//  Focusly
//
//  Created by Nisa on 15.02.2026.
//

import Foundation

class GeminiService {
    
    private var apiKey: String{
        guard let filePath = Bundle.main.path(forResource: "Secrets", ofType: "plist"),
                      let plist = NSDictionary(contentsOfFile: filePath),
                      let key = plist["API_KEY"] as? String else {
                    fatalError("HATA: Secrets.plist dosyası veya içinde API_KEY bulunamadı!")
                }
                return key
            
    }
    private let urlString = "https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent"
    
    func fetchMotivation(workType: String) async -> String {
        guard let url = URL(string: "\(urlString)?key=\(apiKey)") else {
            return "Invalid URL"
        }
        
        let promptText = "I am currently focusing on \(workType). Give me a short, powerful, and inspiring 1-sentence motivational quote in English."
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonBody: [String: Any] = [
            "contents": [[
                "parts": [["text": promptText]]
            ]]
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: jsonBody)
        do {
            
            let (data, _) = try await URLSession.shared.data(for: request)
            
            let decodedResponse = try JSONDecoder().decode(GeminiResponse.self, from: data)
            
            if let motivation = decodedResponse.candidates.first?.content.parts.first?.text {
                return motivation
            } else {
                return "Keep going, you've got this!"
            }
            
        } catch {
            print("API ERROR: \(error.localizedDescription)")
            return "Keep going, you've got this!"
        }
    }
}
