//
//  WordsPerWeekPageView.swift
//  Vocabulary
//
//  Created by Ahmed Mahrous on 30/11/2025.
//

import SwiftUI

struct WordsPerWeekPageView: View {
    @State private var selectedOption: String? = nil
    let onContinue: () -> Void
    let onSkip: () -> Void
    
    private let options = ["10 words a week", "30 words a week", "50 words a week"]
    
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
                Text("How many words do you want to learn per week?")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.appBlack)
                    .multilineTextAlignment(.center)
                    .padding(.top, 40)
                    .padding(.horizontal, 40)
                    .padding(.bottom, 40)
                
                // Options
                VStack(spacing: 16) {
                    ForEach(options, id: \.self) { option in
                        Button(action: {
                            HapticManager.shared.selection()
                            selectedOption = option
                            onContinue()
                        }) {
                            HStack {
                                Text(option)
                                    .font(.system(size: 18))
                                    .foregroundColor(.appBlack)
                                Spacer()
                                Circle()
                                    .strokeBorder(Color.appBlack, lineWidth: 2)
                                    .background(
                                        Circle()
                                            .fill(selectedOption == option ? Color.appBlack : Color.clear)
                                    )
                                    .frame(width: 24, height: 24)
                            }
                            .padding(.horizontal, 24)
                            .padding(.vertical, 18)
                            .background(Color.white)
                            .overlay(
                                RoundedRectangle(cornerRadius: 30)
                                    .stroke(Color.appBlack, lineWidth: 2)
                            )
                            .cornerRadius(30)
                        }
                        .padding(.horizontal, 20)
                    }
                }
                
                Spacer()
            }
        }
    }
}

#Preview {
    WordsPerWeekPageView(onContinue: {}, onSkip: {})
}
