//
//  WordRepositoryTests.swift
//  Vocabulary
//
//  Created by Ahmed Mahrous on 30/11/2025.
//

import XCTest
@testable import Vocabulary

final class WordRepositoryTests: XCTestCase {
    
    var sut: WordRepository!
    var localDataSource: LocalWordDataSource!
    var userDefaultsDataSource: UserDefaultsDataSource!
    var mockUserDefaults: UserDefaults!
    
    override func setUp() {
        super.setUp()
        // Use in-memory UserDefaults for testing
        mockUserDefaults = UserDefaults(suiteName: "TestDefaults")
        mockUserDefaults.removePersistentDomain(forName: "TestDefaults")
        
        localDataSource = LocalWordDataSource()
        userDefaultsDataSource = UserDefaultsDataSource(userDefaults: mockUserDefaults)
        
        sut = WordRepository(
            localDataSource: localDataSource,
            userDefaultsDataSource: userDefaultsDataSource
        )
    }
    
    override func tearDown() {
        mockUserDefaults.removePersistentDomain(forName: "TestDefaults")
        sut = nil
        localDataSource = nil
        userDefaultsDataSource = nil
        mockUserDefaults = nil
        super.tearDown()
    }
    
    // MARK: - Get Words Tests
    
    func test_getWords_returnsSuccess() {
        // Given
        let expectation = self.expectation(description: "Get words")
        var receivedResult: Result<[Word], Error>?
        
        // When
        sut.getWords { result in
            receivedResult = result
            expectation.fulfill()
        }
        
        // Then
        waitForExpectations(timeout: 2.0)
        
        guard case .success(let words) = receivedResult else {
            XCTFail("Expected success")
            return
        }
        
        XCTAssertFalse(words.isEmpty)
    }
    
    func test_getWords_returnsFiveWords() {
        // Given
        let expectation = self.expectation(description: "Get words")
        var receivedWords: [Word] = []
        
        // When
        sut.getWords { result in
            if case .success(let words) = result {
                receivedWords = words
            }
            expectation.fulfill()
        }
        
        // Then
        waitForExpectations(timeout: 2.0)
        XCTAssertEqual(receivedWords.count, 5)
    }
    
    func test_getWords_returnsWordsWithCorrectTerms() {
        // Given
        let expectedTerms = ["Ephemeral", "Serendipity", "Eloquent", "Resilient", "Ubiquitous"]
        let expectation = self.expectation(description: "Get words")
        var receivedWords: [Word] = []
        
        // When
        sut.getWords { result in
            if case .success(let words) = result {
                receivedWords = words
            }
            expectation.fulfill()
        }
        
        // Then
        waitForExpectations(timeout: 2.0)
        let terms = receivedWords.map { $0.term }
        XCTAssertEqual(terms, expectedTerms)
    }
    
    func test_getWords_eachWordHasExamples() {
        // Given
        let expectation = self.expectation(description: "Get words")
        var receivedWords: [Word] = []
        
        // When
        sut.getWords { result in
            if case .success(let words) = result {
                receivedWords = words
            }
            expectation.fulfill()
        }
        
        // Then
        waitForExpectations(timeout: 2.0)
        for word in receivedWords {
            XCTAssertFalse(word.examples.isEmpty, "\(word.term) should have examples")
            XCTAssertEqual(word.examples.count, 2)
        }
    }
    
    // MARK: - Mark Word As Learned Tests
    
    func test_markWordAsLearned_storesWordId() {
        // Given
        let wordId = UUID()
        
        // When
        sut.markWordAsLearned(wordId: wordId)
        
        // Then
        let learnedIds = userDefaultsDataSource.getLearnedWordIds()
        XCTAssertTrue(learnedIds.contains(wordId.uuidString))
    }
    
    func test_markWordAsLearned_multipleWords_storesAll() {
        // Given
        let word1 = UUID()
        let word2 = UUID()
        let word3 = UUID()
        
        // When
        sut.markWordAsLearned(wordId: word1)
        sut.markWordAsLearned(wordId: word2)
        sut.markWordAsLearned(wordId: word3)
        
        // Then
        let learnedIds = userDefaultsDataSource.getLearnedWordIds()
        XCTAssertEqual(learnedIds.count, 3)
        XCTAssertTrue(learnedIds.contains(word1.uuidString))
        XCTAssertTrue(learnedIds.contains(word2.uuidString))
        XCTAssertTrue(learnedIds.contains(word3.uuidString))
    }
    
    func test_markWordAsLearned_sameTwice_onlyStoresOnce() {
        // Given
        let wordId = UUID()
        
        // When
        sut.markWordAsLearned(wordId: wordId)
        sut.markWordAsLearned(wordId: wordId)
        
        // Then
        let learnedIds = userDefaultsDataSource.getLearnedWordIds()
        XCTAssertEqual(learnedIds.count, 1)
    }
    
    // MARK: - Get Learned Words Count Tests
    
    func test_getLearnedWordsCount_initiallyZero() {
        // When
        let count = sut.getLearnedWordsCount()
        
        // Then
        XCTAssertEqual(count, 0)
    }
    
    func test_getLearnedWordsCount_afterMarkingOne_returnsOne() {
        // Given
        let wordId = UUID()
        sut.markWordAsLearned(wordId: wordId)
        
        // When
        let count = sut.getLearnedWordsCount()
        
        // Then
        XCTAssertEqual(count, 1)
    }
    
    func test_getLearnedWordsCount_afterMarkingMultiple_returnsCorrectCount() {
        // Given
        for _ in 0..<5 {
            sut.markWordAsLearned(wordId: UUID())
        }
        
        // When
        let count = sut.getLearnedWordsCount()
        
        // Then
        XCTAssertEqual(count, 5)
    }
    
    // MARK: - Integration Tests
    
    func test_integration_markAndCount() {
        // Given
        let expectation = self.expectation(description: "Get words")
        var words: [Word] = []
        
        sut.getWords { result in
            if case .success(let fetchedWords) = result {
                words = fetchedWords
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 2.0)
        
        // When - Mark first 3 words as learned
        for i in 0..<3 {
            sut.markWordAsLearned(wordId: words[i].id)
        }
        
        // Then
        let count = sut.getLearnedWordsCount()
        XCTAssertEqual(count, 3)
    }
}
