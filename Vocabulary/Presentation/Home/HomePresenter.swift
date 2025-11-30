//
//  HomePresenter.swift
//  Vocabulary
//
//  Created by Ahmed Mahrous on 30/11/2025.
//

import Foundation

final class HomePresenter {
    weak var view: HomeViewProtocol?
    private let getWordsUseCase: GetWordsUseCase
    private let markWordAsLearnedUseCase: MarkWordAsLearnedUseCase
    
    private var allWords: [Word] = []
    private var currentIndex = 0
    
    init(
        getWordsUseCase: GetWordsUseCase,
        markWordAsLearnedUseCase: MarkWordAsLearnedUseCase
    ) {
        self.getWordsUseCase = getWordsUseCase
        self.markWordAsLearnedUseCase = markWordAsLearnedUseCase
    }
    
    func viewDidLoad() {
        view?.displayLoading()
        
        getWordsUseCase.execute { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let words):
                self.allWords = words
                self.view?.displayWords(words)
                self.updateProgress()
            case .failure(let error):
                self.view?.displayError(error.localizedDescription)
            }
        }
    }
    
    func didSwipeCard(direction: SwipeDirection, word: Word) {
        HapticManager.shared.cardSwipeEnd()
        
        if direction == .right {
            // Mark as learned
            markWordAsLearnedUseCase.execute(wordId: word.id)
            updateProgress()
        }
        
        // Move to next word in the loop
        currentIndex = (currentIndex + 1) % allWords.count
        view?.removeTopCard()
    }
    
    func didStartDragging() {
        HapticManager.shared.cardSwipeStart()
    }
    
    func didCancelSwipe() {
        HapticManager.shared.cardSnapBack()
    }
    
    func didTapCard(word: Word) {
        HapticManager.shared.selection()
        view?.showWordExamples(word.examples, for: word)
    }
    
    func didTapCloseExamples() {
        HapticManager.shared.light()
        view?.hideWordExamples()
    }
    
    private func updateProgress() {
        let learnedCount = markWordAsLearnedUseCase.getLearnedCount()
        view?.updateProgress(learned: learnedCount, total: allWords.count)
    }
}

enum SwipeDirection {
    case left
    case right
}
