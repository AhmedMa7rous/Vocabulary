//
//  MarkWordAsLearnedUseCase.swift
//  Vocabulary
//
//  Created by Ahmed Mahrous on 29/11/2025.
//

import Foundation

final class MarkWordAsLearnedUseCase {
    private let repository: WordRepositoryProtocol
    
    init(repository: WordRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(wordId: UUID) {
        repository.markWordAsLearned(wordId: wordId)
    }
    
    func getLearnedCount() -> Int {
        return repository.getLearnedWordsCount()
    }
}
