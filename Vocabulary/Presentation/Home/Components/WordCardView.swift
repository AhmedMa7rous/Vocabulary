//
//  WordCardView.swift
//  Vocabulary
//
//  Created by Ahmed Mahrous on 30/11/2025.
//

import SwiftUI

struct WordCardView: View {
    let word: Word
    let onTap: () -> Void
    let onSwipe: (SwipeDirection) -> Void
    let onDragStart: () -> Void
    let onDragCancel: () -> Void
    
    @State private var offset: CGSize = .zero
    @State private var rotation: Double = 0
    @StateObject private var voiceManager = VoiceManager.shared
    
    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            // Header
            VStack(alignment: .leading, spacing: 8) {
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(word.term)
                            .font(.system(size: 36, weight: .bold))
                            .foregroundColor(.textPrimary)
                        
                        if let pronunciation = word.pronunciation {
                            Text(pronunciation)
                                .font(.system(size: 16))
                                .foregroundColor(.textSecondary)
                        }
                    }
                    
                    Spacer()
                    
                    // Pronunciation button
                    Button(action: {
                        HapticManager.shared.selection()
                        if let defaultVoice = voiceManager.availableVoices.first(where: { $0.accent == "American" }) {
                            voiceManager.pronounceWord(word.term, using: defaultVoice)
                        }
                    }) {
                        ZStack {
                            Circle()
                                .fill(Color.appTeal.opacity(0.2))
                                .frame(width: 44, height: 44)
                            
                            Image(systemName: "speaker.wave.2.fill")
                                .font(.system(size: 20))
                                .foregroundColor(.appTeal)
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                    
                    Text(word.partOfSpeech)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.primaryBlue)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(Color.primaryBlue.opacity(0.1))
                        .cornerRadius(8)
                }
                
                Divider()
                    .padding(.vertical, 8)
            }
            
            // Definition
            VStack(alignment: .leading, spacing: 12) {
                Text("Definition")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.textSecondary)
                
                Text(word.definition)
                    .font(.system(size: 18))
                    .foregroundColor(.textPrimary)
                    .lineSpacing(4)
            }
            
            Spacer()
            
            HStack {
                Spacer()
                Text("Tap to see examples")
                    .font(.system(size: 14))
                    .foregroundColor(.textSecondary.opacity(0.6))
                Image(systemName: "hand.tap.fill")
                    .font(.system(size: 12))
                    .foregroundColor(.textSecondary.opacity(0.6))
                Spacer()
            }
        }
        .padding(30)
        .frame(maxWidth: .infinity)
        .frame(height: 500)
        .background(Color.white)
        .cornerRadius(20)
        .shadow(color: Color.black.opacity(0.15), radius: 15, x: 0, y: 8)
        .rotationEffect(.degrees(rotation))
        .offset(offset)
        .gesture(
            DragGesture()
                .onChanged { gesture in
                    if offset == .zero {
                        onDragStart()
                    }
                    offset = gesture.translation
                    rotation = Double(gesture.translation.width) * Constants.rotationMultiplier
                }
                .onEnded { gesture in
                    let swipeThreshold = Constants.swipeThreshold
                    
                    if abs(gesture.translation.width) > swipeThreshold {
                        // Swiped
                        let direction: SwipeDirection = gesture.translation.width > 0 ? .right : .left
                        withAnimation(AnimationConstants.cardSwipe) {
                            offset = CGSize(
                                width: gesture.translation.width > 0 ? 500 : -500,
                                height: gesture.translation.height
                            )
                            rotation = gesture.translation.width > 0 ? 20 : -20
                        }
                        
                        DispatchQueue.main.asyncAfter(deadline: .now() + AnimationConstants.cardSwipeDuration) {
                            onSwipe(direction)
                            offset = .zero
                            rotation = 0
                        }
                    } else {
                        withAnimation(AnimationConstants.cardSnapBack) {
                            offset = .zero
                            rotation = 0
                        }
                        onDragCancel()
                    }
                }
        )
        .onTapGesture {
            onTap()
        }
        .overlay(
            Group {
                if abs(offset.width) > 30 {
                    VStack {
                        HStack(spacing: 30) {
                            if offset.width < 0 {
                                Image(systemName: "arrow.left.circle.fill")
                                    .font(.system(size: 50))
                                    .foregroundColor(.warningOrange)
                                    .opacity(Double(abs(offset.width) / 100))
                                Spacer()
                            } else {
                                Spacer()
                                Image(systemName: "arrow.right.circle.fill")
                                    .font(.system(size: 50))
                                    .foregroundColor(.successGreen)
                                    .opacity(Double(offset.width / 100))
                            }
                        }
                        .padding(40)
                        Spacer()
                    }
                }
            }
        )
    }
}
