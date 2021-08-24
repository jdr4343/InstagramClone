//
//  RegistrationViewController.swift
//  InstagramClone
//
//  Created by 신지훈 on 2021/08/24.
//

import UIKit

class RegistrationViewController: UIViewController {

    private let usernameField: UITextField = {
        let field = UITextField()
        field.placeholder = "이름"
        field.backgroundColor = .secondarySystemBackground
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0,
                                              width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        //테두리 추가
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    private let emailField: UITextField = {
        let field = UITextField()
        field.placeholder = "이메일 주소"
        field.backgroundColor = .secondarySystemBackground
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0,
                                              width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        //테두리 추가
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    private let passwordField: UITextField = {
        let field = UITextField()
        field.isSecureTextEntry = true
        field.placeholder = "비밀번호"
        field.backgroundColor = .secondarySystemBackground
        field.returnKeyType = .continue
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0,
                                              width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    
    private let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("회원 가입", for: .normal) 
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        return button
    }()
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        usernameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        view.addSubview(usernameField)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(registerButton)
        registerButton.addTarget(self, action: #selector(didTabRegisterButton), for: .touchUpInside)
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        usernameField.frame = CGRect(x: 20, y: view.safeAreaInsets.top+100, width: view.width-40, height: 52)
        emailField.frame = CGRect(x: 20, y: usernameField.bottom+10, width: view.width-40, height: 52)
        passwordField.frame = CGRect(x: 20, y: emailField.bottom+10, width: view.width-40, height: 52)
        registerButton.frame = CGRect(x: 20, y: passwordField.bottom+10, width: view.width-40, height: 52)
    }

    //회원 가입 버튼 기능 구현 / 사용자가 모든 데이터를 이상없이 전달했을경우 AuthManager를 통해서 계정을 생성하겠습니다.
    @objc func didTabRegisterButton() {
        usernameField.resignFirstResponder()
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        guard let username = usernameField.text, !username.isEmpty,
              let email = emailField.text, !email.isEmpty,
              let password = passwordField.text, !password.isEmpty, password.count >= 8 else {
            return
        }
        AuthManager.shared.registerNewUser(username: username, email: email, password: password) { registerd in
            DispatchQueue.main.async {
                if registerd {
                    //성공
                } else {
                    //실패
                }
            }
        }
    }
}

extension RegistrationViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == usernameField {
            emailField.becomeFirstResponder()
        } else if textField == emailField {
            passwordField.becomeFirstResponder()
        } else if textField == passwordField {
            didTabRegisterButton()
        }
        return true
    }
}
