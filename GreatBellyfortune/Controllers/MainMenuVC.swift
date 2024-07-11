//
//  MainMenuVC.swift
//  GreatBellyfortune
//
//  Created by admin on 18.06.2024.
//

import UIKit

class MainMenuVC: UIViewController {
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    let playButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "btn_play"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    let shopButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "btn_shop"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    let settingsButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "btn_settings"), for: .normal)
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
    
    let coinsLabel: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: "label_coins"), for: .normal)
        button.titleLabel?.font = UIFont(name: "LilitaOne", size: 26)
        button.setTitleColor(.brown, for: .normal)
        button.setTitle("\(BellyManager.getCoins())", for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let backgroundView = UIImageView(frame: view.frame)
        backgroundView.image = UIImage(named: "bg_1")
        backgroundView.contentMode = .scaleAspectFill
        view.addSubview(backgroundView)
        setupButtons()
        MusicHelper.sharedHelper.playBackgroundMusic()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        coinsLabel.setTitle("\(BellyManager.getCoins())", for: .normal)
    }
    
    func setupButtons() {
        view.addSubview(logoImageView)
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            logoImageView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            logoImageView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            logoImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
        
        view.addSubview(playButton)
        NSLayoutConstraint.activate([
            playButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            playButton.widthAnchor.constraint(equalToConstant: 300),
            playButton.heightAnchor.constraint(equalToConstant: 60),
            playButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
        
        playButton.addAction(UIAction() {
            _ in
            Vibration.light.vibrate()
            let vc = ModeVC()
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }, for: .touchUpInside)
        
        view.addSubview(shopButton)
        NSLayoutConstraint.activate([
            shopButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            shopButton.widthAnchor.constraint(equalToConstant: 300),
            shopButton.heightAnchor.constraint(equalToConstant: 60),
            shopButton.topAnchor.constraint(equalTo: playButton.bottomAnchor, constant: 20)
        ])
        
        shopButton.addAction(UIAction() {
            _ in
            let vc = ShopVC()
            Vibration.light.vibrate()
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }, for: .touchUpInside)
        
        view.addSubview(settingsButton)
        NSLayoutConstraint.activate([
            settingsButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            settingsButton.widthAnchor.constraint(equalToConstant: 300),
            settingsButton.heightAnchor.constraint(equalToConstant: 60),
            settingsButton.topAnchor.constraint(equalTo: shopButton.bottomAnchor, constant: 20)
        ])
        
        settingsButton.addAction(UIAction() {
            _ in
            let vc = SettingsVC()
            Vibration.light.vibrate()
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }, for: .touchUpInside)
        
        view.addSubview(coinsLabel)
        NSLayoutConstraint.activate([
            coinsLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            coinsLabel.widthAnchor.constraint(equalToConstant: 350),
            coinsLabel.heightAnchor.constraint(equalToConstant: 60),
            coinsLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8)
        ])
    }
    
}
