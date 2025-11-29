//
//  GetWordsUseCase.swift
//  Vocabulary
//
//  Created by Ahmed Mahrous on 29/11/2025.
//

import Foundation

final class GetWordsUseCase {
    private let repository: WordRepositoryProtocol
    
    init(repository: WordRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(completion: @escaping (Result<[Word], Error>) -> Void) {
        repository.getWords(completion: completion)
    }
}
