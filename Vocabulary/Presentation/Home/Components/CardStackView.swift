//
//  CardStackView.swift
//  Vocabulary
//
//  Created by Ahmed Mahrous on 30/11/2025.
//

import SwiftUI

struct CardStackView: View {
    let words: [Word]
    let onTap: (Word) -> Void
    let onSwipe: (SwipeDirection, Word) -> Void
    let onDragStart: () -> Void
    let onDragCancel: () -> Void
    
    @State private var displayedWords: [Word] = []
    
    var body: some View {
        ZStack {
            ForEach(Array(displayedWords.prefix(3).enumerated()), id: \.element.id) { index, word in
                WordCardView(
                    word: word,
                    onTap: { onTap(word) },
                    onSwipe: { direction in
                        onSwipe(direction, word)
                        removeTopCard()
                    },
                    onDragStart: onDragStart,
                    onDragCancel: onDragCancel
                )
                .zIndex(Double(displayedWords.count - index))
                .offset(y: CGFloat(index * 8))
                .scaleEffect(1 - CGFloat(index) * 0.05)
                .opacity(index < 2 ? 1 : 0.5)
            }
        }
        .onAppear {
            setupCardLoop()
        }
        .onChange(of: words) { _, _ in
            if displayedWords.isEmpty {
                setupCardLoop()
            }
        }
    }
    
    private func setupCardLoop() {
        displayedWords = words
    }
    
    private func removeTopCard() {
        guard !displayedWords.isEmpty else { return }
        
        let removedWord = displayedWords.removeFirst()
        
        // Add card back to the end for looping
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            displayedWords.append(removedWord)
        }
    }
}
