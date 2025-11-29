//
//  Word.swift
//  Vocabulary
//
//  Created by Ahmed Mahrous on 29/11/2025.
//

import Foundation

struct Word: Identifiable, Equatable {
    let id: UUID
    let term: String
    let pronunciation: String?
    let partOfSpeech: String
    let definition: String
    let examples: [WordExample]
    let synonyms: [String]
    let antonyms: [String]
    
    init(
        id: UUID = UUID(),
        term: String,
        pronunciation: String?,
        partOfSpeech: String,
        definition: String,
        examples: [WordExample],
        synonyms: [String] = [],
        antonyms: [String] = []
    ) {
        self.id = id
        self.term = term
        self.pronunciation = pronunciation
        self.partOfSpeech = partOfSpeech
        self.definition = definition
        self.examples = examples
        self.synonyms = synonyms
        self.antonyms = antonyms
    }
}
