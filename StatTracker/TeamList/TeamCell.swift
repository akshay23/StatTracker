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
    
    var localTeam: Team?
    
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
            make.top.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-10)
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.width.equalTo(100)
        }
        
        titleLabel.snp.makeConstraints() { make in
            make.top.equalTo(contentView).offset(10)
            make.left.equalTo(thumbnailImageView.snp.right).offset(40)
            make.bottom.equalTo(contentView).offset(-10)
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configureCell(usingTeam team: Team) {
        localTeam = team
        if team.logoURL.isValidUrl, let url = URL(string: team.logoURL) {
            let resource = ImageResource(downloadURL: url, cacheKey: team.name)
            thumbnailImageView.kf.indicatorType = .activity
            thumbnailImageView.kf.setImage(with: resource, options: [.transition(.fade(0.2))])
        }
        titleLabel.text = "\(team.location) \(team.name)"
    }
    
    override func prepareForReuse() {
        thumbnailImageView.image = nil
        super.prepareForReuse()
    }
}
