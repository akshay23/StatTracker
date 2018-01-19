//
//  PlayerCell.swift
//  StatTracker
//
//  Created by Akshay Bharath on 1/19/18.
//  Copyright © 2018 Actionman Inc. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import SnapKit

class PlayerCell: UICollectionViewCell {
    
    var player: Player? {
        didSet {
            guard let player = player else {
                return
            }
            
            jerseyLabel.text = "\(player.jerseyNumber)"
            firstNameLabel.text = player.firstName
            lastNameLabel.text = player.lastName
            positionLabel.text = player.position
        }
    }
    
    private let jerseyLabel = UILabel()
    private let firstNameLabel = UILabel()
    private let lastNameLabel = UILabel()
    private let positionLabel = UILabel()
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    internal override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    internal override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        
        jerseyLabel.textAlignment = .center
        jerseyLabel.font = UIFont.boldSystemFont(ofSize: 30)
        addSubview(jerseyLabel)
        
        firstNameLabel.textAlignment = .center
        firstNameLabel.textColor = UIColor.ANFacebookBlue()
        firstNameLabel.font = UIFont.boldSystemFont(ofSize: 15)
        addSubview(firstNameLabel)
        
        lastNameLabel.textAlignment = .center
        lastNameLabel.textColor = UIColor.ANFacebookBlue()
        lastNameLabel.font = UIFont.boldSystemFont(ofSize: 15)
        addSubview(lastNameLabel)
        
        positionLabel.textAlignment = .center
        positionLabel.textColor = UIColor.ANMediumGray()
        positionLabel.font = UIFont.boldSystemFont(ofSize: 15)
        addSubview(positionLabel)
        
        setupConstraints()
    }
    
    class func reuseIdentifier() -> String {
        return "playerCell"
    }
    
    private func setupConstraints() {
        jerseyLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(20)
        }
        
        firstNameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(jerseyLabel.snp.bottom).offset(15)
        }
        
        lastNameLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(firstNameLabel.snp.bottom).offset(3)
        }
        
        positionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(lastNameLabel.snp.bottom).offset(15)
        }
    }
}
