//
//  NameInputPageView.swift
//  Vocabulary
//
//  Created by Ahmed Mahrous on 29/11/2025.
//

import SwiftUI

struct NameInputPageView: View {
    @State private var name: String = ""
    let onContinue: () -> Void
    let onSkip: () -> Void
    
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
                Text("What do you want to be called?")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.appBlack)
                    .multilineTextAlignment(.center)
                    .padding(.top, 60)
                    .padding(.horizontal, 40)
                
                // Text field
                TextField("Your name", text: $name)
                    .font(.system(size: 16))
                    .foregroundStyle(.black)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 18)
                    .background(Color.white)
                    .overlay(
                        RoundedRectangle(cornerRadius: 30)
                            .stroke(Color.appBlack, lineWidth: 3)
                    )
                    .cornerRadius(30)
                    .padding(.horizontal, 20)
                    .padding(.top, 40)
                
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
    NameInputPageView(onContinue: {}, onSkip: {})
}
