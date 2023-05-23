//
//  ViewController.swift
//  Music_player
//
//  Created by Игорь Пачкин on 9/5/23.
//

import UIKit
import AVFoundation


class ViewController: UIViewController {

    private let playlistLabel = UILabel()
    private let firstImage = UIImageView()
    private let firstNameLabel = UILabel()
    private let firstArtistLabel = UILabel()
    private let firstTimeLabel = UILabel()
    private let firstButton = UIButton()
    private var player = AVAudioPlayer()
    private let line1 = UIView()
    private let secondImage = UIImageView()
    private let secondNameLabel = UILabel()
    private let secondArtistLabel = UILabel()
    private var player2 = AVAudioPlayer()
    private let secondTimeLabel = UILabel()
    private let secondButton = UIButton()
    let trackIndex1 = 0
    let trackIndex2 = 1
    

    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        addSubviews()
        setConstraints()
       
    }
    
    override func viewDidLayoutSubviews() {
        firstImage.layer.cornerRadius = firstImage.bounds.width / 15
        secondImage.layer.cornerRadius = secondImage.bounds.width / 15
    }
    
    private func configureUI(){
        
        
        
        let greyColor = UIColor(red: 115/255, green: 115/255, blue: 118/255, alpha: 1)
        playlistLabel.text = "Playlist"
        firstImage.image = UIImage(named: "Dragonborn_img")
        firstImage.clipsToBounds = true
        firstNameLabel.contentMode = .scaleAspectFit
        
        firstNameLabel.text = "Dragonborn"
        firstNameLabel.textColor = .black
        firstNameLabel.font = UIFont.boldSystemFont(ofSize: 18.0)
       
        
        firstArtistLabel.text = "Big Baby Tape"
        firstArtistLabel.textColor = greyColor
        firstArtistLabel.font = .systemFont(ofSize: 14.0)
        
        do {
            if let audioPath = Bundle.main.path(forResource: "Dragonborn", ofType: "mp3"){
                try player = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath))
            }
        } catch {
            print("error")
        }
        let dur = player.duration
        var minutes = Int(dur / 60)
        var seconds = Int(dur.truncatingRemainder(dividingBy: 60))
        
        var formattedMinutes = String(format: "%02d", minutes)
        var formattedSeconds = String(format: "%02d", seconds)

        var formattedTime = "\(formattedMinutes):\(formattedSeconds)"
        
        firstTimeLabel.text = formattedTime
        firstTimeLabel.textColor = greyColor
        firstTimeLabel.font = .systemFont(ofSize: 18.0)
        
        firstButton.backgroundColor = .clear
        firstButton.addTarget(self, action: #selector(song1ButtonTapped), for: .touchUpInside)
        
        line1.backgroundColor = greyColor
        
        secondImage.image = UIImage(named: "Pablo_img")
        secondImage.clipsToBounds = true
        secondImage.contentMode = .scaleAspectFit
        
        
        secondNameLabel.text = "PABLO"
        secondNameLabel.textColor = .black
        secondNameLabel.font = UIFont.boldSystemFont(ofSize: 18.0)
        
        
        secondArtistLabel.text = "MORGRNSHTERN"
        secondArtistLabel.textColor = greyColor
        secondArtistLabel.font = .systemFont(ofSize: 14.0)
        
        do {
            if let audioPath = Bundle.main.path(forResource: "Pablo", ofType: "mp3") {
                try player2 = AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath))
            }
        } catch {
            print("Error loading audio file")
        }
        let dur2 = player2.duration
        minutes = Int(dur2 / 60)
        seconds = Int(dur2.truncatingRemainder(dividingBy: 60))
        
        formattedMinutes = String(format: "%02d", minutes)
        formattedSeconds = String(format: "%02d", seconds)

        formattedTime = "\(formattedMinutes):\(formattedSeconds)"
        
        secondTimeLabel.text = formattedTime
        secondTimeLabel.textColor = greyColor
        secondTimeLabel.font = .systemFont(ofSize: 18.0)
        
        secondButton.backgroundColor = .clear
        secondButton.addTarget(self, action: #selector(song2ButtonTapped), for: .touchUpInside)
        
    }
    

   
    private func addSubviews(){
        view.addSubview(playlistLabel)
        view.addSubview(firstImage)
        view.addSubview(firstNameLabel)
        view.addSubview(firstArtistLabel)
        view.addSubview(firstTimeLabel)
        view.addSubview(firstButton)
        view.addSubview(line1)
        view.addSubview(secondImage)
        view.addSubview(secondNameLabel)
        view.addSubview(secondArtistLabel)
        view.addSubview(secondTimeLabel)
        view.addSubview(secondButton)
    }
    
    private func setConstraints(){
        
        playlistLabel.translatesAutoresizingMaskIntoConstraints = false
        firstImage.translatesAutoresizingMaskIntoConstraints = false
        firstNameLabel.translatesAutoresizingMaskIntoConstraints = false
        firstArtistLabel.translatesAutoresizingMaskIntoConstraints = false
        firstTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        firstButton.translatesAutoresizingMaskIntoConstraints = false
        line1.translatesAutoresizingMaskIntoConstraints = false
        secondImage.translatesAutoresizingMaskIntoConstraints = false
        secondNameLabel.translatesAutoresizingMaskIntoConstraints = false
        secondArtistLabel.translatesAutoresizingMaskIntoConstraints = false
        secondTimeLabel.translatesAutoresizingMaskIntoConstraints = false
        secondButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
        playlistLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0.0),
        playlistLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor, constant: 0.0),
        playlistLabel.heightAnchor.constraint(equalToConstant: 25.0),
        
        firstImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150.0),
        firstImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15.0),
        firstImage.widthAnchor.constraint(equalToConstant: 100.0),
        firstImage.heightAnchor.constraint(equalToConstant: 100.0),
        
        firstNameLabel.topAnchor.constraint(equalTo: firstImage.topAnchor, constant: 0.0),
        firstNameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 135.0),
        
        firstArtistLabel.topAnchor.constraint(equalTo: firstNameLabel.topAnchor, constant: 30),
        firstArtistLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 135.0),
        
        firstTimeLabel.topAnchor.constraint(equalTo: firstArtistLabel.topAnchor, constant: 0.0),
        firstTimeLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15.0),
        
        firstButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 150.0),
        firstButton.heightAnchor.constraint(equalToConstant: 100.0),
        firstButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15.0),
        firstButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15.0),
        
        line1.topAnchor.constraint(equalTo: firstImage.bottomAnchor, constant: 10.0),
        line1.heightAnchor.constraint(equalToConstant: 1.0),
        line1.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15),
        line1.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15.0),
        
        secondImage.topAnchor.constraint(equalTo: line1.bottomAnchor, constant: 10.0),
        secondImage.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15.0),
        secondImage.widthAnchor.constraint(equalToConstant: 100.0),
        secondImage.heightAnchor.constraint(equalToConstant: 100.0),
        
        secondNameLabel.topAnchor.constraint(equalTo: secondImage.topAnchor, constant: 0),
        secondNameLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 135.0),
        
       
        secondArtistLabel.topAnchor.constraint(equalTo: secondNameLabel.topAnchor, constant: 30.0),
        secondArtistLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 135.0),
        
        secondTimeLabel.topAnchor.constraint(equalTo: secondArtistLabel.topAnchor, constant: 0.0),
        secondTimeLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15.0),
        
        secondButton.topAnchor.constraint(equalTo: secondImage.topAnchor, constant: 0),
        secondButton.heightAnchor.constraint(equalToConstant: 100.0),
        secondButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 15.0),
        secondButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -15.0),
        
        ])
    }
    
    @objc func song1ButtonTapped() {
        if let audioPath = Bundle.main.path(forResource: "Dragonborn", ofType: "mp3") {
            addButtonTapped(withAudioPath: audioPath, image: firstImage.image, name: firstNameLabel.text ?? "", artist: firstArtistLabel.text ?? "", TrackIndex: trackIndex1)
        }
    }

    @objc func song2ButtonTapped() {
        if let audioPath = Bundle.main.path(forResource: "Pablo", ofType: "mp3") {
            addButtonTapped(withAudioPath: audioPath, image: secondImage.image, name:  secondNameLabel.text ?? "", artist: secondArtistLabel.text ?? "", TrackIndex: trackIndex2)
        }
    }

    @objc func addButtonTapped(withAudioPath audioPath: String, image: UIImage?, name: String, artist: String, TrackIndex: Int){
        do {
            let player = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioPath))
            let secondVC = ViewController2()
            secondVC.player = player
            secondVC.imageee = image
            secondVC.nameLabel.text = name
            secondVC.artistLabel.text = artist
            secondVC.modalPresentationStyle = .formSheet
            secondVC.currentTrackIndex = TrackIndex
            secondVC.playSong()
            present(secondVC, animated: true, completion: nil)
            } catch {
                print("Error")
            }
        
    }
    

}

