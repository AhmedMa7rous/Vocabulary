//
//  HapticManager.swift
//  Vocabulary
//
//  Created by Ahmed Mahrous on 29/11/2025.
//

import UIKit

final class HapticManager {
    static let shared = HapticManager()
    
    private init() {}
    
    // Light haptic for subtle interactions
    func light() {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
    }
    
    // Medium haptic for card actions
    func medium() {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
    }
    
    // Heavy haptic for important actions
    func heavy() {
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        generator.impactOccurred()
    }
    
    // Selection haptic for taps and selections
    func selection() {
        let generator = UISelectionFeedbackGenerator()
        generator.selectionChanged()
    }
    
    // Success haptic for achievements
    func success() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
    
    // Error haptic for mistakes
    func error() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)
    }
    
    // Card swipe sequence (Squad Busters style)
    func cardSwipeStart() {
        light()
    }
    
    func cardSwipeEnd() {
        medium()
    }
    
    func cardSnapBack() {
        light()
    }
    
    // Example reveal animation
    func exampleReveal() {
        selection()
    }
}
