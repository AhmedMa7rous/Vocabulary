//
//  VoiceOptionRow.swift
//  Vocabulary
//
//  Created by Ahmed Mahrous on 30/11/2025.
//

import SwiftUI

struct VoiceOptionRow: View {
    let voice: VoiceOption
    let isSelected: Bool
    let isPlaying: Bool
    let onPlay: () -> Void
    let onSelect: () -> Void
    
    var body: some View {
        Button(action: onSelect) {
            HStack(spacing: 16) {
                // Play button
                Button(action: {
                    onPlay()
                }) {
                    ZStack {
                        Circle()
                            .fill(Color.appTeal.opacity(0.2))
                            .frame(width: 44, height: 44)
                        
                        Image(systemName: isPlaying ? "stop.circle.fill" : "play.circle.fill")
                            .font(.system(size: 28))
                            .foregroundColor(isPlaying ? Color.appCoral : Color.appBlack)
                    }
                }
                .buttonStyle(PlainButtonStyle())
                
                // Voice info
                VStack(alignment: .leading, spacing: 4) {
                    Text(voice.name)
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(.appBlack)
                    
                    Text(voice.accent)
                        .font(.system(size: 14))
                        .foregroundColor(.gray)
                }
                
                Spacer()
                
                // Waveform animation when playing
                if isPlaying {
                    WaveformView()
                        .frame(width: 60, height: 24)
                } else {
                    // Static waveform
                    Image(systemName: "waveform")
                        .font(.system(size: 20))
                        .foregroundColor(.gray.opacity(0.5))
                }
                
                // Radio button
                Circle()
                    .strokeBorder(Color.appBlack, lineWidth: 2)
                    .background(
                        Circle()
                            .fill(isSelected ? Color.appBlack : Color.clear)
                    )
                    .frame(width: 24, height: 24)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
            .background(Color.white)
            .overlay(
                RoundedRectangle(cornerRadius: 30)
                    .stroke(isSelected ? Color.appTeal : Color.appBlack, lineWidth: isSelected ? 3 : 2)
            )
            .cornerRadius(30)
        }
        .buttonStyle(PlainButtonStyle())
    }
}
