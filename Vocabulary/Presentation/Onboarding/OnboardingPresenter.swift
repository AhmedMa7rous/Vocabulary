//
//  OnboardingPresenter.swift
//  Vocabulary
//
//  Created by Ahmed Mahrous on 30/11/2025.
//

import Foundation

final class OnboardingPresenter {
    weak var view: OnboardingViewProtocol?
    private let checkOnboardingUseCase: CheckOnboardingStatusUseCase
    
    init(checkOnboardingUseCase: CheckOnboardingStatusUseCase) {
        self.checkOnboardingUseCase = checkOnboardingUseCase
    }
    
    func viewDidLoad() {
        let steps = checkOnboardingUseCase.getOnboardingSteps()
        view?.displayOnboardingSteps(steps)
    }
    
    func didTapGetStarted() {
        HapticManager.shared.success()
        checkOnboardingUseCase.completeOnboarding()
        view?.navigateToHome()
        
        // Post notification for navigation
        NotificationCenter.default.post(name: .onboardingCompleted, object: nil)
    }
    
    func didChangeStep() {
        HapticManager.shared.light()
    }
}
