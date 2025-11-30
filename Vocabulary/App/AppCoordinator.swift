//
//  AppCoordinator.swift
//  Vocabulary
//
//  Created by Ahmed Mahrous on 30/11/2025.
//

import SwiftUI

final class AppCoordinator: ObservableObject {
    @Published var showOnboarding: Bool
    
    private let onboardingPresenter: OnboardingPresenter
    private let homePresenter: HomePresenter
    private let checkOnboardingUseCase: CheckOnboardingStatusUseCase
    
    init(
        onboardingPresenter: OnboardingPresenter,
        homePresenter: HomePresenter,
        checkOnboardingUseCase: CheckOnboardingStatusUseCase
    ) {
        self.onboardingPresenter = onboardingPresenter
        self.homePresenter = homePresenter
        self.checkOnboardingUseCase = checkOnboardingUseCase
        
        // Check if onboarding is completed
        self.showOnboarding = !checkOnboardingUseCase.execute()
    }
    
    func start() -> some View {
        if showOnboarding {
            return AnyView(
                OnboardingView(presenter: onboardingPresenter)
                    .onReceive(NotificationCenter.default.publisher(for: .onboardingCompleted)) { _ in
                        withAnimation {
                            self.showOnboarding = false
                        }
                    }
            )
        } else {
            return AnyView(HomeView(presenter: homePresenter))
        }
    }
}

extension Notification.Name {
    static let onboardingCompleted = Notification.Name("onboardingCompleted")
}
