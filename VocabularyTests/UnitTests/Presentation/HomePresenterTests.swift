//
//  HomePresenterTests.swift
//  Vocabulary
//
//  Created by Ahmed Mahrous on 30/11/2025.
//

import XCTest
@testable import Vocabulary

final class HomePresenterTests: XCTestCase {
    
    var sut: HomePresenter!
    var mockView: MockHomeView!
    var mockGetWordsUseCase: GetWordsUseCase!
    var mockMarkWordUseCase: MarkWordAsLearnedUseCase!
    var mockWordRepository: MockWordRepository!
    
    override func setUp() {
        super.setUp()
        mockView = MockHomeView()
        mockWordRepository = MockWordRepository()
        mockGetWordsUseCase = GetWordsUseCase(repository: mockWordRepository)
        mockMarkWordUseCase = MarkWordAsLearnedUseCase(repository: mockWordRepository)
        
        sut = HomePresenter(
            getWordsUseCase: mockGetWordsUseCase,
            markWordAsLearnedUseCase: mockMarkWordUseCase
        )
        sut.view = mockView
    }
    
    override func tearDown() {
        sut = nil
        mockView = nil
        mockGetWordsUseCase = nil
        mockMarkWordUseCase = nil
        mockWordRepository = nil
        super.tearDown()
    }
    
    // MARK: - View Did Load Tests
    
    func test_viewDidLoad_callsDisplayLoading() {
        // When
        sut.viewDidLoad()
        
        // Then
        XCTAssertTrue(mockView.displayLoadingCalled)
    }
    
    func test_viewDidLoad_fetchesWords() {
        // Given
        mockWordRepository.wordsToReturn = TestFixtures.createMultipleWords()
        
        // When
        sut.viewDidLoad()
        
        // Then
        waitForAsync {
            XCTAssertTrue(self.mockWordRepository.getWordsCalled)
        }
    }
    
    func test_viewDidLoad_whenWordsAvailable_displaysWords() {
        // Given
        let expectedWords = TestFixtures.createMultipleWords()
        mockWordRepository.wordsToReturn = expectedWords
        
        // When
        sut.viewDidLoad()
        
        // Then
        waitForAsync {
            XCTAssertTrue(self.mockView.displayWordsCalled)
            XCTAssertEqual(self.mockView.displayedWords.count, expectedWords.count)
            XCTAssertEqual(self.mockView.displayedWords.first?.term, "Ephemeral")
        }
    }
    
    func test_viewDidLoad_whenError_displaysError() {
        // Given
        mockWordRepository.errorToThrow = TestError.mockError
        
        // When
        sut.viewDidLoad()
        
        // Then
        waitForAsync {
            XCTAssertTrue(self.mockView.displayErrorCalled)
            XCTAssertNotNil(self.mockView.displayedError)
        }
    }
    
    // MARK: - Swipe Card Tests
    
    func test_didSwipeCard_right_marksWordAsLearned() {
        // Given
        let word = TestFixtures.createTestWord()
        
        // When
        sut.didSwipeCard(direction: .right, word: word)
        
        // Then
        XCTAssertTrue(mockWordRepository.markWordAsLearnedCalled)
        XCTAssertEqual(mockWordRepository.markedWordIds.first, word.id)
    }
    
    func test_didSwipeCard_right_updatesProgress() {
        // Given
        let word = TestFixtures.createTestWord()
        mockWordRepository.learnedCountToReturn = 1
        
        // When
        sut.didSwipeCard(direction: .right, word: word)
        
        // Then
        XCTAssertTrue(mockView.updateProgressCalled)
    }
    
    func test_didSwipeCard_left_doesNotMarkAsLearned() {
        // Given
        let word = TestFixtures.createTestWord()
        
        // When
        sut.didSwipeCard(direction: .left, word: word)
        
        // Then
        XCTAssertFalse(mockWordRepository.markWordAsLearnedCalled)
    }
    
    func test_didSwipeCard_removesTopCard() {
        // Given
        let word = TestFixtures.createTestWord()
        
        // When
        sut.didSwipeCard(direction: .right, word: word)
        
        // Then
        XCTAssertTrue(mockView.removeTopCardCalled)
    }
    
    // MARK: - Tap Card Tests
    
    func test_didTapCard_showsExamples() {
        // Given
        let word = TestFixtures.createTestWord()
        
        // When
        sut.didTapCard(word: word)
        
        // Then
        XCTAssertTrue(mockView.showWordExamplesCalled)
        XCTAssertEqual(mockView.shownWord?.id, word.id)
        XCTAssertEqual(mockView.shownExamples.count, word.examples.count)
    }
    
    func test_didTapCard_multipleWords_showsCorrectExamples() {
        // Given
        let word1 = TestFixtures.createTestWord(term: "First")
        let word2 = TestFixtures.createTestWord(term: "Second")
        
        // When
        sut.didTapCard(word: word1)
        
        // Then
        XCTAssertEqual(mockView.shownWord?.term, "First")
        
        // When
        sut.didTapCard(word: word2)
        
        // Then
        XCTAssertEqual(mockView.shownWord?.term, "Second")
    }
    
    // MARK: - Close Examples Tests
    
    func test_didTapCloseExamples_hidesExamples() {
        // When
        sut.didTapCloseExamples()
        
        // Then
        XCTAssertTrue(mockView.hideWordExamplesCalled)
    }
    
    // MARK: - Gesture Tests
    
    func test_didStartDragging_called() {
        // When
        sut.didStartDragging()
        
        // Then - Just verify no crash, haptic feedback is called
        // (Cannot easily test HapticManager in unit tests)
    }
    
    func test_didCancelSwipe_called() {
        // When
        sut.didCancelSwipe()
        
        // Then - Just verify no crash
    }
    
    // MARK: - Integration Flow Tests
    
    func test_completeFlow_loadWords_swipeRight_updatesProgress() {
        // Given
        let words = TestFixtures.createMultipleWords()
        mockWordRepository.wordsToReturn = words
        mockWordRepository.learnedCountToReturn = 1
        
        // When - Load words
        sut.viewDidLoad()
        
        waitForAsync {
            // Then - Words displayed
            XCTAssertTrue(self.mockView.displayWordsCalled)
            XCTAssertEqual(self.mockView.displayedWords.count, 5)
            
            // When - Swipe first word right
            self.sut.didSwipeCard(direction: .right, word: words[0])
            
            // Then - Word marked and progress updated
            XCTAssertTrue(self.mockWordRepository.markWordAsLearnedCalled)
            XCTAssertTrue(self.mockView.updateProgressCalled)
            XCTAssertTrue(self.mockView.removeTopCardCalled)
        }
    }
    
    func test_completeFlow_loadWords_tapCard_showExamples_close() {
        // Given
        let words = TestFixtures.createMultipleWords()
        mockWordRepository.wordsToReturn = words
        
        // When - Load words
        sut.viewDidLoad()
        
        waitForAsync {
            // When - Tap card
            self.sut.didTapCard(word: words[0])
            
            // Then - Examples shown
            XCTAssertTrue(self.mockView.showWordExamplesCalled)
            
            // When - Close examples
            self.sut.didTapCloseExamples()
            
            // Then - Examples hidden
            XCTAssertTrue(self.mockView.hideWordExamplesCalled)
        }
    }
}
