//
//  SoundsView.swift
//  SwiftUIProgress
//
//  Created by Camelia Braghes on 04.04.2022.
//

import SwiftUI
import AVKit

class SoundManager: ObservableObject {
    
    enum SoundOption: String {
        case tada
        case xylophone
    }
    
    static let instance = SoundManager()
    
    var player: AVAudioPlayer?
    
    func playSound(sound: SoundOption ) {
        guard let url = Bundle.main.url(forResource: sound.rawValue , withExtension: "mp3") else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print("Error playing sound.\(error.localizedDescription)")
        }
    }
}

struct SoundsView: View {
    
    var body: some View {
        VStack(spacing: 30) {
            Button("PLay sound 1") {
                SoundManager.instance.playSound(sound: .tada)
            }
            Button("PLay sound 2") {
                SoundManager.instance.playSound(sound: .xylophone)
            }
        }
    }
}

struct SoundsView_Previews: PreviewProvider {
    static var previews: some View {
        SoundsView()
    }
}
