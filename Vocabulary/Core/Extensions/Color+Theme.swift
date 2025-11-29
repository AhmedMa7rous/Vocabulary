//
//  Color+Theme.swift
//  Vocabulary
//
//  Created by Ahmed Mahrous on 29/11/2025.
//

import SwiftUI

extension Color {
    // App theme colors matching the onboarding design
    static let appTeal = Color(red: 0.49, green: 0.75, blue: 0.70) // #7DBFB3
    static let appBeige = Color(red: 0.96, green: 0.95, blue: 0.91) // #F5F1E8
    static let appCoral = Color(red: 0.95, green: 0.64, blue: 0.60) // Coral accent
    static let appBlack = Color.black
    
    // Legacy colors (keep for home screen)
    static let primaryBlue = Color(red: 0.2, green: 0.4, blue: 0.9)
    static let accentPurple = Color(red: 0.6, green: 0.3, blue: 0.9)
    static let successGreen = Color(red: 0.2, green: 0.8, blue: 0.4)
    static let warningOrange = Color(red: 1.0, green: 0.6, blue: 0.0)
    
    static let textPrimary = Color.black
    static let textSecondary = Color.gray
    static let backgroundLight = Color(white: 0.97)
    
    static let gradientStart = Color(red: 0.4, green: 0.5, blue: 1.0)
    static let gradientEnd = Color(red: 0.7, green: 0.4, blue: 1.0)
}
