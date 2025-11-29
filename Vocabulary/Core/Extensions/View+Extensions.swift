//
//  View+Extensions.swift
//  Vocabulary
//
//  Created by Ahmed Mahrous on 29/11/2025.
//

import SwiftUI

extension View {
    func cardStyle() -> some View {
        self
            .background(Color.white)
            .cornerRadius(20)
            .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: 5)
    }
    
    func onboardingCardStyle() -> some View {
        self
            .frame(maxWidth: .infinity)
            .padding(30)
            .background(Color.white)
            .cornerRadius(25)
            .shadow(color: Color.black.opacity(0.08), radius: 15, x: 0, y: 8)
    }
}
