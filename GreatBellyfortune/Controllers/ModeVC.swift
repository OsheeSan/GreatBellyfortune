//
//  ModeVC.swift
//  GreatBellyfortune
//
//  Created by admin on 25.06.2024.
//

import UIKit

class ModeVC: UIViewController {
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    let bellyButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "btn_belly"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    let infiniteButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "btn_infinite"), for: .normal)
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
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
            if UserDefaults.standard.value(forKey: "mode") == nil {
                self.showOverlay()
                UserDefaults.standard.setValue(true, forKey: "mode")
            }
        })
    }
    
    func showOverlay() {
        let overlayView = OverlayView(image: UIImage(named: "tiger_text")!, text: "Here you can choose game you want!", frame: view.bounds)
        overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.7) // Полупрозрачный черный фон
        overlayView.alpha = 0
        self.view.addSubview(overlayView)
        
        UIView.animate(withDuration: 0.3) {
            overlayView.alpha = 1
        }
        
        overlayView.animateTextAppearance()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            overlayView.removeFromSuperview()
        }
    }
    
    func setupButtons() {
        view.addSubview(logoImageView)
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            logoImageView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            logoImageView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            logoImageView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
        
        view.addSubview(bellyButton)
        NSLayoutConstraint.activate([
            bellyButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            bellyButton.widthAnchor.constraint(equalToConstant: 350),
            bellyButton.heightAnchor.constraint(equalToConstant: 60),
            bellyButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
        
        bellyButton.addAction(UIAction() {
            _ in
            Vibration.light.vibrate()
            let vc = DifficultyLevelVC()
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }, for: .touchUpInside)
        
        view.addSubview(infiniteButton)
        NSLayoutConstraint.activate([
            infiniteButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            infiniteButton.widthAnchor.constraint(equalToConstant: 350),
            infiniteButton.heightAnchor.constraint(equalToConstant: 60),
            infiniteButton.topAnchor.constraint(equalTo: bellyButton.bottomAnchor, constant: 20)
        ])
        
        infiniteButton.addAction(UIAction() {
            _ in
            Vibration.light.vibrate()
            let vc = ShellGameViewController()
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }, for: .touchUpInside)
        
        view.addSubview(backButton)
        NSLayoutConstraint.activate([
            backButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            backButton.widthAnchor.constraint(equalToConstant: 100),
            backButton.heightAnchor.constraint(equalToConstant: 60),
            backButton.topAnchor.constraint(equalTo: infiniteButton.bottomAnchor, constant: 20)
        ])
        
        backButton.addAction(UIAction() {
            _ in
            self.dismiss(animated: true)
        }, for: .touchUpInside)
    }
    
}
