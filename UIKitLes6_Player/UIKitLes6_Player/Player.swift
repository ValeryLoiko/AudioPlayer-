//
//  Player.swift
//  UIKitLes6_Player
//
//  Created by Diana on 11/08/2022.
//

import Foundation
import AVFoundation


class Player {
    
    
    static var player = AVAudioPlayer()
    
    static var currentSong = SongData.ak47Song
    
   static func updateCurrentSong(song: SongModel) {
        currentSong = song
  
        
    }
    
   static func playSong() {
        do {
            try Player.player = AVAudioPlayer(contentsOf: Player.currentSong.songURL())
            Player.player.play()
        } catch {
            print("Error")
        }
    }
}
