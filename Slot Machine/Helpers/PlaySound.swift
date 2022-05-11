//
//  PlaySound.swift
//  Slot Machine
//
//  Created by adam janusewski on 5/11/22.
//

import AVFoundation

var audioPlayer: AVAudioPlayer?

func playSound(sound: String, type: String) {
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
        audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
        audioPlayer?.play()
    } catch {
        print("ERROR: Could not find and play the file")
        }
    }
}
