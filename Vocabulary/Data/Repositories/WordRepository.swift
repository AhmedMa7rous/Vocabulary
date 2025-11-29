//
//  WordRepository.swift
//  Vocabulary
//
//  Created by Ahmed Mahrous on 29/11/2025.
//

import Foundation

final class WordRepository: WordRepositoryProtocol {
    private let localDataSource: LocalWordDataSource
    private let userDefaultsDataSource: UserDefaultsDataSource
    
    init(
        localDataSource: LocalWordDataSource,
        userDefaultsDataSource: UserDefaultsDataSource
    ) {
        self.localDataSource = localDataSource
        self.userDefaultsDataSource = userDefaultsDataSource
    }
    
    func getWords(completion: @escaping (Result<[Word], Error>) -> Void) {
        // Simulate async operation
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) { [weak self] in
            guard let self = self else { return }
            let words = self.localDataSource.getWords()
            completion(.success(words))
        }
    }
    
    func markWordAsLearned(wordId: UUID) {
        userDefaultsDataSource.markWordAsLearned(wordId: wordId)
    }
    
    func getLearnedWordsCount() -> Int {
        return userDefaultsDataSource.getLearnedWordsCount()
    }
}
