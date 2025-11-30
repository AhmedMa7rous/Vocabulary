//
//  OnboardingViewProtocol.swift
//  Vocabulary
//
//  Created by Ahmed Mahrous on 30/11/2025.
//

import Foundation

protocol OnboardingViewProtocol: AnyObject {
    func displayOnboardingSteps(_ steps: [OnboardingStep])
    func navigateToHome()
}
