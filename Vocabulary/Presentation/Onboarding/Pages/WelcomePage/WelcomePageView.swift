//
//  WelcomePageView.swift
//  Vocabulary
//
//  Created by Ahmed Mahrous on 30/11/2025.
//

import SwiftUI

struct WelcomePageView: View {
    let onContinue: () -> Void
    
    var body: some View {
        ZStack {
            Color.appBeige.ignoresSafeArea()
            
            VStack(spacing: 0) {
                Spacer()
                
                // Illustration
                Image(systemName: "figure.walk")
                    .font(.system(size: 200))
                    .foregroundColor(.appTeal)
                    .padding(.bottom, 40)
                
                // Title
                Text("Tailor your word recommendations")
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundColor(.appBlack)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
                
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
    WelcomePageView(onContinue: {})
}
