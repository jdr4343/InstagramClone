//
//  FormTableViewCell.swift
//  InstagramClone
//
//  Created by 신지훈 on 2021/08/26.
//

import UIKit

class FormTableViewCell: UITableViewCell, UITextFieldDelegate{

    static let identifier = "FormTableViewCell"

    private let formLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.numberOfLines = 1
        return label
    }()
    
    private let field: UITextField = {
        let field = UITextField()
        field.returnKeyType = .done
        return field
    }()
    
    override init(style: UITableViewCell.CellStyle,reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        clipsToBounds = true
        contentView.addSubview(formLabel)
        contentView.addSubview(field)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    //프로필을 편집하는 양식이 될것입니다. formLabel 에서 작성하는 텍스트는 프로필화면의 모델의 라벨이 되고 이런식으로! 🤪 이틀연속 코딩만 잡고 있으려니깐 웃음을 잃어가네요 ㅜㅜ
    public func configure(with model: EditProfileFormModel) {
        formLabel.text = model.label
        field.placeholder = model.placeholder
        field.text = model.value
    }
    
    //재사용 할때 뭉개지는걸 방지 해줍니다!
    override func prepareForReuse() {
        super.prepareForReuse()
        formLabel.text = model.label
        field.placeholder = model.placeholder
        field.text = model.value
    }
    
    //MARK: - 텍스트 필드
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}
