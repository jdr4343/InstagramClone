//
//  LoginViewController.swift
//  InstagramClone
//
//  Created by 신지훈 on 2021/08/24.
//

import SafariServices
import UIKit

class LoginViewController: UIViewController {

    //MARK: - 요소
    
    //이메일/ 패스워드 텍스트 필드 생성
    private let usernameEmailField: UITextField = {
        let field = UITextField()
        field.placeholder = "이메일"
        field.backgroundColor = .secondarySystemBackground
        field.returnKeyType = .next
        field.leftViewMode = .always
        //왼쪽에 너무 붙어 있지 않도록 띄워 줍니다.
        field.leftView = UIView(frame: CGRect(x: 0, y: 0,
                                              width: 10, height: 0))
        //자동으로 대문자가 되지 않도록 설정합니다. / 자동완성기능을 꺼서 자동으로 글자가 수정 되는일이 없도록 합니다.
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        //텍스트 뷰의 테두리가 기준으로 잘리게 설정하고 /약간의 모서리 반경을 주겠습니다.
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        //테두리 추가
        field.layer.borderWidth = 1.0
        field.layer.borderColor = UIColor.secondaryLabel.cgColor
        return field
    }()
    
    private let passwordField: UITextField = {
        let field = UITextField()
        field.isSecureTextEntry = true // 이 속성을 추가 해주면 글을 적을때 ***이렇게 뜬답니다!
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
    
    //로그인 버튼 / 서비스 약관 버튼/ 개인 정보 정책 / 회원가입 버튼  생성
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그인", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 18)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        return button
    }()
    
    private let termsButton: UIButton = {
        let button = UIButton()
        button.setTitle("서비스약관", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 12)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
    }()
    
    
    private let privacyButton: UIButton = {
        let button = UIButton()
        button.setTitle("개인정보처리방침", for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 12)
        button.setTitleColor(.secondaryLabel, for: .normal)
        return button
    }()
    
    private let createAccountButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 15)
        button.setTitle("계정이 없으신가요?가입하기", for: .normal)
        return button
    }()
    
    //헤더 뷰 생성
    private let headerView: UIView = {
        let header = UIView()
        //서브 뷰의 테두리 기준으로 잘리게 설정하겠습니다. clipsToBounds나 masksToBounds 를 설정하지 않으면 cornerRadius로 둥글게 만들었을때 잘라내어도 텍스트가 보일수 있습니다.
        header.clipsToBounds = true
        //헤더에 이미지를 추가합니다.
        let backgroundImageView = UIImageView(image: UIImage(named: "인스타그램그라디언트"))
        header.addSubview(backgroundImageView)
        return header
    }()
    
    
    //MARK: - 화면
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()
        view.backgroundColor = .systemBackground
        //사용자가 엔터키를 누르면 자동으로 넘어가게 하기위해 델리게이트 필드에 델리게이트 연결
        usernameEmailField.delegate = self
        passwordField.delegate = self
        
        //버튼 타겟 설정.
        loginButton.addTarget(self, action: #selector(didTabLoginButton), for: .touchUpInside)
        termsButton.addTarget(self, action: #selector(didTabTermsButton), for: .touchUpInside)
        privacyButton.addTarget(self, action: #selector(didTabPrivacyButton), for: .touchUpInside)
        createAccountButton.addTarget(self, action: #selector(didTabCreateAccountButton), for: .touchUpInside)
        
    }
    
    //프레임을 설정합니다.
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        headerView.frame = CGRect(
            x: 0,
            y: 0.0,
            width: view.width,
            height: view.height/3.0
        )
        usernameEmailField.frame = CGRect(
            x: 25,
            y: headerView.bottom + 40,
            width: view.width - 50,
            height: 52
        )
        passwordField.frame = CGRect(
            x: 25,
            y: usernameEmailField.bottom + 10,
            width: view.width - 50,
            height: 52
        )
        loginButton.frame = CGRect(
            x: 25,
            y: passwordField.bottom + 10,
            width: view.width - 50,
            height: 52
        )
        createAccountButton.frame = CGRect(
            x: 25,
            y: loginButton.bottom + 5,
            width: view.width - 50,
            height: 52
        )
        termsButton.frame = CGRect(
            x: 10,
            y: view.height - view.safeAreaInsets.bottom - 100,
            width: view.width-20,
            height: 50
        )
        privacyButton.frame = CGRect(
            x: 10,
            y: view.height - view.safeAreaInsets.bottom - 50,
            width: view.width-20,
            height: 50
        )
        configureHeaderView()
    }
    
    //MARK: - 함수
    
    
    //뷰를 추가하는 함수 생성
    private func addSubViews() {
        view.addSubview(usernameEmailField)
        view.addSubview(passwordField)
        view.addSubview(loginButton)
        view.addSubview(termsButton)
        view.addSubview(privacyButton)
        view.addSubview(createAccountButton)
        view.addSubview(headerView)
    }
    
    //헤더 뷰 구성 / 서브뷰는 하나만 있어야 하므로 제약을 추가하겠습니다
    private func configureHeaderView() {
        guard headerView.subviews.count == 1 else {
         return
        }
        //헤더뷰의 첫번째 서브뷰(이미지뷰)가 헤더뷰를 꽉 채우도록 경계를 정해줍니다.
        guard let backgroundView = headerView.subviews.first else {
            return
        }
        backgroundView.frame = headerView.bounds
        
        //인스타그램 로고를 추가하겠습니다.
        let imageView = UIImageView(image: UIImage(named: "인스타그램텍스트"))
        headerView.addSubview(imageView)
        imageView.contentMode = .scaleAspectFit
        imageView.frame = CGRect(
            x: headerView.width/4,
            y: view.safeAreaInsets.top,
            width: headerView.width/2.0,
            height: headerView.height - view.safeAreaInsets.top
        )
    }
    
    //MARK: - 버튼 액션
    
    @objc private func didTabLoginButton() {
        //탭 될때 키보드를 닫도록 설정
        passwordField.resignFirstResponder()
        usernameEmailField.resignFirstResponder()
        //텍스트가 비어 있는지 / 패스워드가 8자 이상인지 유효성 검사
        guard let usernameEmail = usernameEmailField.text, !usernameEmail.isEmpty,
              let password = passwordField.text, !password.isEmpty, password.count >= 8 else {
            return
        }
        
        //로그인 기능 구현
        var username: String?
        var email: String?
        
        //"@","."을 포함하면 이메일로 저장하고 아니라면 사용자이름으로 저장하겠습니다.
        if usernameEmail.contains("@"),usernameEmail.contains(".") {
            email = usernameEmail
        } else {
            username = usernameEmail
        }
        
        //사용자 정보를 확인하고 맞다면 창을 닫고 아니라면 경고 메시지를 띄우겠습니다. / async를 사용하여 비동기 처리 하겠습니다.
        AuthManager.shared.loginUser(
            username: username ,
            email: email,
            password: password) { success in
            DispatchQueue.main.async {
                if success {
                    self.dismiss(animated: true, completion: nil)
                } else {
                    let alert = UIAlertController(
                        title: "회원정보가 다릅니다.",
                        message: "아이디 혹은 패스워드가 다릅니다.",
                        preferredStyle: .alert)
                    alert.addAction(UIAlertAction(
                                        title: "닫기",
                                        style: .cancel,
                                        handler: nil))
                    self.present(alert, animated: true)
                }
            }
            
        }
    }
    
    @objc private func didTabTermsButton() {
        //url은 옵셔널값이기 때문에 가드문으로 바인딩 해줍니다.
        guard let url = URL(string: "https://help.instagram.com/581066165581870") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
    }
    
    @objc private func didTabPrivacyButton() {
        guard let url = URL(string: "https://help.instagram.com/519522125107875") else {
            return
        }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true)
        
    }
    
    @objc private func didTabCreateAccountButton() {
        let vc = RegistrationViewController()
        vc.title = "계정 생성"
        present(UINavigationController(rootViewController: vc),animated: true)
    }
    
    
}

//MARK: - 델리게이트

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        //사용자가 리턴키를 탭할떄 자동으로 다음으로 넘어가도록 구현
        if textField == usernameEmailField {
            passwordField.becomeFirstResponder()
        } else if textField == passwordField {
            didTabLoginButton()
        }
        return true
    }
    
}
