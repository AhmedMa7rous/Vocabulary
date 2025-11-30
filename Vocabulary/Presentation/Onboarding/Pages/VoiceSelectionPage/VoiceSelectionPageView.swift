//
//  VoiceSelectionPageView.swift
//  Vocabulary
//
//  Created by Ahmed Mahrous on 30/11/2025.
//

import SwiftUI

struct VoiceSelectionPageView: View {
    @StateObject private var voiceManager = VoiceManager.shared
    @State private var selectedVoice: VoiceOption? = nil
    let onContinue: () -> Void
    
    var body: some View {
        ZStack {
            Color.appBeige.ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Title
                Text("Choose a voice to pronounce words")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.appBlack)
                    .multilineTextAlignment(.center)
                    .padding(.top, 60)
                    .padding(.horizontal, 40)
                    .padding(.bottom, 40)
                
                // Voice options
                ScrollView {
                    VStack(spacing: 16) {
                        ForEach(voiceManager.availableVoices) { voice in
                            VoiceOptionRow(
                                voice: voice,
                                isSelected: selectedVoice?.id == voice.id,
                                isPlaying: voiceManager.isPlaying(voice.id),
                                onPlay: {
                                    HapticManager.shared.selection()
                                    voiceManager.playVoice(for: voice)
                                },
                                onSelect: {
                                    HapticManager.shared.selection()
                                    selectedVoice = voice
                                }
                            )
                        }
                    }
                    .padding(.horizontal, 20)
                }
                
                Spacer()
                
                // Continue Button
                Button(action: {
                    HapticManager.shared.selection()
                    voiceManager.stopSpeaking()
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
        .onDisappear {
            voiceManager.stopSpeaking()
        }
    }
}

#Preview {
    VoiceSelectionPageView(onContinue: {})
}
