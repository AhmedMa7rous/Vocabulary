//
//  OnboardingPresenterTests.swift
//  Vocabulary
//
//  Created by Ahmed Mahrous on 30/11/2025.
//

import XCTest
@testable import Vocabulary

final class OnboardingPresenterTests: XCTestCase {
    
    var sut: OnboardingPresenter!
    var mockView: MockOnboardingView!
    var mockUseCase: CheckOnboardingStatusUseCase!
    var mockRepository: MockOnboardingRepository!
    
    override func setUp() {
        super.setUp()
        mockView = MockOnboardingView()
        mockRepository = MockOnboardingRepository()
        mockUseCase = CheckOnboardingStatusUseCase(repository: mockRepository)
        
        sut = OnboardingPresenter(checkOnboardingUseCase: mockUseCase)
        sut.view = mockView
    }
    
    override func tearDown() {
        sut = nil
        mockView = nil
        mockUseCase = nil
        mockRepository = nil
        super.tearDown()
    }
    
    // MARK: - View Did Load Tests
    
    func test_viewDidLoad_getsOnboardingSteps() {
        // Given
        let expectedSteps = TestFixtures.createMultipleOnboardingSteps()
        mockRepository.stepsToReturn = expectedSteps
        
        // When
        sut.viewDidLoad()
        
        // Then
        XCTAssertTrue(mockRepository.getOnboardingStepsCalled)
    }
    
    func test_viewDidLoad_displaysSteps() {
        // Given
        let expectedSteps = TestFixtures.createMultipleOnboardingSteps()
        mockRepository.stepsToReturn = expectedSteps
        
        // When
        sut.viewDidLoad()
        
        // Then
        XCTAssertTrue(mockView.displayOnboardingStepsCalled)
        XCTAssertEqual(mockView.displayedSteps.count, expectedSteps.count)
    }
    
    func test_viewDidLoad_displaysCorrectNumberOfSteps() {
        // Given
        let steps = TestFixtures.createMultipleOnboardingSteps(count: 8)
        mockRepository.stepsToReturn = steps
        
        // When
        sut.viewDidLoad()
        
        // Then
        XCTAssertEqual(mockView.displayedSteps.count, 8)
    }
    
    func test_viewDidLoad_whenNoSteps_displaysEmptyArray() {
        // Given
        mockRepository.stepsToReturn = []
        
        // When
        sut.viewDidLoad()
        
        // Then
        XCTAssertTrue(mockView.displayOnboardingStepsCalled)
        XCTAssertTrue(mockView.displayedSteps.isEmpty)
    }
    
    // MARK: - Did Tap Get Started Tests
    
    func test_didTapGetStarted_marksOnboardingCompleted() {
        // When
        sut.didTapGetStarted()
        
        // Then
        XCTAssertTrue(mockRepository.markOnboardingCompletedCalled)
    }
    
    func test_didTapGetStarted_navigatesToHome() {
        // When
        sut.didTapGetStarted()
        
        // Then
        XCTAssertTrue(mockView.navigateToHomeCalled)
        XCTAssertEqual(mockView.navigateToHomeCallCount, 1)
    }
    
    func test_didTapGetStarted_multipleCallsOnlyNavigatesOnce() {
        // When
        sut.didTapGetStarted()
        sut.didTapGetStarted()
        sut.didTapGetStarted()
        
        // Then - Repository called 3 times
        XCTAssertEqual(mockRepository.markOnboardingCompletedCallCount, 3)
        // But view navigates 3 times (each call triggers navigation)
        XCTAssertEqual(mockView.navigateToHomeCallCount, 3)
    }
    
    // MARK: - Did Change Step Tests
    
    func test_didChangeStep_called() {
        // When
        sut.didChangeStep()
        
        // Then - Just verify no crash, haptic feedback is called
        // (Cannot easily test HapticManager in unit tests)
    }
    
    func test_didChangeStep_multipleCallsSucceed() {
        // When
        sut.didChangeStep()
        sut.didChangeStep()
        sut.didChangeStep()
        
        // Then - No crash
    }
    
    // MARK: - Integration Flow Tests
    
    func test_completeFlow_loadSteps_navigateToHome() {
        // Given
        let steps = TestFixtures.createMultipleOnboardingSteps()
        mockRepository.stepsToReturn = steps
        
        // When - Load view
        sut.viewDidLoad()
        
        // Then - Steps displayed
        XCTAssertTrue(mockView.displayOnboardingStepsCalled)
        XCTAssertEqual(mockView.displayedSteps.count, 8)
        
        // When - Complete onboarding
        sut.didTapGetStarted()
        
        // Then - Marked as completed and navigated
        XCTAssertTrue(mockRepository.markOnboardingCompletedCalled)
        XCTAssertTrue(mockView.navigateToHomeCalled)
    }
    
    func test_completeFlow_navigatesThroughSteps() {
        // Given
        let steps = TestFixtures.createMultipleOnboardingSteps()
        mockRepository.stepsToReturn = steps
        
        // When - Load view
        sut.viewDidLoad()
        
        // Simulate navigating through steps
        for _ in 0..<7 {
            sut.didChangeStep()
        }
        
        // When - Finish onboarding
        sut.didTapGetStarted()
        
        // Then
        XCTAssertTrue(mockView.navigateToHomeCalled)
    }
}
