//
//  NotificationFollowEventTableViewCell.swift
//  InstagramClone
//
//  Created by 신지훈 on 2021/08/27.
//

import UIKit

//버튼을 탭하면 컨트롤러가 처리 하기 위해 델리게이트를 추가합니다.
protocol NotificationFollowEventTableViewCellDelegate: AnyObject {
    func didTapFollowUnFollowButton(model: UserNotification)
}

//사용자가 팔로우나 언팔로우 했을때 알림을 날릴 셀입니다.
class NotificationFollowEventTableViewCell: UITableViewCell {

    static let identifier = "NotificationFollowEventTableViewCell"
    
    weak var delegate: NotificationFollowEventTableViewCellDelegate?
    
    private var model: UserNotification?
    
    //프로필 이미지와 라벨 과 팔로우 버튼을 가질것입니다.
    private let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.masksToBounds = true
        imageView.backgroundColor = .tertiarySystemBackground
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 0
        label.text = "김현수가 당신을 팔로우 하기 시작 했Dㅏ!"
        return label
    }()
    
    private let followButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 4
        button.layer.masksToBounds = true
        return button
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.clipsToBounds = true
        contentView.addSubview(profileImageView)
        contentView.addSubview(label)
        contentView.addSubview(followButton)
        followButton.addTarget(self, action: #selector(didtapFollowButton), for: .touchUpInside)
        configureForFollow()
        selectionStyle = .none
        
    }
    
    
    public override func prepareForReuse() {
        super.prepareForReuse()
        followButton.setTitle(nil, for: .normal)
        followButton.backgroundColor = nil
        followButton.layer.borderWidth = 0
        label.text = nil
        profileImageView.image = nil
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        //사진 , 글 , 게시버튼
        profileImageView.frame = CGRect(x: 3, y: 3, width: contentView.height-6, height: contentView.height-6)
        profileImageView.layer.cornerRadius = profileImageView.height/2
        
        let size: CGFloat = 100
        let buttonHeight: CGFloat = 40
        followButton.frame = CGRect(x: contentView.width-5-size,
                                    y: (contentView.height-44)/2,
                                    width: size,
                                    height: buttonHeight)
        
        label.frame = CGRect(x: profileImageView.right+5,
                             y: 0,
                             width: contentView.width-size-profileImageView.width-16,
                             height: contentView.height)
    }
    
    @objc private func didtapFollowButton() {
        guard let model = model else {
            return
        }
        delegate?.didTapFollowUnFollowButton(model: model)
    }
    
    
    public func configure(with model: UserNotification) {
        self.model = model
        
        switch model.type {
        case .like(_):
            break
        case .follow(let state):
            //버튼을 구성 합니다.
            switch state {
            case .following:
            //언팔 버튼을 보여 줍니다.
                configureForFollow()
                

            case .Unfollowing:
            //팔로잉 버튼을 보여줍니다
                followButton.setTitle("팔로잉", for: .normal)
                followButton.setTitleColor(.white, for: .normal)
                followButton.backgroundColor = .link
                followButton.layer.borderWidth = 0
            }
            break
        }
        label.text = model.text
        profileImageView.sd_setImage(with: model.user.Profilephoto, completed: nil)
    }
    private func configureForFollow() {
        followButton.setTitle("언팔로잉", for: .normal)
        followButton.setTitleColor(.label, for: .normal)
        followButton.layer.borderColor = UIColor.secondaryLabel.cgColor
        followButton.layer.borderWidth = 1
    }
}
