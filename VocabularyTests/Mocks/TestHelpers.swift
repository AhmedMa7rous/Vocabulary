//
//  TestHelpers.swift
//  Vocabulary
//
//  Created by Ahmed Mahrous on 30/11/2025.
//

import Foundation
@testable import Vocabulary

// MARK: - Test Fixtures

struct TestFixtures {
    
    // MARK: - Word Fixtures
    
    static func createTestWord(
        id: UUID = UUID(),
        term: String = "Ephemeral",
        pronunciation: String? = "ih-FEM-er-uhl",
        partOfSpeech: String = "adjective",
        definition: String = "Lasting for a very short time.",
        examples: [WordExample] = [],
        synonyms: [String] = ["transient"],
        antonyms: [String] = ["permanent"]
    ) -> Word {
        let wordExamples = examples.isEmpty ? [createTestWordExample()] : examples
        return Word(
            id: id,
            term: term,
            pronunciation: pronunciation,
            partOfSpeech: partOfSpeech,
            definition: definition,
            examples: wordExamples,
            synonyms: synonyms,
            antonyms: antonyms
        )
    }
    
    static func createTestWordExample(
        id: UUID = UUID(),
        sentence: String = "The ephemeral beauty of cherry blossoms.",
        highlightedWord: String = "ephemeral"
    ) -> WordExample {
        return WordExample(
            id: id,
            sentence: sentence,
            highlightedWord: highlightedWord
        )
    }
    
    static func createMultipleWords(count: Int = 5) -> [Word] {
        let terms = ["Ephemeral", "Serendipity", "Eloquent", "Resilient", "Ubiquitous"]
        return terms.prefix(count).enumerated().map { index, term in
            createTestWord(term: term)
        }
    }
    
    // MARK: - Onboarding Fixtures
    
    static func createTestOnboardingStep(
        id: UUID = UUID(),
        type: OnboardingStepType = .welcome,
        title: String = "Welcome",
        subtitle: String? = nil,
        imageName: String? = nil,
        order: Int = 0
    ) -> OnboardingStep {
        return OnboardingStep(
            id: id,
            type: type,
            title: title,
            subtitle: subtitle,
            imageName: imageName,
            order: order
        )
    }
    
    static func createMultipleOnboardingSteps(count: Int = 8) -> [OnboardingStep] {
        let types: [OnboardingStepType] = [
            .welcome, .ageSelection, .nameInput, .customize,
            .wordsPerWeek, .dailyRoutine, .voiceSelection, .categories
        ]
        return types.prefix(count).enumerated().map { index, type in
            createTestOnboardingStep(type: type, title: "Step \(index)", order: index)
        }
    }
}

// MARK: - XCTest Extensions

import XCTest

extension XCTestCase {
    
    // Wait for an async operation with timeout
    func waitForAsync(timeout: TimeInterval = 1.0, completion: @escaping () -> Void) {
        let expectation = self.expectation(description: "Async operation")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            completion()
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: timeout)
    }
    
    // Assert that two arrays contain the same elements (order-independent)
    func assertArraysEqual<T: Equatable>(_ array1: [T], _ array2: [T], file: StaticString = #file, line: UInt = #line) {
        XCTAssertEqual(array1.count, array2.count, "Arrays have different counts", file: file, line: line)
        for element in array1 {
            XCTAssertTrue(array2.contains(element), "Element \(element) not found in second array", file: file, line: line)
        }
    }
}
