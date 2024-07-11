//
//  ShopVC.swift
//  GreatBellyfortune
//
//  Created by admin on 24.06.2024.
//

import UIKit

class ShopVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let page = Int(scrollView.contentOffset.x / scrollView.frame.size.width)
        currentIndex = page
        updateInfoForCurrentIndex()
    }
    
    func updateInfoForCurrentIndex() {
        Vibration.light.vibrate()
    }
    
    var currentIndex: Int = 0 {
        didSet {
            if currentIndex + 1 <= BellyManager.getMaskCount() {
                photoButton.isEnabled = true
            } else {
                photoButton.isEnabled = false
            }
        }
    }
    
    let backButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "btn_back"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }()
    
    let photoButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "btn_photo"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.isEnabled = BellyManager.getMaskCount() >= 1 ? true : false
        return button
    }()
    
    let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "bellyshop")
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
    
    var collectionView: UICollectionView!
    
    override func viewWillAppear(_ animated: Bool) {
        coinsLabel.setTitle("\(BellyManager.getCoins())", for: .normal)
    }
    
    var selectedButtonIndex = 1 {
        didSet {
            button1.setImage(UIImage(named: "box1_1"), for: .normal)
            button2.setImage(UIImage(named: "box1_2"), for: .normal)
            button3.setImage(UIImage(named: "box1_3"), for: .normal)
            button4.setImage(UIImage(named: "box1_4"), for: .normal)
            if selectedButtonIndex == 1 {
                button1.setImage(UIImage(named: "box1_12"), for: .normal)
            }
            if selectedButtonIndex == 2 {
                button2.setImage(UIImage(named: "box1_11"), for: .normal)
            }
            if selectedButtonIndex == 3 {
                button3.setImage(UIImage(named: "box1_10"), for: .normal)
            }
            if selectedButtonIndex == 4 {
                button4.setImage(UIImage(named: "box1_9"), for: .normal)
            }
        }
    }
    
    let button1 = createSquareButton(named: "box1_12")
    let button2 = createSquareButton(named: "box1_2")
    let button3 = createSquareButton(named: "box1_3")
    let button4 = createSquareButton(named: "box1_4")
    var buttonStack = UIStackView()
    let wideButton = createWideButton(named: "buy_label")
    
    static var cost = [150, 600, 900, 1500]
    
    static func createSquareButton(named imageName: String) -> UIButton {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: imageName), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }
    
    static func createWideButton(named imageName: String) -> UIButton {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setBackgroundImage(UIImage(named: imageName), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        button.setTitle("Buy \(cost[0])", for: .normal)
        button.setTitleColor(.brown, for: .normal)
        button.titleLabel?.font = UIFont(name: "LilitaOne", size: 26)
        return button
    }
    
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
        setupCollectionView()
        view.addSubview(photoButton)
        NSLayoutConstraint.activate([
            photoButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            photoButton.widthAnchor.constraint(equalToConstant: 350),
            photoButton.heightAnchor.constraint(equalToConstant: 60),
            photoButton.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 8)
        ])
        photoButton.addAction(UIAction() {
            _ in
            Vibration.light.vibrate()
            let vc = CamMaskVC()
            vc.modalTransitionStyle = .crossDissolve
            vc.modalPresentationStyle = .fullScreen
            vc.imageToShow = UIImage(named: "tiger_mask_\(self.currentIndex + 1)")
            self.present(vc, animated: true)
        }, for: .touchUpInside)
        
        view.addSubview(coinsLabel)
        NSLayoutConstraint.activate([
            coinsLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            coinsLabel.widthAnchor.constraint(equalToConstant: 350),
            coinsLabel.heightAnchor.constraint(equalToConstant: 60),
            coinsLabel.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8)
        ])
        addButtonsToView()
        
        view.addSubview(logoImageView)
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: photoButton.bottomAnchor, constant: 8),
            logoImageView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            logoImageView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            logoImageView.bottomAnchor.constraint(equalTo: buttonStack.topAnchor, constant: -8)
        ])
        selectWideButtonText(0)
    }
    
    func selectWideButtonText(_ index: Int) {
        self.wideButton.removeTarget(nil, action: nil, for: .allEvents)
        if !BellyManager.getTickets()[index] {
            self.wideButton.setTitle("Buy \(ShopVC.cost[index])", for: .normal)
            wideButton.addAction(UIAction() {
                _ in
                if BellyManager.buySomething(for: ShopVC.cost[index]) {
                    self.coinsLabel.setTitle("\(BellyManager.getCoins())", for: .normal)
                    BellyManager.buyTicket(index)
                    self.selectWideButtonText(index)
                } else {
                    self.showAlert(title: "Hey!", message: "You have not enough coins!", action: { _ in
                        
                    })
                }
            }, for: .touchUpInside)
        } else {
            self.wideButton.setTitle("Read", for: .normal)
            wideButton.addAction(UIAction() {
                _ in
                let vc = TextViewController()
                vc.modalTransitionStyle = .crossDissolve
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true)
            }, for: .touchUpInside)
        }
    }
    
    func showAlert(title: String, message: String, action: @escaping (UIAlertAction) -> ()) {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: .default, handler: action)
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
    
    func addButtonsToView() {
        let buttons = [button1, button2, button3, button4]
        button1.addAction(UIAction() {
            _ in
            self.selectedButtonIndex = 1
            self.selectWideButtonText(0)
        }, for: .touchUpInside)
        button2.addAction(UIAction() {
            _ in
            self.selectedButtonIndex = 2
            self.selectWideButtonText(1)
        }, for: .touchUpInside)
        button3.addAction(UIAction() {
            _ in
            self.selectedButtonIndex = 3
            self.selectWideButtonText(2)
        }, for: .touchUpInside)
        button4.addAction(UIAction() {
            _ in
            self.selectedButtonIndex = 4
            self.selectWideButtonText(3)
        }, for: .touchUpInside)
        buttonStack = UIStackView(arrangedSubviews: buttons)
        buttonStack.axis = .horizontal
        buttonStack.distribution = .fillEqually
        buttonStack.spacing = 8
        buttonStack.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(buttonStack)
        view.addSubview(wideButton)
        NSLayoutConstraint.activate([
            buttonStack.bottomAnchor.constraint(equalTo: wideButton.topAnchor, constant: -8),
            buttonStack.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            buttonStack.heightAnchor.constraint(equalToConstant: 50),
            buttonStack.widthAnchor.constraint(equalToConstant: 350),
            
            wideButton.bottomAnchor.constraint(equalTo: coinsLabel.topAnchor, constant: -8),
            wideButton.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            wideButton.widthAnchor.constraint(equalToConstant: 350),
            wideButton.heightAnchor.constraint(equalToConstant: 60),
        ])
        
        wideButton.addAction(UIAction() {
            _ in
            
        }, for: .touchUpInside)
    }
    
    func setupCollectionView() {
        let layout = CustomFlowLayout()
        layout.scrollDirection = .horizontal
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.backgroundColor = .clear
        
        let backImage = UIImageView()
        backImage.translatesAutoresizingMaskIntoConstraints = false
        backImage.image = UIImage(named: "table")
        backImage.contentMode = .scaleToFill
        view.addSubview(backImage)
        view.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            collectionView.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 18),
            collectionView.heightAnchor.constraint(equalToConstant: 180)
        ])
        
        NSLayoutConstraint.activate([
            backImage.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            backImage.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            backImage.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 8),
            backImage.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCell
        cell.imageView.image = UIImage(named: "tiger_mask_\(indexPath.item + 1)")
        return cell
    }
}


class CustomFlowLayout: UICollectionViewFlowLayout {
    
    override init() {
        super.init()
        scrollDirection = .horizontal
        minimumLineSpacing = 0
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepare() {
        super.prepare()
        guard let collectionView = collectionView else { return }
        let collectionViewSize = collectionView.bounds.size
        itemSize = CGSize(width: collectionViewSize.width * 1, height: collectionViewSize.height*0.6)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)
        
        let centerX = collectionView!.contentOffset.x + collectionView!.bounds.size.width / 2
        
        attributes?.forEach { attr in
            let distance = abs(attr.center.x - centerX)
            let scale = 1 + (1 - distance / (collectionView!.bounds.size.width / 2)) * 0.8
            attr.transform = CGAffineTransform(scaleX: scale, y: scale)
        }
        
        return attributes
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        let collectionViewSize = collectionView!.bounds.size
        let proposedRect = CGRect(origin: proposedContentOffset, size: collectionViewSize)
        
        guard let attributes = layoutAttributesForElements(in: proposedRect) else {
            return proposedContentOffset
        }
        
        let centerX = proposedContentOffset.x + collectionViewSize.width / 2
        let closest = attributes.sorted { abs($0.center.x - centerX) < abs($1.center.x - centerX) }.first ?? UICollectionViewLayoutAttributes()
        let offsetX = closest.center.x - collectionViewSize.width / 2
        
        return CGPoint(x: offsetX, y: proposedContentOffset.y)
    }
}

class CustomCell: UICollectionViewCell {
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
