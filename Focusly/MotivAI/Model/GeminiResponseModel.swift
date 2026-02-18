//
//  GeminiResponseModel.swift
//  MotivAI
//
//  Created by Nisa on 17.02.2026.
//

import Foundation

struct GeminiResponse: Codable {
    let candidates: [Candidate]
}

struct Candidate: Codable {
    let content: Content
}

struct Content: Codable {
    let parts: [Part]
}

struct Part: Codable {
    let text: String
}
