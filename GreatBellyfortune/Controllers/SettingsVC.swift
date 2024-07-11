//
//  SettingsVC.swift
//  GreatBellyfortune
//
//  Created by admin on 25.06.2024.
//

import UIKit

class SettingsVC: UIViewController {
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    let soundButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: MusicHelper.sharedHelper.AudioisTurnedOn() ? "btn_sound_on" : "btn_sound_off"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    let backButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "btn_back"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "logo_jb")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundView = UIImageView(frame: view.frame)
        backgroundView.image = UIImage(named: "bg_1")
        backgroundView.contentMode = .scaleAspectFill
        view.addSubview(backgroundView)
        setupButtons()
    }
    
    func setupButtons() {
        view.addSubview(logoImageView)
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            logoImageView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            logoImageView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            logoImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
        
        view.addSubview(soundButton)
        NSLayoutConstraint.activate([
            soundButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            soundButton.widthAnchor.constraint(equalToConstant: 80),
            soundButton.heightAnchor.constraint(equalToConstant: 80),
            soundButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
        
        soundButton.addAction(UIAction() {
            _ in
            Vibration.light.vibrate()
            MusicHelper.sharedHelper.turnAudioPlayer()
            self.soundButton.setImage(UIImage(named: MusicHelper.sharedHelper.AudioisTurnedOn() ? "btn_sound_on" : "btn_sound_off"), for: .normal)
        }, for: .touchUpInside)
        
        view.addSubview(backButton)
        NSLayoutConstraint.activate([
            backButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            backButton.widthAnchor.constraint(equalToConstant: 100),
            backButton.heightAnchor.constraint(equalToConstant: 80),
            backButton.topAnchor.constraint(equalTo: soundButton.bottomAnchor, constant: 20)
        ])
        backButton.addAction(UIAction() {
            _ in
            self.dismiss(animated: true)
        }, for: .touchUpInside)
    }
    
}
