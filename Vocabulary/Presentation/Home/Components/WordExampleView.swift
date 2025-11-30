//
//  WordExampleView.swift
//  Vocabulary
//
//  Created by Ahmed Mahrous on 30/11/2025.
//

import SwiftUI

struct WordExampleView: View {
    let examples: [WordExample]
    let word: Word
    let onClose: () -> Void
    @State private var appearStates: [Bool] = []
    
    var body: some View {
        ZStack {
            // Backdrop
            Color.black.opacity(0.4)
                .ignoresSafeArea()
                .onTapGesture {
                    onClose()
                }
            
            VStack(spacing: 0) {
                Spacer()
                
                // Examples card
                VStack(alignment: .leading, spacing: 20) {
                    // Header
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text(word.term)
                                .font(.system(size: 24, weight: .bold))
                                .foregroundColor(.textPrimary)
                            
                            Text("in context")
                                .font(.system(size: 14))
                                .foregroundColor(.textSecondary)
                        }
                        
                        Spacer()
                        
                        Button(action: onClose) {
                            Image(systemName: "xmark.circle.fill")
                                .font(.system(size: 28))
                                .foregroundColor(.textSecondary.opacity(0.5))
                        }
                    }
                    .padding(.bottom, 10)
                    
                    Divider()
                    
                    // Examples list
                    ScrollView {
                        VStack(spacing: 16) {
                            ForEach(Array(examples.enumerated()), id: \.element.id) { index, example in
                                ExampleRow(example: example, word: word.term)
                                    .opacity(appearStates.indices.contains(index) && appearStates[index] ? 1 : 0)
                                    .offset(y: appearStates.indices.contains(index) && appearStates[index] ? 0 : 20)
                            }
                        }
                    }
                    .frame(maxHeight: 300)
                }
                .padding(24)
                .background(Color.white)
                .cornerRadius(25)
                .shadow(color: Color.black.opacity(0.2), radius: 20, x: 0, y: 10)
                .padding(.horizontal, 20)
                .padding(.bottom, 40)
            }
        }
        .transition(.opacity)
        .onAppear {
            appearStates = Array(repeating: false, count: examples.count)
            
            for index in examples.indices {
                DispatchQueue.main.asyncAfter(deadline: .now() + Double(index) * AnimationConstants.exampleStaggerDelay) {
                    withAnimation(AnimationConstants.exampleReveal) {
                        if appearStates.indices.contains(index) {
                            appearStates[index] = true
                        }
                    }
                    HapticManager.shared.exampleReveal()
                }
            }
        }
    }
}

struct ExampleRow: View {
    let example: WordExample
    let word: String
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            Image(systemName: "quote.bubble.fill")
                .font(.system(size: 16))
                .foregroundColor(.primaryBlue)
                .padding(.top, 2)
            
            Text(highlightedSentence)
                .font(.system(size: 16))
                .lineSpacing(4)
                .foregroundColor(.textPrimary)
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.backgroundLight)
        .cornerRadius(12)
    }
    
    private var highlightedSentence: AttributedString {
        var attributedString = AttributedString(example.sentence)
        
        if let range = attributedString.range(of: example.highlightedWord, options: .caseInsensitive) {
            attributedString[range].foregroundColor = .primaryBlue
            attributedString[range].font = .system(size: 16, weight: .bold)
        }
        
        return attributedString
    }
}
#Preview {
    WordExampleView(examples: [], word: Word(term: "", pronunciation: "", partOfSpeech: "", definition: "", examples: []), onClose: {})
}
