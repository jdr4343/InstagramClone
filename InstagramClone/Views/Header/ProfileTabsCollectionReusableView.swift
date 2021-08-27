//
//  ProfileTabsCollectionReusableView.swift
//  InstagramClone
//
//  Created by 신지훈 on 2021/08/26.
//

import UIKit
//ProfileInfoHeaderCollectionReusableViewDelegate에서와 마찬가지로 액션을 다른 뷰에서 만들려고 하기 때문에 프로토콜을 연결 해줍니다.
protocol ProfileTabsCollectionReusableViewDelegate: AnyObject {
    func didTapGridButton()
    func didTapTaggedButton()
}

//프로필의 헤더 하단을 설정하는 뷰 입니다.
class ProfileTabsCollectionReusableView: UICollectionReusableView {
    
    static let identifier = "ProfileTabsCollectionReusableView"
    
    public weak var delegate: ProfileTabsCollectionReusableViewDelegate?
    
    
    //격자무니 버튼과 태그 버튼을 가질 것입니다.
    private let gridButton: UIButton = {
       let button = UIButton()
        button.clipsToBounds = true
        button.tintColor = .systemBlue
        button.setBackgroundImage(UIImage(systemName:"square.grid.2x2"), for: .normal)
        return button
    }()
    private let taggedButton: UIButton = {
       let button = UIButton()
        button.clipsToBounds = true
        button.tintColor = .lightGray
        button.setBackgroundImage(UIImage(systemName:"tag"), for: .normal)
        return button
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
      //  clipsToBounds = true
        addSubview(gridButton)
        addSubview(taggedButton)
        gridButton.addTarget(self, action: #selector(didTapGridButton), for: .touchUpInside)
        taggedButton.addTarget(self, action: #selector(didTabTaggedButton), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //프레임을 정할 패딩입니다.
    struct Constants {
        static let padding: CGFloat = 8
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
            //버튼을 정사각형으로 만들겠습니다.
        let size = height-(Constants.padding*2)
        let gridButtonX = ((width/2)-size)/2
        gridButton.frame = CGRect(x: gridButtonX,
                                  y: Constants.padding,
                                  width: size, height: size)
        taggedButton.frame = CGRect(x: gridButtonX + (width/2),
                                    y: Constants.padding,
                                    width: size, height: size)
    }
    
    //사용자가 두개의 버튼중 하나를 클릭했을떄 클릭 안한 버튼은 색깔을 lightGray를 유지하고 클릭된 버튼은 파란색으로 만들겠습니다.
    @objc private func didTapGridButton() {
        gridButton.tintColor = .systemBlue
        taggedButton.tintColor = .lightGray
        delegate?.didTapGridButton()
    }
    @objc private func didTabTaggedButton() {
        gridButton.tintColor = .lightGray
        taggedButton.tintColor = .systemBlue
        delegate?.didTapTaggedButton()
    }
    
}
