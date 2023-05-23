//
//  ViewController2.swift
//  Music_player
//
//  Created by Игорь Пачкин on 9/5/23.
//

import UIKit
import AVFoundation

class ViewController2: UIViewController {
    
    var player: AVAudioPlayer?
    private var navBar = UINavigationBar()
    private var albumImage = UIImageView()
    var imageee: UIImage?
    lazy var slider: UISlider = {
            let slider = UISlider()
            slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
            return slider
        }()
    lazy var sliderVolum: UISlider = {
            let slider2 = UISlider()
            slider2.addTarget(self, action: #selector(volumSlider), for: .valueChanged)
        
            let currentVolume = AVAudioSession.sharedInstance().outputVolume
            slider2.value = currentVolume
            
            return slider2
        }()
    lazy var playPause: UIButton = {
            let button = UIButton(type: .system)
            button.setImage(pauseImage, for: .normal)
            button.tintColor = .black
            button.addTarget(self, action: #selector(playButtonTapped), for: .touchUpInside)
            return button
        }()
    let volumeLImageView = UIImageView()
    let volumeHImageView = UIImageView()
    private let nextButton = UIButton()
    private let nextImage = UIImage(named: "Next")
    private let pastButton = UIButton()
    private let pastImage = UIImage(named: "Past")
    private let shuffleButton = UIButton()
    private let shuffleImage = UIImage(named: "Shuffle")
    var arr = ["Dragonborn","Pablo"]
    var nameLabel = UILabel()
    var artistLabel = UILabel()
    private let playImage = UIImage(named: "Play")
    private let pauseImage = UIImage(named: "Pause")
    lazy var startTimeLabel: UILabel = {
            let label = UILabel()
            label.textAlignment = .center
            return label
        }()
        
    lazy var endTimeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        return label
    }()
    var timer: Timer?
    
    var shareButton = UIButton()
    var currentTrackIndex: Int = 0

    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addSubviews()
        setConstraints()
        view.backgroundColor = .white
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupPlayer()
    }
    
    override func viewDidLayoutSubviews() {
        albumImage.layer.cornerRadius = albumImage.bounds.width / 50
    }
    
    private func configureUI(){
        
        volumeLImageView.image = UIImage(named: "VolumeL")
        volumeHImageView.image = UIImage(named: "VolumeH")
        
        playPause.isHighlighted = false

        startTimeLabel.text = "00:00"
        endTimeLabel.text = "00:00"
        if let audioPath = Bundle.main.path(forResource: "Song", ofType: "mp3") {
                do {
                    player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath))
                } catch {
                    print("Error initializing audio player: \(error)")
                }
            }
        
        let greyColor = UIColor(red: 115/255, green: 115/255, blue: 118/255, alpha: 1)
        
        //навигейшен бар
        navigationController?.navigationBar.isHidden = false
        navBar = UINavigationBar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 40))
        let navItem = UINavigationItem(title: "")
        let closeButton = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(closeButtonTapped))
        let shareButton = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareButtonTapped))
        navItem.leftBarButtonItem = closeButton
        navItem.rightBarButtonItem = shareButton
        navBar.setItems([navItem], animated: false)
        
        
        albumImage.contentMode = .scaleAspectFill
        albumImage.layer.masksToBounds = true
        albumImage.clipsToBounds = true
        albumImage.layer.borderColor = UIColor.gray.cgColor
        albumImage.image = imageee
        
        nameLabel.font = UIFont.boldSystemFont(ofSize: 20.0)
        nameLabel.textColor = .black
        
        artistLabel.font = .systemFont(ofSize: 16.0)
        artistLabel.textColor = greyColor
        
        slider.setThumbImage(UIImage(), for: .normal)
        slider.setThumbImage(UIImage(), for: .highlighted)
        
        sliderVolum.setThumbImage(UIImage(), for: .normal)
        sliderVolum.setThumbImage(UIImage(), for: .highlighted)
        
        nextButton.setImage(nextImage, for: .normal)
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        pastButton.setImage(pastImage, for: .normal)
        pastButton.addTarget(self, action: #selector(previousButtonTapped), for: .touchUpInside)
        shuffleButton.setImage(shuffleImage, for: .normal)
    }
    
    func playSong() {
        player?.play()
    }
    
    private func addSubviews(){
        view.addSubview(navBar)
        view.addSubview(albumImage)
        view.addSubview(slider)
        view.addSubview(playPause)
        view.addSubview(nextButton)
        view.addSubview(pastButton)
        view.addSubview(shuffleButton)
        view.addSubview(nameLabel)
        view.addSubview(artistLabel)
        view.addSubview(startTimeLabel)
        view.addSubview(endTimeLabel)
        view.addSubview(sliderVolum)
        view.addSubview(volumeLImageView)
        view.addSubview(volumeHImageView)
    }
    private func setConstraints(){
        albumImage.translatesAutoresizingMaskIntoConstraints = false
        slider.translatesAutoresizingMaskIntoConstraints = false
        playPause.translatesAutoresizingMaskIntoConstraints = false
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        pastButton.translatesAutoresizingMaskIntoConstraints = false
        shuffleButton.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        artistLabel.translatesAutoresizingMaskIntoConstraints = false
        startTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        endTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        sliderVolum.translatesAutoresizingMaskIntoConstraints = false
        volumeLImageView.translatesAutoresizingMaskIntoConstraints = false
        volumeHImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            albumImage.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: -170.0),
            albumImage.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            albumImage.widthAnchor.constraint(equalToConstant: 300.0),
            albumImage.heightAnchor.constraint(equalToConstant: 300.0),
            
            nameLabel.topAnchor.constraint(equalTo: albumImage.bottomAnchor, constant: 40.0),
            nameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            
            artistLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 10.0),
            artistLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
            
            slider.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor, constant: 100.0),
            slider.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15.0),
            slider.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15.0),
            
            startTimeLabel.topAnchor.constraint(equalTo: slider.topAnchor, constant: 10.0),
            startTimeLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15.0),
            
            endTimeLabel.topAnchor.constraint(equalTo: slider.topAnchor, constant: 10.0),
            endTimeLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15.0),
            
            playPause.topAnchor.constraint(equalTo: slider.topAnchor, constant: 70.0),
            playPause.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            playPause.widthAnchor.constraint(equalToConstant: 50.0),
            playPause.heightAnchor.constraint(equalToConstant: 50.0),
            
            nextButton.topAnchor.constraint(equalTo: slider.topAnchor, constant: 70.0),
            nextButton.rightAnchor.constraint(equalTo: playPause.rightAnchor, constant: 90.0),
            nextButton.widthAnchor.constraint(equalToConstant: 50.0),
            nextButton.heightAnchor.constraint(equalToConstant: 50.0),
            
            pastButton.topAnchor.constraint(equalTo: slider.topAnchor, constant: 70.0),
            pastButton.leftAnchor.constraint(equalTo: playPause.leftAnchor, constant: -90.0),
            pastButton.widthAnchor.constraint(equalToConstant: 50.0),
            pastButton.heightAnchor.constraint(equalToConstant: 50.0),
            
            shuffleButton.topAnchor.constraint(equalTo: slider.topAnchor, constant: 85.0),
            shuffleButton.leftAnchor.constraint(equalTo: playPause.leftAnchor, constant: -145.0),
            shuffleButton.widthAnchor.constraint(equalToConstant: 25.0),
            shuffleButton.heightAnchor.constraint(equalToConstant: 25.0),
            
            sliderVolum.topAnchor.constraint(equalTo: playPause.topAnchor, constant: 70.0),
            sliderVolum.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 30.0),
            sliderVolum.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -30.0),
            
            volumeLImageView.topAnchor.constraint(equalTo: playPause.topAnchor, constant: 75.0),
            volumeLImageView.leftAnchor.constraint(equalTo: sliderVolum.leftAnchor, constant: 0.0),
            volumeLImageView.widthAnchor.constraint(equalToConstant: 25.0),
            volumeLImageView.heightAnchor.constraint(equalToConstant: 25.0),
            
            volumeHImageView.topAnchor.constraint(equalTo: playPause.topAnchor, constant: 75.0),
            volumeHImageView.rightAnchor.constraint(equalTo: sliderVolum.rightAnchor, constant: 0.0),
            volumeHImageView.widthAnchor.constraint(equalToConstant: 25.0),
            volumeHImageView.heightAnchor.constraint(equalToConstant: 25.0),
        
        ])
    }
    
    @objc func closeButtonTapped() {
        dismiss(animated: true, completion: nil)
        player?.pause()
    }
    
    @objc func volumSlider(){
        player?.volume = sliderVolum.value
    }
    
    @objc func playButtonTapped() {
        if let player = player {
            if player.isPlaying {
                player.pause()
                playPause.setImage(playImage, for: .normal)
            } else {
                player.play()
                playPause.setImage(pauseImage, for: .normal)
            }
        }
    }
    func setupPlayer() {
            if let player = player {
                slider.maximumValue = Float(player.duration)
                endTimeLabel.text = formatTime(player.duration)
                
                // Запускаем таймер для обновления слайдера и меток времени
                timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateSliderAndTimeLabels), userInfo: nil, repeats: true)
            }
        }
        
        @objc func updateSliderAndTimeLabels() {
            if let player = player {
                let currentTime = Float(player.currentTime)
                slider.value = currentTime
                startTimeLabel.text = formatTime(player.currentTime)
            }
        }
        
        @objc func sliderValueChanged(_ sender: UISlider) {
            if let player = player {
                player.currentTime = TimeInterval(sender.value)
                startTimeLabel.text = formatTime(player.currentTime)
            }
        }
        
        // Форматирование времени в формат "мм:сс"
        func formatTime(_ time: TimeInterval) -> String {
            let minutes = Int(time) / 60
            let seconds = Int(time) % 60
            return String(format: "%02d:%02d", minutes, seconds)
        }
    @objc func shareButtonTapped() {
        guard let trackName = nameLabel.text else {
            return
        }
        
        let activityViewController = UIActivityViewController(activityItems: [trackName], applicationActivities: nil)
        present(activityViewController, animated: true, completion: nil)
    }

    @objc func nextButtonTapped() {
        currentTrackIndex += 1
        if currentTrackIndex >= arr.count {
            currentTrackIndex = 0
        }
        updateTrackInfo()
    }

    @objc func previousButtonTapped() {
        currentTrackIndex -= 1
        if currentTrackIndex < 0 {
            currentTrackIndex = arr.count - 1
        }
        updateTrackInfo()
    }

    func updateTrackInfo() {
        let track = arr[currentTrackIndex]
        nameLabel.text = track
        artistLabel.text = getArtistName(for: track)
        albumImage.image = getAlbumImage(for: track)
        if let audioPath = Bundle.main.path(forResource: arr[currentTrackIndex], ofType: "mp3") {
         do {
             self.player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath))
             self.player?.play()
         } catch {
             print("Error initializing audio player: \(error)")
         }
    }

    func getArtistName(for track: String) -> String {
        // Здесь возвращаем имя исполнителя для данного трека
        // Например:
        if track == "Dragonborn" {
            return "Big Baby Tape"
        } else if track == "Pablo" {
            return "MORGRNSHTERN"
        } else {
            return "Неизвестный исполнитель"
        }
    }

    func getAlbumImage(for track: String) -> UIImage? {
        // Здесь возвращаем изображение альбома для данного трека
        // Например:
        if track == "Dragonborn" {
            return UIImage(named: "Dragonborn_img")
        } else if track == "Pablo" {
            return UIImage(named: "Pablo_img")
        } else {
            return nil
        }
    }



  }
    
}
