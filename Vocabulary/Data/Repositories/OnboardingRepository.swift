//
//  OnboardingRepository.swift
//  Vocabulary
//
//  Created by Ahmed Mahrous on 29/11/2025.
//

import Foundation

final class OnboardingRepository: OnboardingRepositoryProtocol {
    private let userDefaultsDataSource: UserDefaultsDataSource
    
    init(userDefaultsDataSource: UserDefaultsDataSource = UserDefaultsDataSource()) {
        self.userDefaultsDataSource = userDefaultsDataSource
    }
    
    func getOnboardingSteps() -> [OnboardingStep] {
        return [
            OnboardingStep(
                type: .welcome,
                title: "Tailor your word recommendations",
                subtitle: nil,
                imageName: nil,
                order: 0
            ),
            OnboardingStep(
                type: .ageSelection,
                title: "How old are you?",
                subtitle: nil,
                imageName: nil,
                order: 1
            ),
            OnboardingStep(
                type: .nameInput,
                title: "What do you want to be called?",
                subtitle: nil,
                imageName: nil,
                order: 2
            ),
            OnboardingStep(
                type: .customize,
                title: "Customize the app to improve your experience",
                subtitle: nil,
                imageName: nil,
                order: 3
            ),
            OnboardingStep(
                type: .wordsPerWeek,
                title: "How many words do you want to learn per week?",
                subtitle: nil,
                imageName: nil,
                order: 4
            ),
            OnboardingStep(
                type: .dailyRoutine,
                title: "Create a consistent daily learning routine",
                subtitle: "Build a streak, one day at a time",
                imageName: nil,
                order: 5
            ),
            OnboardingStep(
                type: .voiceSelection,
                title: "Choose a voice to pronounce words",
                subtitle: nil,
                imageName: nil,
                order: 6
            ),
            OnboardingStep(
                type: .categories,
                title: "Which categories are you interested in?",
                subtitle: nil,
                imageName: nil,
                order: 7
            )
        ]
    }
    
    func isOnboardingCompleted() -> Bool {
        return userDefaultsDataSource.isOnboardingCompleted()
    }
    
    func markOnboardingCompleted() {
        userDefaultsDataSource.markOnboardingCompleted()
    }
}
