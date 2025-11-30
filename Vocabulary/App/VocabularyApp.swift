//
//  VocabularyApp.swift
//  Vocabulary
//
//  Created by Ahmed Mahrous on 29/11/2025.
//

import SwiftUI

@main
struct VocabularyApp: App {
    @StateObject private var coordinator: AppCoordinator
    
    init() {
        // Data Layer
        let userDefaultsDataSource = UserDefaultsDataSource()
        let localWordDataSource = LocalWordDataSource()
        
        let wordRepository = WordRepository(
            localDataSource: localWordDataSource,
            userDefaultsDataSource: userDefaultsDataSource
        )
        let onboardingRepository = OnboardingRepository(userDefaultsDataSource: userDefaultsDataSource)
        
        // Domain Layer (Use Cases)
        let getWordsUseCase = GetWordsUseCase(repository: wordRepository)
        let markWordAsLearnedUseCase = MarkWordAsLearnedUseCase(repository: wordRepository)
        let checkOnboardingUseCase = CheckOnboardingStatusUseCase(repository: onboardingRepository)
        
        // Presentation Layer (Presenters)
        let homePresenter = HomePresenter(
            getWordsUseCase: getWordsUseCase,
            markWordAsLearnedUseCase: markWordAsLearnedUseCase
        )
        
        let onboardingPresenter = OnboardingPresenter(
            checkOnboardingUseCase: checkOnboardingUseCase
        )
        
        // Coordinator
        let coordinator = AppCoordinator(
            onboardingPresenter: onboardingPresenter,
            homePresenter: homePresenter,
            checkOnboardingUseCase: checkOnboardingUseCase
        )
        
        _coordinator = StateObject(wrappedValue: coordinator)
    }
    
    var body: some Scene {
        WindowGroup {
            coordinator.start()
        }
    }
}
