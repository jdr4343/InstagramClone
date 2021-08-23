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
        
        return field
    }()
    
    private let passwordField: UITextField = {
        let field = UITextField()
        field.isSecureTextEntry = true // 이 속성을 추가 해주면 글을 적을때 ***이렇게 뜬답니다!
        return field
    }()
    
    //로그인 버튼 / 서비스 약관 버튼/ 개인 정보 정책 / 회원가입 버튼  생성
    private let loginButton: UIButton = {
        let button = UIButton()
    
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
       
        return button
    }()
    
    //헤더 뷰 생성
    private let headerView: UIView = {
        let header = UIView()
        
        return header
    }()
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubViews()

        view.backgroundColor = .systemBackground
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
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
