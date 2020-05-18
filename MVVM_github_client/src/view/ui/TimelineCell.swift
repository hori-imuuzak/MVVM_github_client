//
//  TimelineCell.swift
//  MVVM_github_client
//
//  Created by 堀知海 on 2020/05/18.
//  Copyright © 2020 umichan. All rights reserved.
//

import UIKit

class TimelineCell: UITableViewCell {
    private var iconView: UIImageView!
    private var nickNameLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        iconView = UIImageView()
        iconView.clipsToBounds = true
        contentView.addSubview(iconView)
        
        nickNameLabel = UILabel()
        nickNameLabel.font = UIFont.systemFont(ofSize: 15.0)
        contentView.addSubview(nickNameLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        iconView.frame = CGRect(
            x: 15,
            y: 15,
            width: 45,
            height: 45
        )
        iconView.layer.cornerRadius = iconView.frame.size.width / 2
        
        nickNameLabel.frame = CGRect(
            x: iconView.frame.maxX + 15,
            y: iconView.frame.origin.y,
            width: contentView.frame.width - iconView.frame.maxX - 15 * 2,
            height: 15
        )
    }
    
    func setNickName(nickName: String) {
        nickNameLabel.text = nickName
    }
    
    func setIcon(imageUrlString: String) {
        iconView.cacheImage(imageUrlString: imageUrlString)
    }
}
