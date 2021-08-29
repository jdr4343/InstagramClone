//
//  IGFeedPostHeaderTableViewCell.swift
//  InstagramClone
//
//  Created by 신지훈 on 2021/08/26.
//

import UIKit

protocol IGFeedPostHeaderTableViewCellDelegate: AnyObject {
    func didTapMoreButton()
}


class IGFeedPostHeaderTableViewCell: UITableViewCell {
//최상단의 첫번째 셀이 될것이며 유저이름,프로필 사진을 만들고 더 많은 정보를 볼수 있는 버튼을 만들겠습니다. 하겠습니다.
    static let identifier = "IGFeedPostHeaderTableViewCell"
    
    weak var delegate: IGFeedPostHeaderTableViewCellDelegate?
    
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        label.font = .systemFont(ofSize: 18, weight: .medium)
        return label
    }()
    
    private let moreButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        return button
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(profileImageView)
        contentView.addSubview(userNameLabel)
        contentView.addSubview(moreButton)
        moreButton.addTarget(self, action: #selector(didTapMoreButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        profileImageView.image = nil
        userNameLabel.text = nil
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let size = contentView.height-4
        profileImageView.layer.cornerRadius = size/2
        profileImageView.frame = CGRect(x: 2, y: 3, width: size, height: size)
        userNameLabel.frame = CGRect(x: profileImageView.right+10,
                                     y: 2,
                                     width: contentView.width-(size*2)-15,
                                     height: contentView.height-4)
        moreButton.frame = CGRect(x: contentView.width-size, y: 2, width: size, height: size)
    }
    //프로토콜을 연결하고 홈뷰에서 작성하겠습니다.
    @objc private func didTapMoreButton() {
        delegate?.didTapMoreButton()
    }
    
    
    public func configure(with model: User) {
        userNameLabel.text = model.username
        profileImageView.image = UIImage(systemName: "person.circle")
        profileImageView.tintColor = .label
        //profileImageView.sd_setImage(with: model.Profilephoto, completed: nil)
    }
    
    
}
