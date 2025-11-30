//
//  OnboardingViewState.swift
//  Vocabulary
//
//  Created by Ahmed Mahrous on 30/11/2025.
//

import Foundation

final class OnboardingViewState: ObservableObject, OnboardingViewProtocol {
    @Published var steps: [OnboardingStep] = []
    @Published var shouldNavigateToHome = false
    
    func displayOnboardingSteps(_ steps: [OnboardingStep]) {
        self.steps = steps
    }
    
    func navigateToHome() {
        shouldNavigateToHome = true
    }
}
