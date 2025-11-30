//
//  DailyRoutinePageView.swift
//  Vocabulary
//
//  Created by Ahmed Mahrous on 29/11/2025.
//

import SwiftUI

struct DailyRoutinePageView: View {
    let onContinue: () -> Void
    
    var body: some View {
        ZStack {
            Color.appBeige.ignoresSafeArea()
            
            VStack(spacing: 0) {
                Spacer()
                
                // placeholder
                ZStack {
                    Circle()
                        .fill(Color.appTeal)
                        .frame(width: 120, height: 120)
                    
                    Text("1")
                        .font(.system(size: 60, weight: .bold))
                        .foregroundColor(.appBlack)
                }
                .padding(.bottom, 60)
                
                // Title
                Text("Create a consistent daily learning routine")
                    .font(.system(size: 22, weight: .semibold))
                    .foregroundColor(.appBlack)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 40)
                    .padding(.bottom, 12)
                
                // Subtitle card
                HStack {
                    Image(systemName: "calendar")
                        .font(.system(size: 24))
                        .foregroundColor(.appTeal)
                    
                    Text("Build a streak, one day at a time")
                        .font(.system(size: 16))
                        .foregroundColor(.appBlack)
                    
                    Spacer()
                }
                .padding(20)
                .background(Color.white)
                .overlay(
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(Color.appBlack, lineWidth: 2)
                )
                .cornerRadius(20)
                .padding(.horizontal, 30)
                
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
    DailyRoutinePageView(onContinue: {})
}
