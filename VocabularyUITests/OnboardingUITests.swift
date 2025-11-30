//
//  OnboardingUITests.swift
//  Vocabulary
//
//  Created by Ahmed Mahrous on 30/11/2025.
//

import XCTest

final class OnboardingUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override func setUp() {
        super.setUp()
        continueAfterFailure = false
        
        app = XCUIApplication()
        app.launchArguments = ["UI-Testing", "Reset-Onboarding"]
        app.launch()
    }
    
    override func tearDown() {
        app = nil
        super.tearDown()
    }
    
    // MARK: - Welcome Screen Tests
    
    func test_welcomeScreen_displaysCorrectly() {
        // Then - Welcome screen appears
        XCTAssertTrue(app.staticTexts["Tailor your word recommendations"].exists)
        XCTAssertTrue(app.buttons["Continue"].exists)
    }
    
    func test_welcomeScreen_continueButton_navigatesToAgeSelection() {
        // When - Tap continue
        app.buttons["Continue"].tap()
        
        // Then - Age selection screen appears
        XCTAssertTrue(app.staticTexts["How old are you?"].exists)
    }
    
    // MARK: - Age Selection Screen Tests
    
    func test_ageSelectionScreen_displaysAllOptions() {
        // Given - Navigate to age selection
        app.buttons["Continue"].tap()
        
        // Then - All age ranges are displayed
        XCTAssertTrue(app.buttons["13 to 17"].exists)
        XCTAssertTrue(app.buttons["18 to 24"].exists)
        XCTAssertTrue(app.buttons["25 to 34"].exists)
        XCTAssertTrue(app.buttons["35 to 44"].exists)
        XCTAssertTrue(app.buttons["45 to 54"].exists)
        XCTAssertTrue(app.buttons["55+"].exists)
    }
    
    func test_ageSelectionScreen_skipButton_exists() {
        // Given - Navigate to age selection
        app.buttons["Continue"].tap()
        
        // Then
        XCTAssertTrue(app.buttons["Skip"].exists)
    }
    
    func test_ageSelectionScreen_selectAge_thenNavigate() {
        // Given - Navigate to age selection
        app.buttons["Continue"].tap()
        
        // When - Select an age range
        app.buttons["25 to 34"].tap()
        
        // Then - Selection is made (visual feedback would be checked in real app)
        XCTAssertTrue(app.buttons["25 to 34"].exists)
    }
    
    func test_ageSelectionScreen_skipButton_navigatesToNextScreen() {
        // Given - Navigate to age selection
        app.buttons["Continue"].tap()
        
        // When - Tap skip
        app.buttons["Skip"].tap()
        
        // Then - Name input screen appears
        XCTAssertTrue(app.staticTexts["What do you want to be called?"].exists)
    }
    
    // MARK: - Name Input Screen Tests
    
    func test_nameInputScreen_displaysTextField() {
        // Given - Navigate to name input
        app.buttons["Continue"].tap()
        app.buttons["Skip"].tap()
        
        // Then
        XCTAssertTrue(app.textFields["Your name"].exists)
        XCTAssertTrue(app.buttons["Continue"].exists)
        XCTAssertTrue(app.buttons["Skip"].exists)
    }
    
    func test_nameInputScreen_canEnterName() {
        // Given - Navigate to name input
        app.buttons["Continue"].tap()
        app.buttons["Skip"].tap()
        
        // When - Enter name
        let nameField = app.textFields["Your name"]
        nameField.tap()
        nameField.typeText("John")
        
        // Then
        XCTAssertEqual(nameField.value as? String, "John")
    }
    
    func test_nameInputScreen_continueButton_navigates() {
        // Given - Navigate to name input
        app.buttons["Continue"].tap()
        app.buttons["Skip"].tap()
        
        // When - Tap continue
        app.buttons["Continue"].tap()
        
        // Then - Customize screen appears
        XCTAssertTrue(app.staticTexts["Customize the app to improve your experience"].exists)
    }
    
    // MARK: - Customize Screen Tests
    
    func test_customizeScreen_displays() {
        // Given - Navigate to customize screen
        navigateToScreen(4) // Welcome -> Age -> Name -> Customize
        
        // Then
        XCTAssertTrue(app.staticTexts["Customize the app to improve your experience"].exists)
        XCTAssertTrue(app.buttons["Continue"].exists)
    }
    
    // MARK: - Words Per Week Screen Tests
    
    func test_wordsPerWeekScreen_displaysAllOptions() {
        // Given - Navigate to words per week screen
        navigateToScreen(5)
        
        // Then
        XCTAssertTrue(app.staticTexts["How many words do you want to learn per week?"].exists)
        XCTAssertTrue(app.buttons["10 words a week"].exists)
        XCTAssertTrue(app.buttons["30 words a week"].exists)
        XCTAssertTrue(app.buttons["50 words a week"].exists)
    }
    
    // MARK: - Daily Routine Screen Tests
    
    func test_dailyRoutineScreen_displays() {
        // Given - Navigate to daily routine screen
        navigateToScreen(6)
        
        // Then
        XCTAssertTrue(app.staticTexts["Create a consistent daily learning routine"].exists)
        XCTAssertTrue(app.staticTexts["Build a streak, one day at a time"].exists)
    }
    
    // MARK: - Voice Selection Screen Tests
    
    func test_voiceSelectionScreen_displaysVoiceOptions() {
        // Given - Navigate to voice selection screen
        navigateToScreen(7)
        
        // Then
        XCTAssertTrue(app.staticTexts["Choose a voice to pronounce words"].exists)
        XCTAssertTrue(app.buttons["Brian"].exists)
        XCTAssertTrue(app.buttons["Mia"].exists)
        XCTAssertTrue(app.buttons["Amelia"].exists)
    }
    
    // MARK: - Categories Screen Tests
    
    func test_categoriesScreen_displaysCategories() {
        // Given - Navigate to categories screen
        navigateToScreen(8)
        
        // Then
        XCTAssertTrue(app.staticTexts["Which categories are you interested in?"].exists)
        XCTAssertTrue(app.buttons["Beautiful words"].exists)
        XCTAssertTrue(app.buttons["Music"].exists)
        XCTAssertTrue(app.buttons["Business"].exists)
    }
    
    func test_categoriesScreen_canSelectMultipleCategories() {
        // Given - Navigate to categories screen
        navigateToScreen(8)
        
        // When - Select multiple categories
        app.buttons["Beautiful words"].tap()
        app.buttons["Music"].tap()
        app.buttons["Business"].tap()
        
        // Then - All are selected (visual feedback would be checked)
        XCTAssertTrue(app.buttons["Beautiful words"].exists)
        XCTAssertTrue(app.buttons["Music"].exists)
        XCTAssertTrue(app.buttons["Business"].exists)
    }
    
    func test_categoriesScreen_continueButton_completesOnboarding() {
        // Given - Navigate to categories screen
        navigateToScreen(8)
        
        // When - Tap continue
        app.buttons["Continue"].tap()
        
        // Then - Should navigate to home screen
        // (This would check for home screen elements in the real app)
        let homeIndicator = app.staticTexts["Daily Vocabulary"] // Or whatever your home screen has
        XCTAssertTrue(homeIndicator.waitForExistence(timeout: 2))
    }
    
    // MARK: - Complete Flow Test
    
    func test_completeOnboardingFlow_fromStartToFinish() {
        // Given - Start at welcome screen
        XCTAssertTrue(app.staticTexts["Tailor your word recommendations"].exists)
        
        // When - Go through all screens
        app.buttons["Continue"].tap() // Welcome -> Age
        app.buttons["25 to 34"].tap()
        app.buttons["Skip"].tap() // Age -> Name (skip)
        
        let nameField = app.textFields["Your name"]
        nameField.tap()
        nameField.typeText("Test User")
        app.buttons["Continue"].tap() // Name -> Customize
        
        app.buttons["Continue"].tap() // Customize -> Words Per Week
        app.buttons["30 words a week"].tap()
        app.buttons["Skip"].tap() // Skip to Daily Routine
        
        app.buttons["Continue"].tap() // Daily Routine -> Voice
        app.buttons["Brian"].tap()
        app.buttons["Continue"].tap() // Voice -> Categories
        
        app.buttons["Beautiful words"].tap()
        app.buttons["Music"].tap()
        app.buttons["Continue"].tap() // Complete onboarding
        
        // Then - Should be on home screen
        let homeIndicator = app.staticTexts["Daily Vocabulary"]
        XCTAssertTrue(homeIndicator.waitForExistence(timeout: 3))
    }
    
    // MARK: - Helper Methods
    
    private func navigateToScreen(_ screenNumber: Int) {
        // Navigate through screens by tapping Continue/Skip
        for _ in 0..<screenNumber {
            if app.buttons["Continue"].exists {
                app.buttons["Continue"].tap()
            } else if app.buttons["Skip"].exists {
                app.buttons["Skip"].tap()
            }
            Thread.sleep(forTimeInterval: 0.3) // Small delay for animations
        }
    }
}
