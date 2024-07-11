//
//  InfiniteGame.swift
//  GreatBellyfortune
//
//  Created by admin on 25.06.2024.
//

import UIKit

class InfiniteGameController: UIViewController {
    
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
    
    let scoreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "LilitaOne", size: 26)
        label.textColor = .brown
        label.textAlignment = .center
        label.text = "0"
        return label
    }()
    
    
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
                self.currentItemImage.image = UIImage(named: "box_\(self.currentNum!)")
            })
        }
    }
    
    let currentItemImage: UIImageView = {
        let imageview = UIImageView()
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.image = UIImage(named: "box_1")
        imageview.contentMode = .scaleAspectFit
        return imageview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backgroundView = UIImageView(frame: view.frame)
        backgroundView.image = UIImage(named: "bg_1")
        backgroundView.contentMode = .scaleAspectFill
        view.addSubview(backgroundView)
        
        
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
        
        for _ in 0..<36 {
            let num = Int.random(in: 1...12)
            icons.append(num)
        }
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        layout.itemSize = CGSize(width: 50, height: 50)
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.isScrollEnabled = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isUserInteractionEnabled = true
        
        collectionView.register(ButtonCell.self, forCellWithReuseIdentifier: "ButtonCell")
        
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            collectionView.widthAnchor.constraint(equalToConstant: 300),
            collectionView.heightAnchor.constraint(equalToConstant: 300),
            collectionView.centerYAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerYAnchor)
        ])
        
        view.addSubview(currentItemImage)
        NSLayoutConstraint.activate([
            currentItemImage.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            currentItemImage.widthAnchor.constraint(equalToConstant: 70),
            currentItemImage.heightAnchor.constraint(equalToConstant: 70),
            currentItemImage.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 20)
        ])
        
        view.addSubview(tigerImageView)
        NSLayoutConstraint.activate([
            tigerImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tigerImageView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            tigerImageView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            tigerImageView.bottomAnchor.constraint(equalTo: collectionView.topAnchor, constant: -16)
        ])
        tigerImageView.addSubview(scoreLabel)
        NSLayoutConstraint.activate([
            scoreLabel.rightAnchor.constraint(equalTo: tigerImageView.rightAnchor),
            scoreLabel.leftAnchor.constraint(equalTo: tigerImageView.leftAnchor),
            scoreLabel.bottomAnchor.constraint(equalTo: tigerImageView.bottomAnchor),
            scoreLabel.topAnchor.constraint(equalTo: tigerImageView.centerYAnchor)
        ])
        
        startGame()
    }
    
    func swap() {
        for i in 0...5 {
            for j in 0...5 {
                let indexPath = IndexPath(row: i*5 + j, section: 0)
                let randomIndexPath = IndexPath(item: Int.random(in: 0..<36), section: 0)
                
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
        currentItemImage.image = UIImage(named: "box_\(currentNum!)")
    }
    
}

extension InfiniteGameController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 36
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ButtonCell", for: indexPath) as! ButtonCell
        cell.button.setImage(UIImage(named: "box_\(icons[indexPath.item])"), for: .normal)
        cell.imageNum = icons[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? ButtonCell {
            Vibration.light.vibrate()
            if cell.imageNum == currentNum {
                score += 1
                self.currentNum = self.icons.randomElement()
            } else {
                if score > 0 {
                    score -= 1
                }
            }
            swap()
        }
    }
    
}
