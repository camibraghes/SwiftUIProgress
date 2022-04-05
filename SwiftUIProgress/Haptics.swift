//
//  Haptics.swift
//  SwiftUIProgress
//
//  Created by Camelia Braghes on 05.04.2022.
//

import SwiftUI

class HapticManager {
    
    // Singleton
    static let instance = HapticManager()
    
    func notification(type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    func impact(style: UIImpactFeedbackGenerator.FeedbackStyle) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
}

struct Haptics: View {
    var body: some View {
        VStack(spacing: 20) {
            Button("success") {HapticManager.instance.notification(type: .success)}
            Button("warning") {HapticManager.instance.notification(type: .warning)}
            Button("error") {HapticManager.instance.notification(type: .error)}
            Divider()
            Button("soft") {HapticManager.instance.impact(style: .soft)}
            Button("light") {HapticManager.instance.impact(style: .light)}
            Button("medium") {HapticManager.instance.impact(style: .medium)}
            Button("rigid") {HapticManager.instance.impact(style: .rigid)}
            Button("heavy") {HapticManager.instance.impact(style: .heavy)}
        }
    }
}

struct Haptics_Previews: PreviewProvider {
    static var previews: some View {
        Haptics()
    }
}
