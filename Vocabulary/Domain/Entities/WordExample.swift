//
//  WordExample.swift
//  Vocabulary
//
//  Created by Ahmed Mahrous on 29/11/2025.
//

import Foundation

struct WordExample: Identifiable, Equatable {
    let id: UUID
    let sentence: String
    let highlightedWord: String
    
    init(
        id: UUID = UUID(),
        sentence: String,
        highlightedWord: String
    ) {
        self.id = id
        self.sentence = sentence
        self.highlightedWord = highlightedWord
    }
}
