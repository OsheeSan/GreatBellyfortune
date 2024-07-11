//
//  ButtonCell.swift
//  GreatBellyfortune
//
//  Created by admin on 18.06.2024.
//

import UIKit

class ButtonCell: UICollectionViewCell {
    
    var imageNum: Int!
    
    let button: UIButton
    
    override init(frame: CGRect) {
        button = UIButton(type: .custom)
        super.init(frame: frame)
        button.frame = self.contentView.bounds
        button.imageView?.contentMode = .scaleAspectFit
        button.isUserInteractionEnabled = false
        self.addSubview(button)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
