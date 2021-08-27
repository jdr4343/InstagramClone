//
//  NoNotificationView.swift
//  InstagramClone
//
//  Created by 신지훈 on 2021/08/27.
//

import UIKit
//알람이 없을경우 보여줄 화면입니다.
class NoNotificationView: UIView {

    //알람이 없을경우 화면 가운데에 "bell" 이미지와 함께 알람이 없다는 것을 알려줄 UIView입니다.
    private let label: UILabel = {
        let label = UILabel()
        label.text = "현재 알림이 없습니다."
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .secondaryLabel
        imageView.contentMode = .scaleAspectFill
        imageView.image = UIImage(systemName: "bell")
        return imageView
    }()
    
    override init(frame:CGRect) {
        super.init(frame:frame)
        addSubview(label)
        addSubview(imageView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageView.frame = CGRect(x: (width-50)/2, y: 0, width: 50, height: 50).integral
        label.frame = CGRect(x: 0, y: imageView.bottom, width: width, height: height-50).integral
    }
    
    
}
