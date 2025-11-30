//
//  ProgressIndicatorView.swift
//  Vocabulary
//
//  Created by Ahmed Mahrous on 30/11/2025.
//

import SwiftUI

struct ProgressIndicatorView: View {
    let learnedCount: Int
    let totalCount: Int
    
    var body: some View {
        HStack(spacing: 12) {
            // Trophy icon
            Image(systemName: "star.fill")
                .font(.system(size: 18))
                .foregroundColor(.successGreen)
            
            // Progress text
            Text("\(learnedCount) words learned")
                .font(.system(size: 16, weight: .semibold))
                .foregroundColor(.textPrimary)
            
            Spacer()
            
            // Progress circle
            ZStack {
                Circle()
                    .stroke(Color.gray.opacity(0.2), lineWidth: 3)
                    .frame(width: 30, height: 30)
                
                Circle()
                    .trim(from: 0, to: CGFloat(learnedCount) / CGFloat(max(totalCount, 1)))
                    .stroke(Color.successGreen, lineWidth: 3)
                    .frame(width: 30, height: 30)
                    .rotationEffect(.degrees(-90))
                    .animation(AnimationConstants.smooth, value: learnedCount)
            }
        }
        .padding(.horizontal, 20)
        .padding(.vertical, 12)
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: Color.black.opacity(0.08), radius: 8, x: 0, y: 4)
    }
}
