//
//  CheckOnboardingStatusUseCase.swift
//  Vocabulary
//
//  Created by Ahmed Mahrous on 29/11/2025.
//

import Foundation

final class CheckOnboardingStatusUseCase {
    private let repository: OnboardingRepositoryProtocol
    
    init(repository: OnboardingRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute() -> Bool {
        return repository.isOnboardingCompleted()
    }
    
    func completeOnboarding() {
        repository.markOnboardingCompleted()
    }
    
    func getOnboardingSteps() -> [OnboardingStep] {
        return repository.getOnboardingSteps()
    }
}
