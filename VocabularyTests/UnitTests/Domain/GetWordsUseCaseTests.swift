//
//  GetWordsUseCaseTests.swift
//  Vocabulary
//
//  Created by Ahmed Mahrous on 30/11/2025.
//

import XCTest
@testable import Vocabulary

final class GetWordsUseCaseTests: XCTestCase {
    
    var sut: GetWordsUseCase!
    var mockRepository: MockWordRepository!
    
    override func setUp() {
        super.setUp()
        mockRepository = MockWordRepository()
        sut = GetWordsUseCase(repository: mockRepository)
    }
    
    override func tearDown() {
        sut = nil
        mockRepository = nil
        super.tearDown()
    }
    
    // MARK: - Success Tests
    
    func test_execute_callsRepositoryGetWords() {
        // Given
        mockRepository.wordsToReturn = TestFixtures.createMultipleWords()
        
        // When
        sut.execute { _ in }
        
        // Then
        XCTAssertTrue(mockRepository.getWordsCalled)
        XCTAssertEqual(mockRepository.getWordsCallCount, 1)
    }
    
    func test_execute_whenRepositoryReturnsWords_completesWithSuccess() {
        // Given
        let expectedWords = TestFixtures.createMultipleWords()
        mockRepository.wordsToReturn = expectedWords
        
        let expectation = self.expectation(description: "Words returned")
        var receivedResult: Result<[Word], Error>?
        
        // When
        sut.execute { result in
            receivedResult = result
            expectation.fulfill()
        }
        
        // Then
        waitForExpectations(timeout: 1.0)
        
        guard case .success(let words) = receivedResult else {
            XCTFail("Expected success, got failure")
            return
        }
        
        XCTAssertEqual(words.count, expectedWords.count)
        XCTAssertEqual(words.first?.term, expectedWords.first?.term)
    }
    
    func test_execute_whenRepositoryReturnsEmptyArray_completesWithEmptyArray() {
        // Given
        mockRepository.wordsToReturn = []
        
        let expectation = self.expectation(description: "Empty array returned")
        var receivedResult: Result<[Word], Error>?
        
        // When
        sut.execute { result in
            receivedResult = result
            expectation.fulfill()
        }
        
        // Then
        waitForExpectations(timeout: 1.0)
        
        guard case .success(let words) = receivedResult else {
            XCTFail("Expected success, got failure")
            return
        }
        
        XCTAssertTrue(words.isEmpty)
    }
    
    // MARK: - Failure Tests
    
    func test_execute_whenRepositoryFails_completesWithError() {
        // Given
        mockRepository.errorToThrow = TestError.mockError
        
        let expectation = self.expectation(description: "Error returned")
        var receivedResult: Result<[Word], Error>?
        
        // When
        sut.execute { result in
            receivedResult = result
            expectation.fulfill()
        }
        
        // Then
        waitForExpectations(timeout: 1.0)
        
        guard case .failure(let error) = receivedResult else {
            XCTFail("Expected failure, got success")
            return
        }
        
        XCTAssertTrue(error is TestError)
    }
    
    // MARK: - Multiple Calls Tests
    
    func test_execute_canBeCalledMultipleTimes() {
        // Given
        mockRepository.wordsToReturn = TestFixtures.createMultipleWords()
        
        // When
        sut.execute { _ in }
        sut.execute { _ in }
        sut.execute { _ in }
        
        // Then
        XCTAssertEqual(mockRepository.getWordsCallCount, 3)
    }
}
