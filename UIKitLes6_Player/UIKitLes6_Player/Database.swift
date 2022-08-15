//
//  Database.swift
//  UIKitLes6_Player
//
//  Created by Diana on 10/08/2022.
//

import Foundation


struct SongModel {
    let imageName: String
    let songName: String
    let number: Int
    
    lazy var songPath = Bundle.main.path(forResource: songName, ofType: "mp3")
    
    mutating func songURL() -> URL {
        return URL(fileURLWithPath: songPath!)
    }
}

class SongData {
    static var songArray: [SongModel] = []
    
       static let ak47Song = SongModel(imageName: "ak47", songName: "Всем кто с нами", number: 0)
       static let gufSong = SongModel(imageName: "guf", songName: "Город дорог", number: 1)
       static let eminemSong = SongModel(imageName: "eminem", songName: "Lose yourself", number: 2)
    
    init() {
        setup()
    }
    private func setup() {
        SongData.songArray.append(SongData.ak47Song)
        SongData.songArray.append(SongData.eminemSong)
        SongData.songArray.append(SongData.gufSong)
    }
}

