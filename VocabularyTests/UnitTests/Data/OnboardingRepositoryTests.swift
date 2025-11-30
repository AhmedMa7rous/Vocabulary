//
//  OnboardingRepositoryTests.swift
//  Vocabulary
//
//  Created by Ahmed Mahrous on 30/11/2025.
//

import XCTest
@testable import Vocabulary

final class OnboardingRepositoryTests: XCTestCase {
    
    var sut: OnboardingRepository!
    var userDefaultsDataSource: UserDefaultsDataSource!
    var mockUserDefaults: UserDefaults!
    
    override func setUp() {
        super.setUp()
        // Use in-memory UserDefaults for testing
        mockUserDefaults = UserDefaults(suiteName: "TestOnboardingDefaults")
        mockUserDefaults.removePersistentDomain(forName: "TestOnboardingDefaults")
        
        userDefaultsDataSource = UserDefaultsDataSource(userDefaults: mockUserDefaults)
        sut = OnboardingRepository(userDefaultsDataSource: userDefaultsDataSource)
    }
    
    override func tearDown() {
        mockUserDefaults.removePersistentDomain(forName: "TestOnboardingDefaults")
        sut = nil
        userDefaultsDataSource = nil
        mockUserDefaults = nil
        super.tearDown()
    }
    
    // MARK: - Get Onboarding Steps Tests
    
    func test_getOnboardingSteps_returnsEightSteps() {
        // When
        let steps = sut.getOnboardingSteps()
        
        // Then
        XCTAssertEqual(steps.count, 8)
    }
    
    func test_getOnboardingSteps_stepsAreInCorrectOrder() {
        // When
        let steps = sut.getOnboardingSteps()
        
        // Then
        for (index, step) in steps.enumerated() {
            XCTAssertEqual(step.order, index)
        }
    }
    
    func test_getOnboardingSteps_hasAllTypes() {
        // When
        let steps = sut.getOnboardingSteps()
        
        // Then
        let types = steps.map { $0.type }
        XCTAssertTrue(types.contains(.welcome))
        XCTAssertTrue(types.contains(.ageSelection))
        XCTAssertTrue(types.contains(.nameInput))
        XCTAssertTrue(types.contains(.customize))
        XCTAssertTrue(types.contains(.wordsPerWeek))
        XCTAssertTrue(types.contains(.dailyRoutine))
        XCTAssertTrue(types.contains(.voiceSelection))
        XCTAssertTrue(types.contains(.categories))
    }
    
    func test_getOnboardingSteps_firstStepIsWelcome() {
        // When
        let steps = sut.getOnboardingSteps()
        
        // Then
        XCTAssertEqual(steps.first?.type, .welcome)
        XCTAssertEqual(steps.first?.order, 0)
    }
    
    func test_getOnboardingSteps_lastStepIsCategories() {
        // When
        let steps = sut.getOnboardingSteps()
        
        // Then
        XCTAssertEqual(steps.last?.type, .categories)
        XCTAssertEqual(steps.last?.order, 7)
    }
    
    func test_getOnboardingSteps_allStepsHaveTitles() {
        // When
        let steps = sut.getOnboardingSteps()
        
        // Then
        for step in steps {
            XCTAssertFalse(step.title.isEmpty, "Step \(step.order) should have a title")
        }
    }
    
    // MARK: - Is Onboarding Completed Tests
    
    func test_isOnboardingCompleted_initiallyFalse() {
        // When
        let isCompleted = sut.isOnboardingCompleted()
        
        // Then
        XCTAssertFalse(isCompleted)
    }
    
    func test_isOnboardingCompleted_afterMarking_returnsTrue() {
        // Given
        sut.markOnboardingCompleted()
        
        // When
        let isCompleted = sut.isOnboardingCompleted()
        
        // Then
        XCTAssertTrue(isCompleted)
    }
    
    // MARK: - Mark Onboarding Completed Tests
    
    func test_markOnboardingCompleted_persistsState() {
        // When
        sut.markOnboardingCompleted()
        
        // Then
        XCTAssertTrue(sut.isOnboardingCompleted())
    }
    
    func test_markOnboardingCompleted_canBeCalledMultipleTimes() {
        // When
        sut.markOnboardingCompleted()
        sut.markOnboardingCompleted()
        sut.markOnboardingCompleted()
        
        // Then
        XCTAssertTrue(sut.isOnboardingCompleted())
    }
    
    // MARK: - Persistence Tests
    
    func test_onboardingState_persistsAcrossInstances() {
        // Given
        sut.markOnboardingCompleted()
        
        // When - Create new instance with same data source
        let newRepository = OnboardingRepository(userDefaultsDataSource: userDefaultsDataSource)
        
        // Then
        XCTAssertTrue(newRepository.isOnboardingCompleted())
    }
    
    // MARK: - Integration Flow Tests
    
    func test_completeFlow_checkStatus_complete_checkAgain() {
        // Given - Initially not completed
        XCTAssertFalse(sut.isOnboardingCompleted())
        
        // When - Get steps (user goes through onboarding)
        let steps = sut.getOnboardingSteps()
        XCTAssertEqual(steps.count, 8)
        
        // When - Mark as completed
        sut.markOnboardingCompleted()
        
        // Then - Now completed
        XCTAssertTrue(sut.isOnboardingCompleted())
        
        // And - Still completed on subsequent checks
        XCTAssertTrue(sut.isOnboardingCompleted())
        XCTAssertTrue(sut.isOnboardingCompleted())
    }
}
