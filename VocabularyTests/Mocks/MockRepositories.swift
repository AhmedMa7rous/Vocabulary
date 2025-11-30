//
//  MockRepositories.swift
//  Vocabulary
//
//  Created by Ahmed Mahrous on 30/11/2025.
//

import Foundation
@testable import Vocabulary

// MARK: - Mock Word Repository

final class MockWordRepository: WordRepositoryProtocol {
    var getWordsCalled = false
    var getWordsCallCount = 0
    var wordsToReturn: [Word] = []
    var errorToThrow: Error?
    
    var markWordAsLearnedCalled = false
    var markWordAsLearnedCallCount = 0
    var markedWordIds: [UUID] = []
    
    var getLearnedWordsCountCalled = false
    var learnedCountToReturn = 0
    
    func getWords(completion: @escaping (Result<[Word], Error>) -> Void) {
        getWordsCalled = true
        getWordsCallCount += 1
        
        if let error = errorToThrow {
            completion(.failure(error))
        } else {
            completion(.success(wordsToReturn))
        }
    }
    
    func markWordAsLearned(wordId: UUID) {
        markWordAsLearnedCalled = true
        markWordAsLearnedCallCount += 1
        markedWordIds.append(wordId)
    }
    
    func getLearnedWordsCount() -> Int {
        getLearnedWordsCountCalled = true
        return learnedCountToReturn
    }
}

// MARK: - Mock Onboarding Repository

final class MockOnboardingRepository: OnboardingRepositoryProtocol {
    var getOnboardingStepsCalled = false
    var stepsToReturn: [OnboardingStep] = []
    
    var isOnboardingCompletedCalled = false
    var isCompletedToReturn = false
    
    var markOnboardingCompletedCalled = false
    var markOnboardingCompletedCallCount = 0
    
    func getOnboardingSteps() -> [OnboardingStep] {
        getOnboardingStepsCalled = true
        return stepsToReturn
    }
    
    func isOnboardingCompleted() -> Bool {
        isOnboardingCompletedCalled = true
        return isCompletedToReturn
    }
    
    func markOnboardingCompleted() {
        markOnboardingCompletedCalled = true
        markOnboardingCompletedCallCount += 1
    }
}

// MARK: - Test Error

enum TestError: Error {
    case mockError
}
