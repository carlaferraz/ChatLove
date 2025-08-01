//
//  SoundManager.swift
//  chatlove
//
//  Created by Carla Araujo on 31/07/25.
//

import AVKit

class SoundManager{
    static let instance = SoundManager()
    var player: AVAudioPlayer?
    
    enum SoundOption: String{
        case calling = "calling"
        case voice = "vozChat"
    }
    
    func playSound(sound: SoundOption){
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: ".mp3") else {return}
        do{
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print("deu ruim aqui no som \(error.localizedDescription)")
        }
        
    }
}
