//
//  WordRepositoryProtocol.swift
//  Vocabulary
//
//  Created by Ahmed Mahrous on 29/11/2025.
//

import Foundation

protocol WordRepositoryProtocol {
    func getWords(completion: @escaping (Result<[Word], Error>) -> Void)
    func markWordAsLearned(wordId: UUID)
    func getLearnedWordsCount() -> Int
}
