//
//  PackCollectionViewCell.swift
//  TruthOrDare
//
//  Created by Alexey on 13.08.2020.
//  Copyright © 2020 Alexey. All rights reserved.
//

import UIKit

class PackCollectionViewCell: UICollectionViewCell {
    let title = UILabel()
    let level = UILabel()
    private var bg: UIImageView = {
        let im = UIImageView()
        im.layer.cornerRadius = 20
        im.translatesAutoresizingMaskIntoConstraints = false
        im.image = UIImage(named: "backGround")
        im.contentMode = .scaleAspectFill
        im.clipsToBounds = true
        return im
    }()
    override init(frame: CGRect) {
        super.init(frame: .zero)
        contentView.addSubview(bg)
        
        bg.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        bg.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        bg.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        bg.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
        let blurEffect = UIBlurEffect(style: .light)
        let blurredEffectView = UIVisualEffectView(effect: blurEffect)
        blurredEffectView.frame = bg.bounds
        blurredEffectView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(blurredEffectView)
        setupLabels()
        blurredEffectView.layer.cornerRadius = 20
        blurredEffectView.topAnchor.constraint(equalTo: title.topAnchor, constant: -20).isActive = true
        blurredEffectView.trailingAnchor.constraint(equalTo: title.trailingAnchor, constant: 20).isActive = true
        blurredEffectView.leadingAnchor.constraint(equalTo: title.leadingAnchor, constant: -20).isActive = true
        blurredEffectView.bottomAnchor.constraint(equalTo: level.bottomAnchor, constant: 20).isActive = true
        
        
    }
    func setupLabels(){
        title.font = UIFont.systemFont(ofSize: 30)
        title.translatesAutoresizingMaskIntoConstraints = false
        level.translatesAutoresizingMaskIntoConstraints = false
        title.numberOfLines = 0
        title.textAlignment = .center
        contentView.addSubview(title)
        title.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30).isActive = true
        title.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
        title.trailingAnchor.constraint(lessThanOrEqualToSystemSpacingAfter: contentView.trailingAnchor, multiplier: -0.5).isActive = true
        
        
        contentView.addSubview(level)
        level.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 30).isActive = true
        level.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
