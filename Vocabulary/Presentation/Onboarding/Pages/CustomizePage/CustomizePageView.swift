//
//  CustomizePageView.swift
//  Vocabulary
//
//  Created by Ahmed Mahrous on 29/11/2025.
//

import SwiftUI

struct CustomizePageView: View {
    let onContinue: () -> Void
    
    var body: some View {
        ZStack {
            Color.appBeige.ignoresSafeArea()
            
            VStack(spacing: 0) {
                Spacer()
                
                // placeholder
                Image(systemName: "person.2.fill")
                    .font(.system(size: 150))
                    .foregroundColor(.appTeal)
                    .padding(.bottom, 60)
                
                // Title
                Text("Customize the app to improve your experience")
                    .font(.system(size: 20, weight: .semibold))
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
    CustomizePageView(onContinue: {})
}
