//
//  FormTableViewCell.swift
//  InstagramClone
//
//  Created by 신지훈 on 2021/08/26.
//

import UIKit

//리턴키를 누르면 컨트롤러가 값을 반환하기를 원하므로 protocol을 선언하겠습니다. 업데이트할 모델을 선택하여 연결합니다. 우리의 경우 EditProfileViewController에서 만들었던 EditProfileFormModel을 연결하여 리턴키를 누르면 값을 전달하도록 구현할 것입니다.
protocol FormTableViewCellDelegate: AnyObject {
    func formTableViewCell(_ cell: FormTableViewCell, didUpdateField updateModel: EditProfileFormModel)
}


//셀 안의 텍스트 라벨을 만들어서 수정 가능하게 하겠습니다.
class FormTableViewCell: UITableViewCell, UITextFieldDelegate{

    static let identifier = "FormTableViewCell"

    //위에서 생성한 프로토콜을 연결하여 줍니다.
    public weak var delegate: FormTableViewCellDelegate?
    
    //모델 연결
    private var model: EditProfileFormModel?
    
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
        //contentView는 보통 셀 안이라고 보시면 됩니다.지금 이경우에는 셀안에 라벨을 추가하고 필드를 추가하고 있습니다.
        contentView.addSubview(formLabel)
        contentView.addSubview(field)
        field.delegate = self
        //셀이 선택되지 않도록 하겠습니다.
        selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        formLabel.frame = CGRect(x: 10,
                                 y: 0,
                                 width: contentView.width/3,
                                 height: contentView.height)
        field.frame = CGRect(x: formLabel.right + 5,
                             y: 0,
                             width: contentView.width-10-formLabel.width,
                             height: contentView.height)
    }
    //프로필을 편집하는 양식이 될것입니다. formLabel 에서 작성하는 텍스트는 프로필화면의 모델의 라벨이 되고 이런식으로! 🤪 이틀연속 코딩만 잡고 있으려니깐 웃음을 잃어가네요 ㅜㅜ
    public func configure(with model: EditProfileFormModel) {
        self.model = model
        formLabel.text = model.label
        field.placeholder = model.placeholder
        field.text = model.value
    }
    
    //재사용 할때 뭉개지는걸 방지 해줍니다!
    override func prepareForReuse() {
        super.prepareForReuse()
        formLabel.text = nil
        field.placeholder = nil
        field.text = nil
    }
    
    //MARK: - 텍스트 필드
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //사용자가 필드에서 리턴 키를 누를때마다 그들이 편집하고 있다는걸 델리게이트에게 알립니다.우리는 위의 configure와 동일한 방식으로 생각하면 좀더 이해하기 쉽습니다.
        model?.value = textField.text
        guard let model = model else {
            return true
        }
        delegate?.formTableViewCell(self, didUpdateField: model)
        textField.resignFirstResponder()
        return true
    }
}
