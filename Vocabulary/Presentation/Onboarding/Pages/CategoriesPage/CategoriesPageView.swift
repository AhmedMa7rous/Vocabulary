//
//  CategoriesPageView.swift
//  Vocabulary
//
//  Created by Ahmed Mahrous on 29/11/2025.
//

import SwiftUI

struct CategoriesPageView: View {
    @State private var selectedCategories: Set<String> = []
    let onContinue: () -> Void
    let onSkip: () -> Void
    
    private let categories = [
        "Beautiful words", "Music", "Funny words", "Games", "Society",
        "Emotions", "Blog", "Business", "Literature", "Expressions",
        "Communication", "History", "Smoking", "People", "Art", "Genre",
        "Cure words"
    ]
    
    var body: some View {
        ZStack {
            Color.appBeige.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Header with Skip button
                HStack {
                    Spacer()
                    Button(action: {
                        HapticManager.shared.light()
                        onSkip()
                    }) {
                        Text("Skip")
                            .font(.system(size: 16))
                            .foregroundColor(.appBlack)
                    }
                    .padding(.trailing, 20)
                    .padding(.top, 20)
                }
                
                // Title
                Text("Which categories are you interested in?")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.appBlack)
                    .multilineTextAlignment(.center)
                    .padding(.top, 40)
                    .padding(.horizontal, 40)
                    .padding(.bottom, 30)
                
                // Categories cards
                ScrollView {
                    FlowLayout(spacing: 12) {
                        ForEach(categories, id: \.self) { category in
                            Button(action: {
                                HapticManager.shared.selection()
                                if selectedCategories.contains(category) {
                                    selectedCategories.remove(category)
                                } else {
                                    selectedCategories.insert(category)
                                }
                            }) {
                                HStack(spacing: 6) {
                                    if selectedCategories.contains(category) {
                                        Image(systemName: "checkmark")
                                            .font(.system(size: 12, weight: .bold))
                                            .foregroundColor(.white)
                                    }
                                    Text(category)
                                        .font(.system(size: 15))
                                        .foregroundColor(selectedCategories.contains(category) ? .white : .appBlack)
                                }
                                .padding(.horizontal, 16)
                                .padding(.vertical, 10)
                                .background(selectedCategories.contains(category) ? Color.appTeal : Color.white)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 20)
                                        .stroke(Color.appBlack, lineWidth: 2)
                                )
                                .cornerRadius(20)
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                }
                
                Spacer()
                
                // Continue Button
                Button(action: {
                    HapticManager.shared.selection()
                    onContinue()
                }) {
                    Text("Continue")
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundColor(.appBlack)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 18)
                        .background(Color.appTeal)
                        .cornerRadius(30)
                }
                .padding(.horizontal, 30)
                .padding(.bottom, 40)
            }
        }
    }
}

#Preview {
    CategoriesPageView(onContinue: {}, onSkip: {})
}
