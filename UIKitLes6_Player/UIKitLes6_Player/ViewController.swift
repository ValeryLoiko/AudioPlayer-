//
//  ViewController.swift
//  UIKitLes6_Player
//
//  Created by Diana on 10/08/2022.
//

import UIKit

class ViewController: UIViewController {
    
    var ak47Image = UIImageView()
    var eminemImage = UIImageView()
    var gufImage = UIImageView()
    var ak47Label = UILabel()
    var eminemLabel = UILabel()
    var gufLabel = UILabel()
  

    let songViewController = SongViewController()
    let player = Player()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .orange
        
        configureImages()
        configureLabels()
    }
    

    private func configureImages() {
       
        ak47Image = createImage(named: SongData.ak47Song.imageName)
        ak47Image.frame.origin = CGPoint(x: view.frame.minX + 20, y: view.frame.minY + 100)
        addGestureToAK47()
        view.addSubview(ak47Image)
        
        eminemImage = createImage(named: SongData.eminemSong.imageName)
        eminemImage.frame.origin = CGPoint(x: ak47Image.frame.minX, y: ak47Image.frame.maxY + 20)
       addGestureEminem()
        view.addSubview(eminemImage)
        
        gufImage = createImage(named: SongData.gufSong.imageName)
        gufImage.frame.origin = CGPoint(x: ak47Image.frame.minX, y: eminemImage.frame.maxY + 20)
        addGEstureGuf()
        view.addSubview(gufImage)
    }
    
    private func configureLabels() {
        ak47Label = createLabel(title: SongData.ak47Song.songName)
        ak47Label.frame.origin = CGPoint(x: ak47Image.frame.maxX + 30,
                                         y: ak47Image.frame.midY - ak47Label.frame.height / 2)
        view.addSubview(ak47Label)
        
        eminemLabel = createLabel(title: SongData.eminemSong.songName)
        eminemLabel.frame.origin = CGPoint(x: eminemImage.frame.maxX + 30,
                                           y: eminemImage.frame.midY - eminemLabel.frame.height / 2)
        view.addSubview(eminemLabel)
        
        gufLabel = createLabel(title: SongData.gufSong.songName)
        gufLabel.frame.origin = CGPoint(x: gufImage.frame.maxX + 30,
                                        y: gufImage.frame.midY - gufLabel.frame.height / 2)
        view.addSubview(gufLabel)
    }
    
    private func addGestureToAK47() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(showNextVCForAK47))
        ak47Image.isUserInteractionEnabled = true
        ak47Image.addGestureRecognizer(gesture)
        
    }
    
    private func addGestureEminem() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(showNextVCForEminem))
        eminemImage.isUserInteractionEnabled = true
        eminemImage.addGestureRecognizer(gesture)
    }
    
    private func addGEstureGuf() {
        let gesture = UITapGestureRecognizer(target: self, action: #selector(showNextVCGuf))
        gufImage.isUserInteractionEnabled = true
        gufImage.addGestureRecognizer(gesture)
    }
    
    @objc
    private func showNextVCGuf() {
        let secondVC = SongViewController()
        present(secondVC, animated: true, completion: nil)
        Player.updateCurrentSong(song: SongData.gufSong)
        Player.playSong()
        print(Player.currentSong)
    }
    
    @objc
    private func showNextVCForAK47() {
        let secondVC = SongViewController()
        present(secondVC, animated: true, completion: nil)
        Player.updateCurrentSong(song: SongData.ak47Song)
        Player.playSong()
        print(Player.currentSong)
    }
    
    @objc
    private func showNextVCForEminem() {
        let secondVC = SongViewController()
        present(secondVC, animated: true, completion: nil)
        Player.updateCurrentSong(song: SongData.eminemSong)
        Player.playSong()
        print(Player.currentSong)
    }
}


private func createLabel(title name: String) -> UILabel {
    let label = UILabel()
    label.frame.size = CGSize(width: 150, height: 30)
    label.text = name
    label.font = label.font.withSize(18)
    label.font = UIFont.preferredFont(forTextStyle: .headline)
    return label
}

private func createImage(named name: String) -> UIImageView {
    let image = UIImageView()
    image.image = UIImage(named: name)
    image.frame.size = CGSize(width: 90, height: 70)
    image.contentMode = .scaleAspectFit
    return image
}

