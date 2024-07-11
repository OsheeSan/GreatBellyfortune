//
//  BellyGameController.swift
//  GreatBellyfortune
//
//  Created by admin on 18.06.2024.
//

import UIKit

class BellyGameController: UIViewController {
    
    var difficulty: Int!
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    let tigerImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "score_label")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    let enemyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "enemy")
        imageView.contentMode = .scaleAspectFit
        imageView.isUserInteractionEnabled = true
        return imageView
    }()
    
    let label: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "label")
        imageView.contentMode = .scaleToFill
        return imageView
    }()
    
    let scoreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "LilitaOne", size: 26)
        label.textColor = .brown
        label.textAlignment = .center
        label.text = "0"
        return label
    }()
    
    var timer: Timer?
    
    var allTime: Int = 10
    var secondsRemaining: Int = 0
    var squareViews: [UIView] = []
    var stackView: UIStackView!
    
    var score: Int = 0 {
        didSet {
            scoreLabel.text = "\(score)"
        }
    }
    
    var icons: [Int] = []
    
    var collectionView: UICollectionView!
    
    let backButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "btn_back"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    
    var currentNum: Int! {
        didSet {
            UIView.animate(withDuration: 0.3, animations: {
                self.currentItemImage.image = UIImage(named: "box\(self.difficulty!)_\(self.currentNum!)")
            })
        }
    }
    
    let currentItemImage: UIImageView = {
        let imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.image = UIImage(named: "box2_1")
        imageview.contentMode = .scaleAspectFit
        return imageview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundView = UIImageView(frame: view.frame)
        backgroundView.image = UIImage(named: "bg_1")
        backgroundView.contentMode = .scaleAspectFill
        view.addSubview(backgroundView)
        
        stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 1
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        for i in 0..<allTime {
            let squareView = UIView()
            squareView.clipsToBounds = true
            squareView.layer.cornerRadius = 5
            squareView.tag = i
            squareView.backgroundColor = (i < Int(secondsRemaining)) ? .orange : .clear
            squareView.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview(squareView)
            squareViews.append(squareView)
        }
        view.addSubview(label)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            stackView.widthAnchor.constraint(equalTo: view.safeAreaLayoutGuide.widthAnchor, multiplier: 0.95)
        ])
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: stackView.topAnchor, constant: -5),
            label.rightAnchor.constraint(equalTo: stackView.rightAnchor, constant: 10),
            label.leftAnchor.constraint(equalTo: stackView.leftAnchor, constant: -10),
            label.bottomAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 5)
        ])
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTimer), userInfo: nil, repeats: true)
        
        
        view.addSubview(backButton)
        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            backButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            backButton.heightAnchor.constraint(equalToConstant: 50),
            backButton.widthAnchor.constraint(equalToConstant: 70),
        ])
        backButton.addAction(UIAction() {
            _ in
            self.dismiss(animated: true)
        }, for: .touchUpInside)
        
        var count = 1
        switch difficulty {
        case 1:
            count = 16
        case 2:
            count = 25
        case 3:
            count = 36
        default:
            break
        }
        
        for _ in 0..<count {
            let num = Int.random(in: 1...12)
            icons.append(num)
        }
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        switch difficulty {
        case 1:
            layout.itemSize = CGSize(width: 75, height: 75)
        case 2:
            layout.itemSize = CGSize(width: 60, height: 60)
        case 3:
            layout.itemSize = CGSize(width: 50, height: 50)
        default:
            break
        }
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isUserInteractionEnabled = true
        
        collectionView.register(ButtonCell.self, forCellWithReuseIdentifier: "ButtonCell")
        
        let gameView = UIView()
        gameView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(gameView)
        NSLayoutConstraint.activate([
            gameView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            gameView.widthAnchor.constraint(equalToConstant: 300),
            gameView.heightAnchor.constraint(equalToConstant: 300),
            gameView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
        
        gameView.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.centerXAnchor.constraint(equalTo: gameView.centerXAnchor),
            collectionView.widthAnchor.constraint(equalToConstant: 300),
            collectionView.heightAnchor.constraint(equalToConstant: 300),
            collectionView.centerYAnchor.constraint(equalTo: gameView.centerYAnchor)
        ])
        
        view.addSubview(currentItemImage)
        NSLayoutConstraint.activate([
            currentItemImage.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            currentItemImage.widthAnchor.constraint(equalToConstant: 70),
            currentItemImage.heightAnchor.constraint(equalToConstant: 70),
            currentItemImage.topAnchor.constraint(equalTo: gameView.bottomAnchor, constant: 20)
        ])
        
        view.addSubview(tigerImageView)
        NSLayoutConstraint.activate([
            tigerImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tigerImageView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            tigerImageView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tigerImageView.bottomAnchor.constraint(equalTo: gameView.topAnchor, constant: -16)
        ])
        tigerImageView.addSubview(scoreLabel)
        NSLayoutConstraint.activate([
            scoreLabel.rightAnchor.constraint(equalTo: tigerImageView.rightAnchor),
            scoreLabel.leftAnchor.constraint(equalTo: tigerImageView.leftAnchor),
            scoreLabel.bottomAnchor.constraint(equalTo: tigerImageView.bottomAnchor),
            scoreLabel.topAnchor.constraint(equalTo: tigerImageView.centerYAnchor)
        ])
        
        startGame()
        if difficulty == 3 {
            gameView.addSubview(enemyImageView)
            NSLayoutConstraint.activate([
                enemyImageView.widthAnchor.constraint(equalToConstant: 50),
                enemyImageView.heightAnchor.constraint(equalToConstant: 50),
                enemyImageView.centerXAnchor.constraint(equalTo: gameView.centerXAnchor),
                enemyImageView.centerYAnchor.constraint(equalTo: gameView.centerYAnchor)
            ])
            enemyImageView.isUserInteractionEnabled = true
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(enemyTapped))
            enemyImageView.addGestureRecognizer(tapGesture)
            moveEnemyRandomly()
        }
    }
    
    func swap() {
        var count: Int!
        switch difficulty {
        case 1:
            count = 4
        case 2:
            count = 5
        case 3:
            count = 6
        default:
            break
        }
        for i in 0..<count {
            for j in 0..<count {
                let indexPath = IndexPath(row: i*count + j, section: 0)
                let randomIndexPath = IndexPath(item: Int.random(in: 0..<count*count), section: 0)
                
                UIView.animate(withDuration: 0.5) {
                    self.collectionView.performBatchUpdates({
                        self.collectionView.moveItem(at: indexPath, to: randomIndexPath)
                        self.collectionView.moveItem(at: randomIndexPath, to: indexPath)
                    }, completion: { _ in
                    })
                }
            }
        }
    }
    
    func startGame() {
        currentNum = icons.randomElement()
        currentItemImage.image = UIImage(named: "box\(self.difficulty!)_\(currentNum!)")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        timer?.invalidate()
        timerEnemy?.invalidate()
    }
    
    @objc func updateTimer() {
        self.secondsRemaining += 1
        for i in self.squareViews {
            i.backgroundColor = (i.tag < Int(self.secondsRemaining)) ? .orange : .clear
        }
        if secondsRemaining > allTime {
            print("End of time")
            timer?.invalidate()
            timerEnemy?.invalidate()
            finish(false)
        }
    }
    
    var timerEnemy: Timer?
    
}

extension BellyGameController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch difficulty {
        case 1:
            return 16
        case 2:
            return 25
        case 3:
            return 36
        default:
            return 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ButtonCell", for: indexPath) as! ButtonCell
        cell.button.setImage(UIImage(named: "box\(self.difficulty!)_\(icons[indexPath.item])"), for: .normal)
        cell.imageNum = icons[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? ButtonCell {
            Vibration.light.vibrate()
            if cell.imageNum == currentNum {
                score += 1
                if let index = self.icons.firstIndex(where: {$0 == self.currentNum}) {
                    self.icons.remove(at: index)
                }
                if !self.icons.isEmpty {
                    self.currentNum = self.icons.randomElement()
                } else {
                    timer?.invalidate()
                    timerEnemy?.invalidate()
                    finish(true)
                }
                UIView.animate(withDuration: 0.5) {
                    cell.button.alpha = 0
                    cell.imageNum = 0
                }
            } else {
                if score > 0 {
                    score -= 1
                }
            }
            swap()
        }
    }
    
    func finish(_ win: Bool) {
        hideAllElements()
        if win {
            BellyManager.addCoins(score)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.addSubview(self.tigerImageView)
                    self.tigerImageView.addSubview(self.scoreLabel)
                    NSLayoutConstraint.activate([
                        self.tigerImageView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor),
                        self.tigerImageView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor),
                        self.tigerImageView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
                        self.tigerImageView.heightAnchor.constraint(equalTo: self.tigerImageView.widthAnchor)
                    ])
                    NSLayoutConstraint.activate([
                        self.scoreLabel.rightAnchor.constraint(equalTo: self.tigerImageView.rightAnchor),
                        self.scoreLabel.leftAnchor.constraint(equalTo: self.tigerImageView.leftAnchor),
                        self.scoreLabel.bottomAnchor.constraint(equalTo: self.tigerImageView.bottomAnchor),
                        self.scoreLabel.topAnchor.constraint(equalTo: self.tigerImageView.centerYAnchor)
                    ])
                    self.tigerImageView.alpha = 1
                    self.scoreLabel.alpha = 1
                    self.scoreLabel.font = UIFont(name: "LilitaOne", size: 40)
                    
                })
            })
        } else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5, execute: {
                UIView.animate(withDuration: 0.3, animations: {
                    self.view.addSubview(self.tigerImageView)
                    self.tigerImageView.addSubview(self.scoreLabel)
                    NSLayoutConstraint.activate([
                        self.tigerImageView.centerYAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerYAnchor),
                        self.tigerImageView.rightAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.rightAnchor),
                        self.tigerImageView.leftAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leftAnchor),
                        self.tigerImageView.heightAnchor.constraint(equalTo: self.tigerImageView.widthAnchor)
                    ])
                    NSLayoutConstraint.activate([
                        self.scoreLabel.rightAnchor.constraint(equalTo: self.tigerImageView.rightAnchor),
                        self.scoreLabel.leftAnchor.constraint(equalTo: self.tigerImageView.leftAnchor),
                        self.scoreLabel.bottomAnchor.constraint(equalTo: self.tigerImageView.bottomAnchor),
                        self.scoreLabel.topAnchor.constraint(equalTo: self.tigerImageView.centerYAnchor)
                    ])
                    self.tigerImageView.alpha = 1
                    self.scoreLabel.alpha = 1
                    self.scoreLabel.text = "Lose"
                    self.scoreLabel.font = UIFont(name: "LilitaOne", size: 40)
                })
            })
        }
    }
    
    func hideAllElements() {
        UIView.animate(withDuration: 0.3, animations: {
            self.currentItemImage.alpha = 0
            self.stackView.alpha = 0
            self.collectionView.alpha = 0
            self.label.alpha = 0
            self.tigerImageView.alpha = 0
            self.scoreLabel.alpha = 0
            self.enemyImageView.alpha = 0
        }) {
            _ in
            self.currentItemImage.removeFromSuperview()
            self.stackView.removeFromSuperview()
            self.collectionView.removeFromSuperview()
            self.label.removeFromSuperview()
            self.tigerImageView.removeFromSuperview()
            self.scoreLabel.removeFromSuperview()
            self.enemyImageView.removeFromSuperview() 
            self.tigerImageView.removeConstraints(self.tigerImageView.constraints)
            self.scoreLabel.removeConstraints(self.scoreLabel.constraints)
        }
    }
    
}
extension BellyGameController {
    
    func moveEnemyRandomly() {
        guard let collectionView = collectionView else { return }
        
        timerEnemy = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            UIView.animate(withDuration: 0.5) {
                self.enemyImageView.center = self.randomPoint(in: self.enemyImageView.superview!)
            }
        }
    }
    
}
extension BellyGameController {
    
    @objc func enemyTapped() {
        timer?.invalidate()
        timerEnemy?.invalidate()
        finish(false)
    }
    
    func randomPoint(in view: UIView) -> CGPoint {
        let width = view.bounds.width
        let height = view.bounds.height
        let randomX = Int.random(in: 0...5)
        let randomY = Int.random(in: 0...5)
        return CGPoint(x: 25+50*randomX, y: 25+50*randomY)
    }
    
}
