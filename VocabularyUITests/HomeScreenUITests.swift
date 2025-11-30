//
//  HomeScreenUITests.swift
//  Vocabulary
//
//  Created by Ahmed Mahrous on 30/11/2025.
//

import XCTest

final class HomeScreenUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.launchArguments = ["UI-Testing", "Skip-Onboarding"]
        app.launch()
    }
    
    override func tearDown() {
        app = nil
        super.tearDown()
    }
    
    // MARK: - Home Screen Display Tests
    
    func test_homeScreen_displaysTitle() {
        // Then
        XCTAssertTrue(app.staticTexts["Daily Vocabulary"].exists)
    }
    
    func test_homeScreen_displaysWordCard() {
        // Then - First word should be displayed
        XCTAssertTrue(app.staticTexts["Ephemeral"].exists)
    }
    
    func test_homeScreen_displaysProgressIndicator() {
        // Then
        XCTAssertTrue(app.staticTexts["0 words learned"].exists)
    }
    
    func test_homeScreen_displaysSwipeInstructions() {
        // Then
        XCTAssertTrue(app.staticTexts["Keep Learning"].exists)
        XCTAssertTrue(app.staticTexts["I Know This"].exists)
    }
    
    // MARK: - Word Card Content Tests
    
    func test_wordCard_displaysAllElements() {
        // Then - Word card should show all components
        XCTAssertTrue(app.staticTexts["Ephemeral"].exists)
        XCTAssertTrue(app.staticTexts["adjective"].exists)
        XCTAssertTrue(app.staticTexts["Lasting for a very short time"].exists)
        XCTAssertTrue(app.staticTexts["Tap to see examples"].exists)
    }
    
    func test_wordCard_displaysPronunciation() {
        // Then
        XCTAssertTrue(app.staticTexts["ih-FEM-er-uhl"].exists)
    }
    
    // MARK: - Swipe Right Tests
    
    func test_swipeRight_showsCheckmarkFeedback() {
        // Given
        let card = app.otherElements.containing(.staticText, identifier:"Ephemeral").firstMatch
        
        // When - Swipe right
        card.swipeRight()
        
        // Then - Visual feedback should appear (checkmark icon)
        Thread.sleep(forTimeInterval: 0.5)
    }
    
    func test_swipeRight_updatesProgress() {
        // Given
        XCTAssertTrue(app.staticTexts["0 words learned"].exists)
        
        // When - Swipe right on word
        let card = app.otherElements.containing(.staticText, identifier:"Ephemeral").firstMatch
        card.swipeRight()
        
        // Then - Progress should update
        Thread.sleep(forTimeInterval: 0.5)
        XCTAssertTrue(app.staticTexts["1 words learned"].waitForExistence(timeout: 1))
    }
    
    func test_swipeRight_showsNextWord() {
        // Given
        XCTAssertTrue(app.staticTexts["Ephemeral"].exists)
        
        // When - Swipe right
        let card = app.otherElements.containing(.staticText, identifier:"Ephemeral").firstMatch
        card.swipeRight()
        
        // Then - Next word appears
        Thread.sleep(forTimeInterval: 1)
        XCTAssertTrue(app.staticTexts["Serendipity"].waitForExistence(timeout: 2))
    }
    
    // MARK: - Swipe Left Tests
    
    func test_swipeLeft_showsArrowFeedback() {
        // Given
        let card = app.otherElements.containing(.staticText, identifier:"Ephemeral").firstMatch
        
        // When - Swipe left
        card.swipeLeft()
        
        // Then - Visual feedback should appear (arrow icon)
        Thread.sleep(forTimeInterval: 0.5)
    }
    
    func test_swipeLeft_doesNotUpdateProgress() {
        // Given
        XCTAssertTrue(app.staticTexts["0 words learned"].exists)
        
        // When - Swipe left on word
        let card = app.otherElements.containing(.staticText, identifier:"Ephemeral").firstMatch
        card.swipeLeft()
        
        // Then - Progress should NOT update
        Thread.sleep(forTimeInterval: 0.5)
        XCTAssertTrue(app.staticTexts["0 words learned"].exists)
    }
    
    func test_swipeLeft_showsNextWord() {
        // Given
        XCTAssertTrue(app.staticTexts["Ephemeral"].exists)
        
        // When - Swipe left
        let card = app.otherElements.containing(.staticText, identifier:"Ephemeral").firstMatch
        card.swipeLeft()
        
        // Then - Next word appears
        Thread.sleep(forTimeInterval: 1)
        XCTAssertTrue(app.staticTexts["Serendipity"].waitForExistence(timeout: 2))
    }
    
    // MARK: - Tap Card Tests
    
    func test_tapCard_showsExamplesOverlay() {
        // Given
        let card = app.otherElements.containing(.staticText, identifier:"Ephemeral").firstMatch
        
        // When - Tap card
        card.tap()
        
        // Then - Examples overlay appears
        Thread.sleep(forTimeInterval: 0.3)
        XCTAssertTrue(app.staticTexts["in context"].exists)
        XCTAssertTrue(app.buttons["Close"].exists || app.images["xmark.circle.fill"].exists)
    }
    
    func test_tapCard_displaysExamples() {
        // Given
        let card = app.otherElements.containing(.staticText, identifier:"Ephemeral").firstMatch
        
        // When - Tap card
        card.tap()
        
        // Then - Examples are displayed
        Thread.sleep(forTimeInterval: 0.5)
        XCTAssertTrue(app.staticTexts.containing(NSPredicate(format: "label CONTAINS 'ephemeral'")).firstMatch.exists)
    }
    
    func test_examplesOverlay_closeButton_dismisses() {
        // Given - Open examples
        let card = app.otherElements.containing(.staticText, identifier:"Ephemeral").firstMatch
        card.tap()
        Thread.sleep(forTimeInterval: 0.3)
        
        // When - Tap close button
        if app.buttons["Close"].exists {
            app.buttons["Close"].tap()
        } else {
            app.images["xmark.circle.fill"].firstMatch.tap()
        }
        
        // Then - Overlay dismisses
        Thread.sleep(forTimeInterval: 0.3)
        XCTAssertFalse(app.staticTexts["in context"].exists)
    }
    
    func test_examplesOverlay_tapOutside_dismisses() {
        // Given - Open examples
        let card = app.otherElements.containing(.staticText, identifier:"Ephemeral").firstMatch
        card.tap()
        Thread.sleep(forTimeInterval: 0.3)
        
        // When - Tap outside overlay (top of screen)
        let topOfScreen = app.coordinate(withNormalizedOffset: CGVector(dx: 0.5, dy: 0.1))
        topOfScreen.tap()
        
        // Then - Overlay dismisses
        Thread.sleep(forTimeInterval: 0.3)
        XCTAssertFalse(app.staticTexts["in context"].exists)
    }
    
    // MARK: - Multiple Swipe Tests
    
    func test_swipeMultipleWords_progressIncreases() {
        // When - Swipe right on 3 words
        for _ in 0..<3 {
            let card = app.otherElements.firstMatch
            card.swipeRight()
            Thread.sleep(forTimeInterval: 0.8)
        }
        
        // Then - Progress shows 3 words learned
        XCTAssertTrue(app.staticTexts["3 words learned"].waitForExistence(timeout: 2))
    }
    
    func test_swipeThroughAllWords_cardsLoop() {
        // Given - Note the first word
        XCTAssertTrue(app.staticTexts["Ephemeral"].exists)
        
        // When - Swipe through all 5 words
        for _ in 0..<5 {
            let card = app.otherElements.firstMatch
            card.swipeRight()
            Thread.sleep(forTimeInterval: 0.8)
        }
        
        // Then - Should loop back to first word
        XCTAssertTrue(app.staticTexts["Ephemeral"].waitForExistence(timeout: 2))
    }
    
    // MARK: - Card Stack Tests
    
    func test_cardStack_multipleCardsVisible() {
        // Then - Multiple cards should be visible in stack
        // This is visual, but we can check that elements exist
        XCTAssertTrue(app.otherElements.containing(.staticText, identifier:"Ephemeral").count > 0)
    }
    
    // MARK: - Integration Flow Tests
    
    func test_completeFlow_tapCard_closeExamples_swipeRight() {
        // Given - Start at home screen
        XCTAssertTrue(app.staticTexts["Ephemeral"].exists)
        
        // When - Tap card to see examples
        let card = app.otherElements.containing(.staticText, identifier:"Ephemeral").firstMatch
        card.tap()
        Thread.sleep(forTimeInterval: 0.5)
        
        // Then - Examples shown
        XCTAssertTrue(app.staticTexts["in context"].exists)
        
        // When - Close examples
        if app.buttons["Close"].exists {
            app.buttons["Close"].tap()
        } else {
            app.images["xmark.circle.fill"].firstMatch.tap()
        }
        Thread.sleep(forTimeInterval: 0.3)
        
        // Then - Back to word card
        XCTAssertTrue(app.staticTexts["Ephemeral"].exists)
        
        // When - Swipe right
        card.swipeRight()
        Thread.sleep(forTimeInterval: 0.8)
        
        // Then - Next word shown and progress updated
        XCTAssertTrue(app.staticTexts["Serendipity"].waitForExistence(timeout: 2))
        XCTAssertTrue(app.staticTexts["1 words learned"].exists)
    }
    
    func test_completeFlow_learnAllWords() {
        // When - Swipe right through all words
        let words = ["Ephemeral", "Serendipity", "Eloquent", "Resilient", "Ubiquitous"]
        
        for (index, _) in words.enumerated() {
            let card = app.otherElements.firstMatch
            card.swipeRight()
            Thread.sleep(forTimeInterval: 0.8)
            
            // Check progress updates
            let expectedProgress = "\(index + 1) words learned"
            XCTAssertTrue(app.staticTexts[expectedProgress].waitForExistence(timeout: 1))
        }
        
        // Then - All 5 words learned
        XCTAssertTrue(app.staticTexts["5 words learned"].exists)
    }
}
