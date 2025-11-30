//
//  HomeView.swift
//  Vocabulary
//
//  Created by Ahmed Mahrous on 30/11/2025.
//

import SwiftUI

struct HomeView: View {
    @StateObject private var viewState = HomeViewState()
    private let presenter: HomePresenter
    @State private var hasAppeared = false
    
    init(presenter: HomePresenter) {
        self.presenter = presenter
    }
    
    var body: some View {
        ZStack {
            // Background
            Color.backgroundLight
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                // Header with progress
                VStack(spacing: 16) {
                    Text("Daily Vocabulary")
                        .font(.system(size: 28, weight: .bold))
                        .foregroundColor(.textPrimary)
                    
                    if viewState.learnedCount > 0 || viewState.totalCount > 0 {
                        ProgressIndicatorView(
                            learnedCount: viewState.learnedCount,
                            totalCount: viewState.totalCount
                        )
                        .transition(.scale.combined(with: .opacity))
                    }
                }
                .padding(.top, 20)
                .padding(.horizontal, 20)
                
                Spacer()
                
                // Card stack
                if viewState.isLoading {
                    ProgressView()
                        .scaleEffect(1.5)
                } else if let error = viewState.errorMessage {
                    VStack(spacing: 12) {
                        Image(systemName: "exclamationmark.triangle.fill")
                            .font(.system(size: 50))
                            .foregroundColor(.warningOrange)
                        Text(error)
                            .font(.system(size: 16))
                            .foregroundColor(.textSecondary)
                            .multilineTextAlignment(.center)
                    }
                    .padding()
                } else if !viewState.words.isEmpty {
                    CardStackView(
                        words: viewState.words,
                        onTap: { word in
                            presenter.didTapCard(word: word)
                        },
                        onSwipe: { direction, word in
                            presenter.didSwipeCard(direction: direction, word: word)
                        },
                        onDragStart: {
                            presenter.didStartDragging()
                        },
                        onDragCancel: {
                            presenter.didCancelSwipe()
                        }
                    )
                    .padding(.horizontal, 20)
                }
                
                Spacer()
                
                HStack(spacing: 60) {
                    VStack(spacing: 8) {
                        Image(systemName: "arrow.left.circle")
                            .font(.system(size: 30))
                            .foregroundColor(.warningOrange)
                        Text("Keep Learning")
                            .font(.system(size: 12))
                            .foregroundColor(.textSecondary)
                    }
                    
                    VStack(spacing: 8) {
                        Image(systemName: "checkmark.circle")
                            .font(.system(size: 30))
                            .foregroundColor(.successGreen)
                        Text("I Know This")
                            .font(.system(size: 12))
                            .foregroundColor(.textSecondary)
                    }
                }
                .padding(.bottom, 40)
            }
            
            if viewState.showExamples, let word = viewState.currentWord {
                WordExampleView(
                    examples: viewState.currentExamples,
                    word: word,
                    onClose: {
                        presenter.didTapCloseExamples()
                    }
                )
                .transition(.opacity)
                .zIndex(100)
            }
        }
        .animation(AnimationConstants.smooth, value: viewState.showExamples)
        .animation(AnimationConstants.smooth, value: viewState.learnedCount)
        .onAppear {
            if !hasAppeared {
                hasAppeared = true
                presenter.view = viewState
                presenter.viewDidLoad()
            }
        }
    }
}
