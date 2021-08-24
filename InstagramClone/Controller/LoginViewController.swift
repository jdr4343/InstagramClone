//
//  LoginViewController.swift
//  InstagramClone
//
//  Created by 신지훈 on 2021/08/24.
//

import UIKit

class LoginViewController: UIViewController {

    
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
        return field
    }()
    
    private let passwordField: UITextField = {
        let field = UITextField()
        field.isSecureTextEntry = true // 이 속성을 추가 해주면 글을 적을때 ***이렇게 뜬답니다!
        field.placeholder = "비밀번호"
        field.backgroundColor = .secondarySystemBackground
        field.returnKeyType = .next
        field.leftViewMode = .always
        field.leftView = UIView(frame: CGRect(x: 0, y: 0,
                                              width: 10, height: 0))
        field.autocapitalizationType = .none
        field.autocorrectionType = .no
        field.layer.masksToBounds = true
        field.layer.cornerRadius = Constants.cornerRadius
        return field
    }()
    
    //로그인 버튼 / 서비스 약관 버튼/ 개인 정보 정책 / 회원가입 버튼  생성
    private let loginButton: UIButton = {
        let button = UIButton()
        button.setTitle("로그인", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = Constants.cornerRadius
        return button
    }()
    
    private let termsButton: UIButton = {
        let button = UIButton()
        
        return button
    }()
    
    
    private let privacyButton: UIButton = {
        let button = UIButton()
       
        return button
    }()
    
    private let createAccountButton: UIButton = {
        let button = UIButton()
        button.setTitleColor(.label, for: .normal)
        button.setTitle("계정이 없으신가요? 저희의 새로운 회원이 되어주세요!", for: .normal)
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
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()

        view.backgroundColor = .systemBackground
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
        configureHeaderView()
    }
    
    
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
        imageView.contentMode.rawValue
    }
    
    
    //버튼의 액션을 생성
    @objc private func didTabLoginButton() {
        
    }
    
    @objc private func didTabTermsButton() {
        
    }
    
    @objc private func didTabPrivacyButton() {
        
    }
    
    @objc private func didTabCreateAccountButton() {
        
    }


}
