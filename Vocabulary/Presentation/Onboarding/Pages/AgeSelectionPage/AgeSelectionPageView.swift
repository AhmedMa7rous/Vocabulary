//
//  AgeSelectionPageView.swift
//  Vocabulary
//
//  Created by Ahmed Mahrous on 29/11/2025.
//

import SwiftUI

struct AgeSelectionPageView: View {
    @State private var selectedAge: String? = nil
    let onContinue: () -> Void
    let onSkip: () -> Void
    
    private let ageRanges = ["13 to 17", "18 to 24", "25 to 34", "35 to 44", "45 to 54", "55+"]
    
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
                Text("How old are you?")
                    .font(.system(size: 28, weight: .bold))
                    .foregroundColor(.appBlack)
                    .padding(.top, 40)
                    .padding(.bottom, 40)
                
                // Age options
                VStack(spacing: 16) {
                    ForEach(ageRanges, id: \.self) { age in
                        Button(action: {
                            HapticManager.shared.selection()
                            selectedAge = age
                            onContinue()
                        }) {
                            HStack {
                                Text(age)
                                    .font(.system(size: 18))
                                    .foregroundColor(.appBlack)
                                Spacer()
                                Circle()
                                    .strokeBorder(Color.appBlack, lineWidth: 2)
                                    .background(
                                        Circle()
                                            .fill(selectedAge == age ? Color.appBlack : Color.clear)
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
    AgeSelectionPageView(onContinue: {}, onSkip: {})
}
