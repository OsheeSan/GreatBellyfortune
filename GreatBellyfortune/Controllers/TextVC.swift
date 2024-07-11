//
//  TextVC.swift
//  GreatBellyfortune
//
//  Created by admin on 26.06.2024.
//

import UIKit

class TextViewController: UIViewController {
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    let backButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "btn_back"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundView = UIImageView(frame: view.frame)
        backgroundView.image = UIImage(named: "bg_1")
        backgroundView.contentMode = .scaleAspectFill
        view.addSubview(backgroundView)
        
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.translatesAutoresizingMaskIntoConstraints = false
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurEffectView)
        blurEffectView.clipsToBounds = true
        blurEffectView.layer.cornerRadius = 10
        view.addSubview(backButton)
        NSLayoutConstraint.activate([
            backButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            backButton.widthAnchor.constraint(equalToConstant: 100),
            backButton.heightAnchor.constraint(equalToConstant: 60),
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
        
        NSLayoutConstraint.activate([
            blurEffectView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            blurEffectView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            blurEffectView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 20),
            blurEffectView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
        
        backButton.addAction(UIAction() {
            _ in
            self.dismiss(animated: true)
        }, for: .touchUpInside)
        
        let textView = UITextView()
        
        textView.text = "Year of the Tiger:\nIn the Chinese zodiac, the tiger is one of the twelve animal signs. People born in the Year of the Tiger are said to be brave, competitive, unpredictable, and confident. The most recent Year of the Tiger was in 2022, and the next one will be in 2034. Each zodiac sign comes around once every 12 years."
        textView.font = UIFont(name: "LilitaOne", size: 26)
        textView.isEditable = false
        textView.isSelectable = false
        
        // Настройка дополнительных свойств
        textView.textColor = .white
        textView.textAlignment = .left
        textView.backgroundColor = .clear
        
        // Добавляем textView к главному view
        view.addSubview(textView)
        
        // Отключаем автоматические ограничения (Autoresizing Mask)
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        // Устанавливаем ограничения (constraints)
        NSLayoutConstraint.activate([
            textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            textView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 20),
            textView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20)
        ])
    }
}
