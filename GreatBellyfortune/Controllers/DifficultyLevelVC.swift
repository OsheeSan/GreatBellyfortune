//
//  DifficultyLevelVC.swift
//  GreatBellyfortune
//
//  Created by admin on 27.06.2024.
//

import UIKit

class DifficultyLevelVC: UIViewController {
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    let easyButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "btn_easy"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    let mediumButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "btn_medium"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    let hardButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "btn_hard"), for: .normal)
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
        
        view.addSubview(easyButton)
        NSLayoutConstraint.activate([
            easyButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            easyButton.widthAnchor.constraint(equalToConstant: 350),
            easyButton.heightAnchor.constraint(equalToConstant: 60),
            easyButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
        
        easyButton.addAction(UIAction() {
            _ in
            Vibration.light.vibrate()
            let vc = WheelViewController()
            vc.difficulty = 1
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }, for: .touchUpInside)
        
        view.addSubview(mediumButton)
        NSLayoutConstraint.activate([
            mediumButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            mediumButton.widthAnchor.constraint(equalToConstant: 350),
            mediumButton.heightAnchor.constraint(equalToConstant: 60),
            mediumButton.topAnchor.constraint(equalTo: easyButton.bottomAnchor, constant: 8)
        ])
        
        mediumButton.addAction(UIAction() {
            _ in
            Vibration.light.vibrate()
            
            let vc = WheelViewController()
            vc.difficulty = 2
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }, for: .touchUpInside)
        
        view.addSubview(hardButton)
        NSLayoutConstraint.activate([
            hardButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            hardButton.widthAnchor.constraint(equalToConstant: 350),
            hardButton.heightAnchor.constraint(equalToConstant: 60),
            hardButton.topAnchor.constraint(equalTo: mediumButton.bottomAnchor, constant: 8)
        ])
        
        hardButton.addAction(UIAction() {
            _ in
            Vibration.light.vibrate()
            let vc = WheelViewController()
            vc.difficulty = 3
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }, for: .touchUpInside)
        
        view.addSubview(backButton)
        NSLayoutConstraint.activate([
            backButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            backButton.widthAnchor.constraint(equalToConstant: 100),
            backButton.heightAnchor.constraint(equalToConstant: 60),
            backButton.topAnchor.constraint(equalTo: hardButton.bottomAnchor, constant: 20)
        ])
        
        backButton.addAction(UIAction() {
            _ in
            self.dismiss(animated: true)
        }, for: .touchUpInside)
    }
    
}
