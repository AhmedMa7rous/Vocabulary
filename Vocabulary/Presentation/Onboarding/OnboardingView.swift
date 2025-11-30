//
//  OnboardingView.swift
//  Vocabulary
//
//  Created by Ahmed Mahrous on 30/11/2025.
//

import SwiftUI

struct OnboardingView: View {
    @StateObject private var viewState = OnboardingViewState()
    private let presenter: OnboardingPresenter
    @State private var hasAppeared = false
    @State private var currentPage = 0
    
    init(presenter: OnboardingPresenter) {
        self.presenter = presenter
    }
    
    var body: some View {
        ZStack {
            Color.appBeige.ignoresSafeArea()
            
            TabView(selection: $currentPage) {
                // Screen 1: Welcome
                WelcomePageView(onContinue: {
                    withAnimation {
                        currentPage = 1
                    }
                })
                .tag(0)
                
                // Screen 2: Age Selection
                AgeSelectionPageView(
                    onContinue: {
                        withAnimation {
                            currentPage = 2
                        }
                    },
                    onSkip: {
                        withAnimation {
                            currentPage = 2
                        }
                    }
                )
                .tag(1)
                
                // Screen 3: Name Input
                NameInputPageView(
                    onContinue: {
                        withAnimation {
                            currentPage = 3
                        }
                    },
                    onSkip: {
                        withAnimation {
                            currentPage = 3
                        }
                    }
                )
                .tag(2)
                
                // Screen 4: Customize
                CustomizePageView(onContinue: {
                    withAnimation {
                        currentPage = 4
                    }
                })
                .tag(3)
                
                // Screen 5: Words Per Week
                WordsPerWeekPageView(
                    onContinue: {
                        withAnimation {
                            currentPage = 5
                        }
                    },
                    onSkip: {
                        withAnimation {
                            currentPage = 5
                        }
                    }
                )
                .tag(4)
                
                // Screen 6: Daily Routine
                DailyRoutinePageView(onContinue: {
                    withAnimation {
                        currentPage = 6
                    }
                })
                .tag(5)
                
                // Screen 7: Voice Selection
                VoiceSelectionPageView(onContinue: {
                    withAnimation {
                        currentPage = 7
                    }
                })
                .tag(6)
                
                // Screen 8: Categories
                CategoriesPageView(
                    onContinue: {
                        presenter.didTapGetStarted()
                    },
                    onSkip: {
                        presenter.didTapGetStarted()
                    }
                )
                .tag(7)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))
            .onChange(of: currentPage) { _, _ in
                presenter.didChangeStep()
            }
        }
        .onAppear {
            if !hasAppeared {
                hasAppeared = true
                presenter.view = viewState
                presenter.viewDidLoad()
            }
        }
    }
}

