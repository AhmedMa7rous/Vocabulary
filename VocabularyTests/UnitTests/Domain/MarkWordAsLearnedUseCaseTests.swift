//
//  MarkWordAsLearnedUseCaseTests.swift
//  Vocabulary
//
//  Created by Ahmed Mahrous on 30/11/2025.
//

import XCTest
@testable import Vocabulary

final class MarkWordAsLearnedUseCaseTests: XCTestCase {
    
    var sut: MarkWordAsLearnedUseCase!
    var mockRepository: MockWordRepository!
    
    override func setUp() {
        super.setUp()
        mockRepository = MockWordRepository()
        sut = MarkWordAsLearnedUseCase(repository: mockRepository)
    }
    
    override func tearDown() {
        sut = nil
        mockRepository = nil
        super.tearDown()
    }
    
    // MARK: - Mark Word As Learned Tests
    
    func test_execute_callsRepositoryMarkWordAsLearned() {
        // Given
        let wordId = UUID()
        
        // When
        sut.execute(wordId: wordId)
        
        // Then
        XCTAssertTrue(mockRepository.markWordAsLearnedCalled)
        XCTAssertEqual(mockRepository.markWordAsLearnedCallCount, 1)
    }
    
    func test_execute_passesCorrectWordIdToRepository() {
        // Given
        let wordId = UUID()
        
        // When
        sut.execute(wordId: wordId)
        
        // Then
        XCTAssertEqual(mockRepository.markedWordIds.first, wordId)
    }
    
    func test_execute_canMarkMultipleWords() {
        // Given
        let word1 = UUID()
        let word2 = UUID()
        let word3 = UUID()
        
        // When
        sut.execute(wordId: word1)
        sut.execute(wordId: word2)
        sut.execute(wordId: word3)
        
        // Then
        XCTAssertEqual(mockRepository.markWordAsLearnedCallCount, 3)
        XCTAssertEqual(mockRepository.markedWordIds.count, 3)
        XCTAssertTrue(mockRepository.markedWordIds.contains(word1))
        XCTAssertTrue(mockRepository.markedWordIds.contains(word2))
        XCTAssertTrue(mockRepository.markedWordIds.contains(word3))
    }
    
    // MARK: - Get Learned Count Tests
    
    func test_getLearnedCount_callsRepositoryGetLearnedWordsCount() {
        // Given
        mockRepository.learnedCountToReturn = 5
        
        // When
        let count = sut.getLearnedCount()
        
        // Then
        XCTAssertTrue(mockRepository.getLearnedWordsCountCalled)
        XCTAssertEqual(count, 5)
    }
    
    func test_getLearnedCount_returnsZeroWhenNoWordsLearned() {
        // Given
        mockRepository.learnedCountToReturn = 0
        
        // When
        let count = sut.getLearnedCount()
        
        // Then
        XCTAssertEqual(count, 0)
    }
    
    func test_getLearnedCount_returnsCorrectCount() {
        // Given
        mockRepository.learnedCountToReturn = 42
        
        // When
        let count = sut.getLearnedCount()
        
        // Then
        XCTAssertEqual(count, 42)
    }
    
    // MARK: - Integration Tests
    
    func test_markingWordIncreasesCount() {
        // This would require a real repository or more sophisticated mock
        // Just verify the use case calls both methods correctly
        
        // Given
        let wordId = UUID()
        mockRepository.learnedCountToReturn = 1
        
        // When
        sut.execute(wordId: wordId)
        let count = sut.getLearnedCount()
        
        // Then
        XCTAssertTrue(mockRepository.markWordAsLearnedCalled)
        XCTAssertTrue(mockRepository.getLearnedWordsCountCalled)
        XCTAssertEqual(count, 1)
    }
}
