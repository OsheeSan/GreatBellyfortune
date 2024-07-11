//
//  OverlayView.swift
//  GreatBellyfortune
//
//  Created by admin on 01.07.2024.
//

import UIKit

class OverlayView: UIView {
    private let imageView: UIImageView
    private let textLabel: UILabel

    init(image: UIImage, text: String, frame: CGRect) {
        self.imageView = UIImageView(image: image)
        self.textLabel = UILabel()
        self.textLabel.text = text
        self.textLabel.numberOfLines = 0
        self.textLabel.alpha = 1
        self.textLabel.font = UIFont(name: "LilitaOne", size: 26)
        self.textLabel.textColor = .yellow
        super.init(frame: frame)
        
        self.addSubview(imageView)
        self.addSubview(textLabel)
        imageView.contentMode = .scaleAspectFit

        imageView.frame = self.frame
        textLabel.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            textLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            textLabel.centerYAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerYAnchor, constant: -100),
            textLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            textLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func animateTextAppearance() {
        let text = textLabel.text ?? ""
        textLabel.text = ""
        var charIndex = 0.0
        for letter in text {
            Timer.scheduledTimer(withTimeInterval: 0.1 * charIndex, repeats: false) { (timer) in
                self.textLabel.text?.append(letter)
            }
            charIndex += 1
        }
    }
}
