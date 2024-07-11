//
//  MusicHelper.swift
//  GreatBellyfortune
//
//  Created by admin on 25.06.2024.
//

import AVFoundation

class MusicHelper {
    static let sharedHelper = MusicHelper()
    var audioPlayer: AVAudioPlayer?
    
    func playBackgroundMusic() {
        let aSound = NSURL(fileURLWithPath: Bundle.main.path(forResource: "background", ofType: "mp3")!)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf:aSound as URL)
            audioPlayer!.numberOfLoops = -1
            audioPlayer!.prepareToPlay()
            audioPlayer!.play()
            if let musicConf = UserDefaults.standard.value(forKey: "music") as? Bool {
                if musicConf {
                    audioPlayer?.setVolume(1, fadeDuration: 0)
                } else {
                    audioPlayer?.setVolume(0, fadeDuration: 0)
                }
            } else {
                UserDefaults.standard.setValue(true, forKey: "music")
            }
        } catch {
            print("Cannot play the file")
        }
    }
    
    func turnAudioPlayer() {
        guard let musicConf = UserDefaults.standard.value(forKey: "music") as? Bool else {
            UserDefaults.standard.setValue(false, forKey: "music")
            return
        }
        UserDefaults.standard.setValue(!musicConf, forKey: "music")
        if !musicConf {
            audioPlayer?.setVolume(1, fadeDuration: 0.5)
        } else {
            audioPlayer?.setVolume(0, fadeDuration: 0.5)
        }
    }
    
    func AudioisTurnedOn()  -> Bool {
        guard let musicConf = UserDefaults.standard.value(forKey: "music") as? Bool else {
            UserDefaults.standard.setValue(true, forKey: "music")
            return true
        }
        return musicConf
    }
}
