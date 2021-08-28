//
//  IGFeedPostActionTableViewCell.swift
//  InstagramClone
//
//  Created by 신지훈 on 2021/08/26.
//

import UIKit
//좋아요 버튼, 댓글, 공유
class IGFeedPostActionTableViewCell: UITableViewCell {

    static let identifier = "IGFeedPostActionTableViewCell"
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = .systemGray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    public func configure() {
        
    }

}
