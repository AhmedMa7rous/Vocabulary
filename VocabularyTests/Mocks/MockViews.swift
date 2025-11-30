//
//  MockViews.swift
//  Vocabulary
//
//  Created by Ahmed Mahrous on 30/11/2025.
//

import Foundation
@testable import Vocabulary

// MARK: - Mock Home View

final class MockHomeView: HomeViewProtocol {
    var displayLoadingCalled = false
    var displayLoadingCallCount = 0
    
    var displayWordsCalled = false
    var displayedWords: [Word] = []
    
    var displayErrorCalled = false
    var displayedError: String?
    
    var updateProgressCalled = false
    var progressLearnedCount = 0
    var progressTotalCount = 0
    
    var showWordExamplesCalled = false
    var shownExamples: [WordExample] = []
    var shownWord: Word?
    
    var hideWordExamplesCalled = false
    
    var removeTopCardCalled = false
    var removeTopCardCallCount = 0
    
    func displayLoading() {
        displayLoadingCalled = true
        displayLoadingCallCount += 1
    }
    
    func displayWords(_ words: [Word]) {
        displayWordsCalled = true
        displayedWords = words
    }
    
    func displayError(_ message: String) {
        displayErrorCalled = true
        displayedError = message
    }
    
    func updateProgress(learned: Int, total: Int) {
        updateProgressCalled = true
        progressLearnedCount = learned
        progressTotalCount = total
    }
    
    func showWordExamples(_ examples: [WordExample], for word: Word) {
        showWordExamplesCalled = true
        shownExamples = examples
        shownWord = word
    }
    
    func hideWordExamples() {
        hideWordExamplesCalled = true
    }
    
    func removeTopCard() {
        removeTopCardCalled = true
        removeTopCardCallCount += 1
    }
}

// MARK: - Mock Onboarding View

final class MockOnboardingView: OnboardingViewProtocol {
    var displayOnboardingStepsCalled = false
    var displayedSteps: [OnboardingStep] = []
    
    var navigateToHomeCalled = false
    var navigateToHomeCallCount = 0
    
    func displayOnboardingSteps(_ steps: [OnboardingStep]) {
        displayOnboardingStepsCalled = true
        displayedSteps = steps
    }
    
    func navigateToHome() {
        navigateToHomeCalled = true
        navigateToHomeCallCount += 1
    }
}
