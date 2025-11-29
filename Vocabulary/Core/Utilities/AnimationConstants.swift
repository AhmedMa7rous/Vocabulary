//
//  AnimationConstants.swift
//  Vocabulary
//
//  Created by Ahmed Mahrous on 29/11/2025.
//

import SwiftUI

enum AnimationConstants {
    // Spring animations
    static let cardSwipe = Animation.spring(response: 0.5, dampingFraction: 0.7)
    static let cardSnapBack = Animation.spring(response: 0.4, dampingFraction: 0.8)
    static let exampleReveal = Animation.spring(response: 0.35, dampingFraction: 0.75)
    
    // Ease animations
    static let smooth = Animation.easeInOut(duration: 0.3)
    static let quick = Animation.easeOut(duration: 0.2)
    static let slow = Animation.easeInOut(duration: 0.5)
    
    // Durations
    static let cardSwipeDuration: Double = 0.5
    static let exampleRevealDuration: Double = 0.3
    static let progressUpdateDuration: Double = 0.4
    
    // Stagger delays
    static let exampleStaggerDelay: Double = 0.1
}
