//
//  SongViewController.swift
//  UIKitLes6_Player
//
//  Created by Diana on 11/08/2022.
//

import UIKit

class SongViewController: UIViewController {
    
    var songImage = UIImageView()
    var songLabel = UILabel()
    var playButton = UIButton()
    var nextButton = UIButton()
    var backButton = UIButton()
    var slider = UISlider()
    var leftTimeLabel = UILabel()
    var rightTimeLabel = UILabel()
    var volumeSlider = UISlider()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        addSongImage()
        addSongLabel()
        addSlider()
        addLeftLabel()
        addRightLabel()
        addPlayButton()
        addNextButton()
        addBackButton()
        addVolumeSlider()
        
        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(trackAudio), userInfo: nil, repeats: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateSongInfo()
    }
    
    internal func updateSongInfo() {
        songImage.image = UIImage(named: Player.currentSong.imageName)
        songLabel.text = Player.currentSong.songName
        leftTimeLabel.text = realTimaSong()
        rightTimeLabel.text = restTimeSong()
      
    }
    
    private func addLeftLabel() {
        leftTimeLabel = configureTimeLabels()
        leftTimeLabel.frame.origin = CGPoint(x: slider.frame.minX,
                                             y: slider.frame.minY - leftTimeLabel.frame.height + 15)
        leftTimeLabel.text = "12:12"
        view.addSubview(leftTimeLabel)
    }
    
    private func addRightLabel() {
        rightTimeLabel = configureTimeLabels()
        rightTimeLabel.frame.origin = CGPoint(x: slider.frame.maxX - rightTimeLabel.frame.width,
                                              y: slider.frame.minY - rightTimeLabel.frame.height + 15)
        rightTimeLabel.text = "34:34"
        view.addSubview(rightTimeLabel)
    }
    
    private func addSongImage() {
        songImage = configureImage()
        songImage.frame.origin = CGPoint(x: view.frame.midX - songImage.frame.width / 2,
                                         y: view.frame.minY + 50)
        view.addSubview(songImage)
    }
    
    private func addSongLabel() {
        songLabel = configureTitle()
        songLabel.frame.origin = CGPoint(x: songImage.frame.midX - songLabel.frame.width / 2,
                                         y: songImage.frame.maxY + 10)
        view.addSubview(songLabel)
    }
    
    private func addSlider() {
        slider = configureSlider()
        slider.frame.origin = CGPoint(x: view.frame.midX - slider.frame.width / 2,
                                      y: songLabel.frame.maxY + 30)
        slider.maximumValue = Float(Player.player.duration)
        slider.minimumValue = 0.0
        slider.addTarget(self, action: #selector(changeSlider), for: .valueChanged)
        view.addSubview(slider)
    }
    
    private func addVolumeSlider() {
        volumeSlider = configureSlider()
        volumeSlider.frame.size = CGSize(width: 250, height: 25)
        volumeSlider.frame.origin = CGPoint(x: view.frame.midX - volumeSlider.frame.width / 2,
                                            y: playButton.frame.maxY + 10)
        volumeSlider.minimumValueImage = UIImage(systemName: "volume.1.fill")
        volumeSlider.maximumValueImage = UIImage(systemName: "volume.3.fill")
        volumeSlider.minimumValue = 0.0
        volumeSlider.maximumValue = 100.0
        volumeSlider.addTarget(self, action: #selector(changeVolume), for: .valueChanged)
        view.addSubview(volumeSlider)
    }
    
    private func addPlayButton() {
        playButton = configureButton()
        playButton.frame.origin = CGPoint(x: view.frame.midX - playButton.frame.width / 2,
                                          y: slider.frame.maxY + 20)
        self.view.addSubview(playButton)
    }
    
    private func addNextButton() {
        nextButton = configureNextBackButton(setImage: "forward.end.fill")
        nextButton.frame.origin = CGPoint(x: playButton.frame.maxX + nextButton.frame.width / 4,
                                          y: playButton.frame.midY - nextButton.frame.height / 2)
        nextButton.addTarget(self, action: #selector(nextSong), for: .touchUpInside)
        view.addSubview(nextButton)
        
        
    }
    private func addBackButton() {
        backButton = configureNextBackButton(setImage: "backward.end.fill")
        backButton.frame.origin = CGPoint(x: playButton.frame.minX - backButton.frame.width * 1.25,
                                          y: playButton.frame.midY - backButton.frame.height / 2)
        backButton.addTarget(self, action: #selector(previousSong), for: .touchUpInside)
        view.addSubview(backButton)
    }
    
    private func configureSlider() -> UISlider {
        let slider = UISlider()
        slider.frame.size = CGSize(width: 300, height: 30)
        return slider
    }
    
    private func configureNextBackButton(setImage name: String) -> UIButton {
        let button = UIButton()
        button.frame.size = CGSize(width: 60, height: 60)
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 60, weight: .bold, scale: .large)
        let image = UIImage(systemName: name, withConfiguration: largeConfig)
        button.setImage(image, for: .normal)
        return button
    }
    
    private func configureButton() -> UIButton {
        let button = UIButton(type: .custom)
        button.tag = 0
        button.frame.size = CGSize(width: 100, height: 100)
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 100, weight: .bold, scale: .large)
        let imagePlay = UIImage(systemName: "play.circle.fill", withConfiguration: largeConfig)
        button.setImage(imagePlay, for: .normal)
        button.addTarget(self, action: #selector(tapPlay(button:)), for: .touchUpInside)
        return button
    }
    
    private func configureTitle() -> UILabel {
        let label = UILabel()
        label.frame.size = CGSize(width: 300, height: 40)
        label.font = UIFont.boldSystemFont(ofSize: 25)
        label.textAlignment = .center
        return label
    }
    private func configureTimeLabels() -> UILabel {
        let label = UILabel()
        label.frame.size = CGSize(width: 50, height: 15)
        label.textColor = .darkGray
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textAlignment = .natural
        return label
    }
    
    private func configureImage() -> UIImageView{
        let image = UIImageView()
        image.frame.size = CGSize(width: 300, height: 300)
        image.contentMode = .scaleAspectFit
        return image
    }
    
    @objc
    private func trackAudio() {
        slider.value = Float(Player.player.currentTime)
        leftTimeLabel.text = realTimaSong()
        rightTimeLabel.text = restTimeSong()
    }
    
    private func realTimaSong() -> String {
        let currentTime = Int(Player.player.currentTime)
        let minutes = currentTime / 60
        let seconds = currentTime - minutes * 60
        return NSString(format: "%02d:%02d", minutes, seconds) as String
    }
    
    private func restTimeSong() -> String {
        let duration = Int(Player.player.duration - Player.player.currentTime)
        let minutes = duration / 60
        let seconds = duration - minutes * 60
        return NSString(format: "%02d:%02d", minutes, seconds) as String
    }
    
    @objc
    private func tapPlay(button: UIButton) {
        let largeConfig = UIImage.SymbolConfiguration(pointSize: 100, weight: .bold, scale: .large)
        
        switch button.tag {
        case 0:
            Player.player.pause()
            let imagePause = UIImage(systemName: "pause.circle.fill", withConfiguration: largeConfig)
            button.setImage(imagePause, for: .normal)
            button.tag = 1
        case 1:
            Player.player.play()
            let imagePlay = UIImage(systemName: "play.circle.fill", withConfiguration: largeConfig)
            button.setImage(imagePlay, for: .normal)
            button.tag = 0
        default:
            print("hz")
        }
    }
    
    @objc
    private func changeSlider() {
        Player.player.currentTime = TimeInterval(self.slider.value)
    }
    
    @objc
    private func changeVolume() {
        Player.player.volume = volumeSlider.value
    }
    
    @objc
    private func nextSong() {
        switch Player.currentSong.songName {
        case SongData.ak47Song.songName:
            Player.updateCurrentSong(song: SongData.eminemSong)
            updateSongInfo()
            Player.playSong()
        case SongData.eminemSong.songName:
            Player.updateCurrentSong(song: SongData.gufSong)
            updateSongInfo()
            Player.playSong()
        case SongData.gufSong.songName:
            Player.updateCurrentSong(song: SongData.ak47Song)
            updateSongInfo()
            Player.playSong()
        default:
            Player.updateCurrentSong(song: SongData.eminemSong)
            updateSongInfo()
            Player.playSong()
        }
    }
    
    @objc
    private func previousSong() {
        switch Player.currentSong.songName {
        case SongData.ak47Song.songName:
            Player.updateCurrentSong(song: SongData.gufSong)
            updateSongInfo()
            Player.playSong()
        case SongData.gufSong.songName:
            Player.updateCurrentSong(song: SongData.eminemSong)
            updateSongInfo()
            Player.playSong()
        case SongData.eminemSong.songName:
            Player.updateCurrentSong(song: SongData.ak47Song)
            updateSongInfo()
            Player.playSong()
        default:
            Player.updateCurrentSong(song: SongData.ak47Song)
            updateSongInfo()
            Player.playSong()
        }
    }
}
