//
//  ProfileInfoHeaderCollectionReusableView.swift
//  InstagramClone
//
//  Created by 신지훈 on 2021/08/26.
//

import UIKit
//다른 뷰에서 버튼의 액션을 연결하기 위해 선언한 프로토콜 입니다.
protocol ProfileInfoHeaderCollectionReusableViewDelegate: AnyObject {
    func profileHeaderDidTapPostsButton(_ header: ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTapfollowingButton(_ header: ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTapfollowersButton(_ header: ProfileInfoHeaderCollectionReusableView)
    func profileHeaderDidTapeditProfileButton(_ header: ProfileInfoHeaderCollectionReusableView)
}

//프로필의 상단에 자리할 헤더를 만들겠습니다.

final class ProfileInfoHeaderCollectionReusableView: UICollectionReusableView {
    
    static let identifier = "ProfileInfoHeaderCollectionReusableView"
    
    //메모리 누수를 막기위해 weak var로 선언합니다.
    public weak var delegate: ProfileInfoHeaderCollectionReusableViewDelegate?
    
    //헤더에는 프로필 이미지,게시물 올리기 버튼. 팔로워 확인 버튼, 팔로잉 확인 버튼, 프로필 편집 버튼 ,이름 라벨, 유저이름 라벨이 있습니다.
    private let profilePhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "testImage")
        imageView.layer.masksToBounds = true
        return imageView
    }()
    //버튼
    private let postButton: UIButton = {
        let button = UIButton()
        button.setTitle("게시물", for: .normal)
        button.backgroundColor = .secondarySystemBackground
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    private let followingButton: UIButton = {
        
        let button = UIButton()
        button.setTitle("팔로워", for: .normal)
        button.backgroundColor = .secondarySystemBackground
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    private let followersButton: UIButton = {
        let button = UIButton()
        button.setTitle("팔로잉", for: .normal)
        button.backgroundColor = .secondarySystemBackground
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    private let editProfileButton: UIButton = {
        let button = UIButton()
        button.setTitle("프로필 편집", for: .normal)
        button.backgroundColor = .secondarySystemBackground
        button.setTitleColor(.label, for: .normal)
        return button
    }()
    //라벨
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "신지훈"
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()
    private let bioLabel: UILabel = {
        let label = UILabel()
        label.text = "새로운 계정입니다!"
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()
    
    //MARK: init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        clipsToBounds = true
        addSubViews()
        addButtonAction()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        //프로필 사진 사이즈
        let profilePhotoSize = width/4
        profilePhotoImageView.frame = CGRect(x: 5, y: 5,
                                             width: profilePhotoSize,
                                             height: profilePhotoSize).integral
        
        profilePhotoImageView.layer.cornerRadius = profilePhotoSize/2.0
        //버튼 사이즈
        let buttonHeight = profilePhotoSize/2
        let countButtonWidth = (width-10-profilePhotoSize)/3
        postButton.frame = CGRect(x: profilePhotoImageView.right,
                                  y: 5,
                                  width: countButtonWidth,
                                  height: buttonHeight).integral
        followingButton.frame = CGRect(x: postButton.right,
                                       y: 5,
                                       width: countButtonWidth,
                                       height: buttonHeight).integral
        followersButton.frame = CGRect(x: followingButton.right,
                                       y: 5,
                                       width: countButtonWidth,
                                       height: buttonHeight).integral
        
        
        editProfileButton.frame = CGRect(x: profilePhotoImageView.right,
                                         y: 5 + buttonHeight,
                                         width:  countButtonWidth*3,
                                         height: buttonHeight).integral
        
        //라벨 사이즈
        let bioLabelSize = bioLabel.sizeThatFits(self.frame.size)
        nameLabel.frame = CGRect(x: 5,
                                 y: 5 + profilePhotoImageView.bottom,
                                 width:  width-10,
                                 height: 50).integral
        bioLabel.frame = CGRect(x: 5,
                                 y: 5 + nameLabel.bottom,
                                 width:  width-10,
                                 height: bioLabelSize.height).integral
        
        
    }
    
    private func addSubViews() {
        //재사용 가능한 셀이기 때문에 그냥 작성해도 됩니다.
        addSubview(profilePhotoImageView)
        addSubview(postButton)
        addSubview(followingButton)
        addSubview(followersButton)
        addSubview(editProfileButton)
        addSubview(nameLabel)
        addSubview(bioLabel)
    }
    //버튼 액션을 추가하는 함수입니다.
    private func addButtonAction() {
        postButton.addTarget(self, action: #selector(didtapPostButton), for: .touchUpInside)
        followingButton.addTarget(self, action: #selector(didtapFollowingButton), for: .touchUpInside)
        followersButton.addTarget(self, action: #selector(didtapFollowerButton), for: .touchUpInside)
        editProfileButton.addTarget(self, action: #selector(didtapEditProfileButton), for: .touchUpInside)
    }
    
    //델리게이트를 활용해 버튼을 탭했다고 전할것 입니다.발생한 일을 뷰 컨트롤러에 전달하여 뷰 컨트롤러 핸들러가 이 뷰 클래스가 아닌곳에서 처리할수 있도록 하는 방법입니다.
    @objc private func didtapPostButton() {
        delegate?.profileHeaderDidTapPostsButton(self)
    }
    @objc private func didtapFollowingButton() {
        delegate?.profileHeaderDidTapfollowingButton(self)
        
    }
    @objc private func didtapFollowerButton() {
        delegate?.profileHeaderDidTapfollowersButton(self)
    }
    @objc private func didtapEditProfileButton() {
        delegate?.profileHeaderDidTapeditProfileButton(self)
    }
}
