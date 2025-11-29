//
//  OnboardingStep.swift
//  Vocabulary
//
//  Created by Ahmed Mahrous on 29/11/2025.
//

import Foundation

enum OnboardingStepType {
    case welcome
    case ageSelection
    case nameInput
    case customize
    case wordsPerWeek
    case dailyRoutine
    case voiceSelection
    case categories
}

struct OnboardingStep: Identifiable, Equatable {
    let id: UUID
    let type: OnboardingStepType
    let title: String
    let subtitle: String?
    let imageName: String?
    let order: Int
    
    init(
        id: UUID = UUID(),
        type: OnboardingStepType,
        title: String,
        subtitle: String? = nil,
        imageName: String? = nil,
        order: Int
    ) {
        self.id = id
        self.type = type
        self.title = title
        self.subtitle = subtitle
        self.imageName = imageName
        self.order = order
    }
}
