//
//  TeamCell.swift
//  StatTracker
//
//  Created by Akshay Bharath on 1/6/18.
//  Copyright © 2018 Actionman Inc. All rights reserved.
//

import AnimotoKit
import Kingfisher
import NSObject_Rx
import RxSwift
import SnapKit
import SwifterSwift
import UIKit

class TeamCell: UITableViewCell {
    
    private var thumbnailImageView = UIImageView()
    private var titleLabel = UILabel()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        thumbnailImageView.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(thumbnailImageView)
        contentView.addSubview(titleLabel)
        
        thumbnailImageView.snp.makeConstraints() { make in
            make.top.equalTo(contentView).offset(2)
            make.left.equalTo(contentView).offset(40)
            make.bottom.equalTo(contentView).offset(-2)
            make.width.equalTo(200)
        }
        
        titleLabel.snp.makeConstraints() { make in
            make.top.equalTo(contentView).offset(10)
            make.left.equalTo(thumbnailImageView).offset(50)
            make.bottom.equalTo(contentView).offset(-10)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(usingTeam team: Team) {
        if let logoURL = team.logoURL, logoURL.isValidUrl {
            let url = URL(string: logoURL)!
            let resource = ImageResource(downloadURL: url, cacheKey: team.name)
            thumbnailImageView.kf.indicatorType = .activity
            thumbnailImageView.kf.setImage(with: resource, options: [.transition(.fade(0.2))])
        }
        
        titleLabel.text = team.name
    }
    
    override func prepareForReuse() {
        thumbnailImageView.image = nil
        super.prepareForReuse()
    }
}
