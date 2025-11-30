//
//  CheckOnboardingStatusUseCaseTests.swift
//  Vocabulary
//
//  Created by Ahmed Mahrous on 30/11/2025.
//

import XCTest
@testable import Vocabulary

final class CheckOnboardingStatusUseCaseTests: XCTestCase {
    
    var sut: CheckOnboardingStatusUseCase!
    var mockRepository: MockOnboardingRepository!
    
    override func setUp() {
        super.setUp()
        mockRepository = MockOnboardingRepository()
        sut = CheckOnboardingStatusUseCase(repository: mockRepository)
    }
    
    override func tearDown() {
        sut = nil
        mockRepository = nil
        super.tearDown()
    }
    
    // MARK: - Execute Tests
    
    func test_execute_callsRepositoryIsOnboardingCompleted() {
        // Given
        mockRepository.isCompletedToReturn = false
        
        // When
        let result = sut.execute()
        
        // Then
        XCTAssertTrue(mockRepository.isOnboardingCompletedCalled)
        XCTAssertFalse(result)
    }
    
    func test_execute_whenOnboardingNotCompleted_returnsFalse() {
        // Given
        mockRepository.isCompletedToReturn = false
        
        // When
        let result = sut.execute()
        
        // Then
        XCTAssertFalse(result)
    }
    
    func test_execute_whenOnboardingCompleted_returnsTrue() {
        // Given
        mockRepository.isCompletedToReturn = true
        
        // When
        let result = sut.execute()
        
        // Then
        XCTAssertTrue(result)
    }
    
    // MARK: - Complete Onboarding Tests
    
    func test_completeOnboarding_callsRepositoryMarkOnboardingCompleted() {
        // When
        sut.completeOnboarding()
        
        // Then
        XCTAssertTrue(mockRepository.markOnboardingCompletedCalled)
        XCTAssertEqual(mockRepository.markOnboardingCompletedCallCount, 1)
    }
    
    func test_completeOnboarding_canBeCalledMultipleTimes() {
        // When
        sut.completeOnboarding()
        sut.completeOnboarding()
        sut.completeOnboarding()
        
        // Then
        XCTAssertEqual(mockRepository.markOnboardingCompletedCallCount, 3)
    }
    
    // MARK: - Get Onboarding Steps Tests
    
    func test_getOnboardingSteps_callsRepositoryGetOnboardingSteps() {
        // Given
        let expectedSteps = TestFixtures.createMultipleOnboardingSteps()
        mockRepository.stepsToReturn = expectedSteps
        
        // When
        let steps = sut.getOnboardingSteps()
        
        // Then
        XCTAssertTrue(mockRepository.getOnboardingStepsCalled)
        XCTAssertEqual(steps.count, expectedSteps.count)
    }
    
    func test_getOnboardingSteps_returnsCorrectSteps() {
        // Given
        let expectedSteps = TestFixtures.createMultipleOnboardingSteps(count: 8)
        mockRepository.stepsToReturn = expectedSteps
        
        // When
        let steps = sut.getOnboardingSteps()
        
        // Then
        XCTAssertEqual(steps.count, 8)
        XCTAssertEqual(steps.first?.order, 0)
        XCTAssertEqual(steps.last?.order, 7)
    }
    
    func test_getOnboardingSteps_whenEmpty_returnsEmptyArray() {
        // Given
        mockRepository.stepsToReturn = []
        
        // When
        let steps = sut.getOnboardingSteps()
        
        // Then
        XCTAssertTrue(steps.isEmpty)
    }
    
    // MARK: - Integration Flow Tests
    
    func test_completeOnboarding_thenCheckStatus_reflectsCompletion() {
        // This tests the expected flow
        
        // Given - Initially not completed
        mockRepository.isCompletedToReturn = false
        
        // When - Check status before completion
        let statusBefore = sut.execute()
        
        // Then
        XCTAssertFalse(statusBefore)
        
        // When - Complete onboarding
        sut.completeOnboarding()
        
        // Given - Now completed
        mockRepository.isCompletedToReturn = true
        
        // When - Check status after completion
        let statusAfter = sut.execute()
        
        // Then
        XCTAssertTrue(statusAfter)
        XCTAssertTrue(mockRepository.markOnboardingCompletedCalled)
    }
}
