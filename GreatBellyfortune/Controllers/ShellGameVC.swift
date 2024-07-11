//
//  ShellGameVC.swift
//  GreatBellyfortune
//
//  Created by admin on 01.07.2024.
//

import UIKit

class ShellGameViewController: UIViewController {
    
    let coin: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "box2_11")
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    var currentLvl = 1
    
    var currentBet: Int = 10 {
        didSet {
            betLabel.setTitle("\(currentBet)", for: .normal)
        }
    }
    
    let betLabel: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: "buy_label"), for: .normal)
        button.titleLabel?.font = UIFont(name: "LilitaOne", size: 26)
        button.setTitleColor(.brown, for: .normal)
        button.isUserInteractionEnabled = false
        button.setTitle("10", for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    let coinsLabel: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: "label_coins"), for: .normal)
        button.titleLabel?.font = UIFont(name: "LilitaOne", size: 26)
        button.setTitleColor(.brown, for: .normal)
        button.isUserInteractionEnabled = false
        button.setTitle("\(BellyManager.getCoins())", for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    let label: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "label")
        image.contentMode = .scaleToFill
        return image
    }()
    
    let playButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "btn_play"), for: .normal)
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
    
    func showAlert(title: String, message: String, action: @escaping (UIAlertAction) -> ()) {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: action)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    
    var cupButtons: [UIButton] = []
    var rockPosition: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundView = UIImageView(frame: view.frame)
        backgroundView.image = UIImage(named: "fat_tiger")
        backgroundView.contentMode = .scaleAspectFill
        view.addSubview(backgroundView)
        
        view.addSubview(playButton)
        NSLayoutConstraint.activate([
            playButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            playButton.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor),
            playButton.heightAnchor.constraint(equalToConstant: 60),
            playButton.widthAnchor.constraint(equalToConstant: 300),
        ])
        
        playButton.addAction(UIAction() {
            _ in
            UIView.animate(withDuration: 0.5, animations: {
                self.playButton.alpha = 0
            }) {
                completion in
                if BellyManager.buySomething(for: self.currentBet) {
                    self.setupGame()
                    self.coinsLabel.setTitle("\(BellyManager.getCoins())", for: .normal )
                    self.playButton.isUserInteractionEnabled = false
                } else {
                    self.showAlert(title: "Oops!", message: "You have not enough coins to play!", action: {_ in
                        self.dismiss(animated: true)
                    })
                }
            }
        }, for: .touchUpInside)
        
        view.addSubview(backButton)
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            backButton.heightAnchor.constraint(equalToConstant: 60),
            backButton.widthAnchor.constraint(equalToConstant: 70),
        ])
        backButton.addAction(UIAction() {
            _ in
            self.dismiss(animated: true)
        }, for: .touchUpInside)
        
        view.addSubview(coinsLabel)
        NSLayoutConstraint.activate([
            coinsLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            coinsLabel.leftAnchor.constraint(equalTo: backButton.rightAnchor, constant: 10),
            coinsLabel.heightAnchor.constraint(equalToConstant: 60),
            coinsLabel.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -8)
        ])
        view.addSubview(betLabel)
        NSLayoutConstraint.activate([
            betLabel.topAnchor.constraint(equalTo: coinsLabel.bottomAnchor, constant: 8),
            betLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            betLabel.heightAnchor.constraint(equalToConstant: 60),
            betLabel.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.8)
        ])
        setupCups()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
            if UserDefaults.standard.value(forKey: "tiger1") == nil {
                self.showOverlay(1)
                UserDefaults.standard.setValue(true, forKey: "tiger1")
            }
        })
    }
    
    func showOverlay(_ tiger: Int) {
        if tiger == 1 {
            let overlayView = OverlayView(image: UIImage(named: "tiger_text")!, text: "Be careful, because if you don't guess where the coin is, you will lose it!", frame: view.bounds)
            overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
            overlayView.alpha = 0
            self.view.addSubview(overlayView)
            
            UIView.animate(withDuration: 0.3) {
                overlayView.alpha = 1
            }
            
            overlayView.animateTextAppearance()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
                overlayView.removeFromSuperview()
            }
        } else {
            let overlayView = OverlayView(image: UIImage(named: "double")!, text: "Want to double your winnings? Let's play again!", frame: view.bounds)
            overlayView.backgroundColor = UIColor.black.withAlphaComponent(0.7)
            overlayView.alpha = 0
            self.view.addSubview(overlayView)
            
            UIView.animate(withDuration: 0.3) {
                overlayView.alpha = 1
            }
            
            overlayView.animateTextAppearance()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 8) {
                overlayView.removeFromSuperview()
            }
        }
    }
    
    func setupCups() {
        let cupSize: CGFloat = 100
        let spacing: CGFloat = 30
        let totalWidth: CGFloat = (cupSize * 3) + (spacing * 2)
        let startX: CGFloat = (view.bounds.width - totalWidth) / 2
        let yPosition: CGFloat = (view.bounds.height / 8) * 7 - cupSize / 2
        view.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            label.widthAnchor.constraint(equalToConstant: 380),
            label.heightAnchor.constraint(equalToConstant: 120),
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: (view.bounds.height / 8) * 7 - cupSize / 2 - 10)
        ])
        
        view.addSubview(coin)
        
        for i in 0..<3 {
            let cupButton = UIButton(type: .custom)
            cupButton.frame = CGRect(x: startX + CGFloat(i) * (cupSize + spacing), y: yPosition, width: cupSize, height: cupSize)
            cupButton.setImage(UIImage(named: "bag"), for: .normal)
            cupButton.imageView?.contentMode = .scaleAspectFit
            cupButton.tag = i + 1
            cupButton.addTarget(self, action: #selector(cupButtonPressed(_:)), for: .touchUpInside)
            view.addSubview(cupButton)
            cupButtons.append(cupButton)
        }
        showCoin()
    }
    
    func resetCoinPosition() {
        var targetButton = cupButtons[1]
        for i in cupButtons {
            if i.tag == 2 { targetButton = i }
        }
        coin.transform = .identity
        coin.frame = targetButton.frame
        coin.transform = coin.transform.scaledBy(x: 0.5, y: 0.5)
        coin.alpha = 0
    }

    func hideCoin() {
        for i in cupButtons {
            i.isUserInteractionEnabled = false
        }
        UIView.animate(withDuration: 0.3, animations: {
            self.coin.transform = self.coin.transform.translatedBy(x: 0, y: self.coin.frame.height * 4)
            self.coin.alpha = 0
        }) { _ in
            self.shuffleCups()
        }
    }

    func showCoin() {
        for i in cupButtons {
            i.isUserInteractionEnabled = false
        }
        resetCoinPosition()
        UIView.animate(withDuration: 0.3, animations: {
            self.coin.transform = self.coin.transform.translatedBy(x: 0, y: -self.coin.frame.height * 4)
            self.coin.alpha = 1
            self.playButton.isUserInteractionEnabled = true
            self.playButton.alpha = 1
        })
    }
    
    func setupGame() {
        rockPosition = 2
        hideCoin()
    }
    
    @objc func cupButtonPressed(_ sender: UIButton) {
        showCoin()
        let selectedCup = sender.tag
        if selectedCup == rockPosition {
            if UserDefaults.standard.value(forKey: "tiger2") == nil {
                showOverlay(2)
                UserDefaults.standard.setValue(true, forKey: "tiger2")
            }
            currentBet = currentBet * 2
            BellyManager.addCoins(currentBet)
            coinsLabel.setTitle("\(BellyManager.getCoins())", for: .normal)
            currentLvl += 1
        } else {
            playButton.removeFromSuperview()
            BellyManager.buySomething(for: currentBet)
            coinsLabel.setTitle("\(BellyManager.getCoins())", for: .normal)
            DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
                self.dismiss(animated: true)
            })
        }
    }
    
    var timer: Timer?
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "Shell Game", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func shuffleCups() {
        if currentLvl == 1  {
            timeToShuffle = 10
            timer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        } else if (2...3).contains(currentLvl)  {
            timeToShuffle = 10
            timer = Timer.scheduledTimer(timeInterval: 0.5 - (Double((self.currentLvl - 1)) * 0.1), target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        } else {
            timeToShuffle = 10 + currentLvl
            timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        }
    }
    
    var timeToShuffle = 10
    
    @objc func updateTimer() {
        if timeToShuffle > 0 {
            timeToShuffle -= 1
            UIView.animate(withDuration: 0.3, animations: {
                let randomIndex1 = Int.random(in: 0..<self.cupButtons.count)
                var randomIndex2 = Int.random(in: 0..<self.cupButtons.count)
                
                while randomIndex1 == randomIndex2 {
                    randomIndex2 = Int.random(in: 0..<self.cupButtons.count)
                }
                
                let tempFrame = self.cupButtons[randomIndex1].frame
                self.cupButtons[randomIndex1].frame = self.cupButtons[randomIndex2].frame
                self.cupButtons[randomIndex2].frame = tempFrame
            })
        } else {
            for i in cupButtons {
                i.isUserInteractionEnabled = true
            }
            timer?.invalidate()
        }
    }
}
