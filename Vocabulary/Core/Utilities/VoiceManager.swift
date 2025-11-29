//
//  VoiceManager.swift
//  Vocabulary
//
//  Created by Ahmed Mahrous on 29/11/2025.
//

import AVFoundation
import Foundation

// MARK: - Voice Model

struct VoiceOption: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let accent: String
    let languageCode: String
    let voiceIdentifier: String
    
    static func == (lhs: VoiceOption, rhs: VoiceOption) -> Bool {
        return lhs.id == rhs.id
    }
}

// MARK: - Voice Manager

final class VoiceManager: ObservableObject {
    static let shared = VoiceManager()
    
    private let synthesizer = AVSpeechSynthesizer()
    @Published var currentlyPlaying: UUID? = nil
    
    private init() {}
    
    // Sample text to demonstrate each voice
    private let sampleText = "Hello, I will help you learn new vocabulary words."
    
    // Available voices with their configurations
    let availableVoices: [VoiceOption] = [
        VoiceOption(
            name: "Samantha",
            accent: "American",
            languageCode: "en-US",
            voiceIdentifier: "com.apple.voice.compact.en-US.Samantha"
        ),
        VoiceOption(
            name: "Alex",
            accent: "American",
            languageCode: "en-US",
            voiceIdentifier: "com.apple.ttsbundle.Alex-compact"
        ),
        VoiceOption(
            name: "Daniel",
            accent: "British",
            languageCode: "en-GB",
            voiceIdentifier: "com.apple.voice.compact.en-GB.Daniel"
        ),
        VoiceOption(
            name: "Kate",
            accent: "British",
            languageCode: "en-GB",
            voiceIdentifier: "com.apple.voice.compact.en-GB.Kate"
        ),
        VoiceOption(
            name: "Karen",
            accent: "Australian",
            languageCode: "en-AU",
            voiceIdentifier: "com.apple.voice.compact.en-AU.Karen"
        ),
        VoiceOption(
            name: "Moira",
            accent: "Irish",
            languageCode: "en-IE",
            voiceIdentifier: "com.apple.voice.compact.en-IE.Moira"
        )
    ]
    
    // Play voice sample for a specific voice option
    func playVoice(for voiceOption: VoiceOption) {
        if synthesizer.isSpeaking {
            synthesizer.stopSpeaking(at: .immediate)
        }
        
        let utterance = AVSpeechUtterance(string: sampleText)
        
        if let voice = AVSpeechSynthesisVoice(identifier: voiceOption.voiceIdentifier) {
            utterance.voice = voice
        } else {
            utterance.voice = AVSpeechSynthesisVoice(language: voiceOption.languageCode)
        }
        
        utterance.rate = 0.5
        utterance.pitchMultiplier = 1.0
        utterance.volume = 1.0
        
        currentlyPlaying = voiceOption.id
        
        synthesizer.speak(utterance)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(sampleText.count) * 0.05) {
            self.currentlyPlaying = nil
        }
    }
    
    // Play pronunciation for a specific word
    func pronounceWord(_ word: String, using voiceOption: VoiceOption) {
        if synthesizer.isSpeaking {
            synthesizer.stopSpeaking(at: .immediate)
        }
        
        let utterance = AVSpeechUtterance(string: word)
        
        if let voice = AVSpeechSynthesisVoice(identifier: voiceOption.voiceIdentifier) {
            utterance.voice = voice
        } else {
            utterance.voice = AVSpeechSynthesisVoice(language: voiceOption.languageCode)
        }
        
        utterance.rate = 0.4
        utterance.pitchMultiplier = 1.0
        utterance.volume = 1.0
        
        synthesizer.speak(utterance)
    }
    
    // Stop any currently playing speech
    func stopSpeaking() {
        if synthesizer.isSpeaking {
            synthesizer.stopSpeaking(at: .immediate)
            currentlyPlaying = nil
        }
    }
    
    // Check if a specific voice is currently playing
    func isPlaying(_ voiceId: UUID) -> Bool {
        return currentlyPlaying == voiceId
    }
}
