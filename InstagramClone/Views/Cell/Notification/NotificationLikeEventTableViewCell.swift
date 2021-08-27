//
//  NotificationLikeEventTableViewCell.swift
//  InstagramClone
//
//  Created by 신지훈 on 2021/08/27.
//


//동영상 이나 썸네일 중 하나를 표시하고 좋아요를 탭하면 해당게시물이 열리지만 알람을 탭하면 해당 게시물을 좋아요한 사용자에게 알람이 가게 됩니다.


import UIKit

//버튼을 탭하면 컨트롤러가 처리 하기 위해 델리게이트를 추가합니다.
protocol NotificationLikeEventTableViewCellDelegate: AnyObject {
    func didTapRelatedPostButton(model: String)
}

class NotificationLikeEventTableViewCell: UITableViewCell {
    
    static let identifier = "NotificationLikeEventTableViewCell"
    
    weak var delegate: NotificationLikeEventTableViewCellDelegate?
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 0
        return label
    }()
 
    private let PostButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(profileImageView)
        contentView.addSubview(label)
        contentView.addSubview(PostButton)
    }
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        PostButton.setBackgroundImage(nil, for: .normal)
        label.text = nil
        profileImageView.image = nil
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    
    
    public func configure(with model: String) {
        
    }
}
