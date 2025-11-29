//
//  OnboardingRepositoryProtocol.swift
//  Vocabulary
//
//  Created by Ahmed Mahrous on 29/11/2025.
//

import Foundation

protocol OnboardingRepositoryProtocol {
    func getOnboardingSteps() -> [OnboardingStep]
    func isOnboardingCompleted() -> Bool
    func markOnboardingCompleted()
}
