//
//  HomeViewState.swift
//  Vocabulary
//
//  Created by Ahmed Mahrous on 30/11/2025.
//

import Foundation

final class HomeViewState: ObservableObject, HomeViewProtocol {
    @Published var words: [Word] = []
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var learnedCount = 0
    @Published var totalCount = 0
    @Published var showExamples = false
    @Published var currentExamples: [WordExample] = []
    @Published var currentWord: Word?
    @Published var shouldRemoveTopCard = false
    
    func displayLoading() {
        isLoading = true
        errorMessage = nil
    }
    
    func displayWords(_ words: [Word]) {
        self.words = words
        self.totalCount = words.count
        self.isLoading = false
    }
    
    func displayError(_ message: String) {
        errorMessage = message
        isLoading = false
    }
    
    func updateProgress(learned: Int, total: Int) {
        learnedCount = learned
        totalCount = total
    }
    
    func showWordExamples(_ examples: [WordExample], for word: Word) {
        currentExamples = examples
        currentWord = word
        showExamples = true
    }
    
    func hideWordExamples() {
        showExamples = false
    }
    
    func removeTopCard() {
        shouldRemoveTopCard = true
        // Reset the flag after a short delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.shouldRemoveTopCard = false
        }
    }
}
