//
//  OnboardingStepEntityTests.swift
//  Vocabulary
//
//  Created by Ahmed Mahrous on 30/11/2025.
//

import XCTest
@testable import Vocabulary

final class OnboardingStepEntityTests: XCTestCase {
    
    // MARK: - Initialization Tests
    
    func test_onboardingStep_initializesWithAllProperties() {
        // Given
        let id = UUID()
        let type = OnboardingStepType.welcome
        let title = "Welcome"
        let subtitle = "Get started"
        let imageName = "welcome"
        let order = 0
        
        // When
        let step = OnboardingStep(
            id: id,
            type: type,
            title: title,
            subtitle: subtitle,
            imageName: imageName,
            order: order
        )
        
        // Then
        XCTAssertEqual(step.id, id)
        XCTAssertEqual(step.type, type)
        XCTAssertEqual(step.title, title)
        XCTAssertEqual(step.subtitle, subtitle)
        XCTAssertEqual(step.imageName, imageName)
        XCTAssertEqual(step.order, order)
    }
    
    func test_onboardingStep_canBeCreatedWithNilOptionals() {
        // When
        let step = OnboardingStep(
            type: .welcome,
            title: "Welcome",
            subtitle: nil,
            imageName: nil,
            order: 0
        )
        
        // Then
        XCTAssertNil(step.subtitle)
        XCTAssertNil(step.imageName)
    }
    
    // MARK: - OnboardingStepType Tests
    
    func test_onboardingStepType_hasAllCases() {
        // Given
        let types: [OnboardingStepType] = [
            .welcome,
            .ageSelection,
            .nameInput,
            .customize,
            .wordsPerWeek,
            .dailyRoutine,
            .voiceSelection,
            .categories
        ]
        
        // Then - Just verify they all exist
        XCTAssertEqual(types.count, 8)
    }
    
    // MARK: - Identifiable Tests
    
    func test_onboardingStep_hasUniqueId() {
        // Given
        let step1 = TestFixtures.createTestOnboardingStep()
        let step2 = TestFixtures.createTestOnboardingStep()
        
        // Then
        XCTAssertNotEqual(step1.id, step2.id)
    }
    
    // MARK: - Equatable Tests
    
    func test_onboardingStep_equality_sameValues() {
        // Given
        let id = UUID()
        
        let step1 = OnboardingStep(
            id: id,
            type: .welcome,
            title: "Welcome",
            subtitle: "Sub",
            imageName: "img",
            order: 0
        )
        
        let step2 = OnboardingStep(
            id: id,
            type: .welcome,
            title: "Welcome",
            subtitle: "Sub",
            imageName: "img",
            order: 0
        )
        
        // Then
        XCTAssertEqual(step1, step2)
    }
    
    func test_onboardingStep_equality_differentIds() {
        // Given
        let step1 = TestFixtures.createTestOnboardingStep()
        let step2 = TestFixtures.createTestOnboardingStep()
        
        // Then
        XCTAssertNotEqual(step1, step2)
    }
    
    func test_onboardingStep_equality_differentTypes() {
        // Given
        let id = UUID()
        
        let step1 = OnboardingStep(
            id: id,
            type: .welcome,
            title: "Title",
            order: 0
        )
        
        let step2 = OnboardingStep(
            id: id,
            type: .ageSelection,
            title: "Title",
            order: 0
        )
        
        // Then
        XCTAssertNotEqual(step1, step2)
    }
    
    // MARK: - Ordering Tests
    
    func test_onboardingSteps_canBeSortedByOrder() {
        // Given
        let steps = [
            OnboardingStep(type: .categories, title: "C", order: 7),
            OnboardingStep(type: .welcome, title: "A", order: 0),
            OnboardingStep(type: .customize, title: "B", order: 3)
        ]
        
        // When
        let sorted = steps.sorted { $0.order < $1.order }
        
        // Then
        XCTAssertEqual(sorted[0].order, 0)
        XCTAssertEqual(sorted[1].order, 3)
        XCTAssertEqual(sorted[2].order, 7)
    }
}
