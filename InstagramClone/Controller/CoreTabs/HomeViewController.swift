//
//  ViewController.swift
//  InstagramClone
//
//  Created by 신지훈 on 2021/08/23.
//
import FirebaseAuth
import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    //viewDidAppear는 뷰가 화면에 표시된 이후에 수행합니다!
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        hadleNotAuthenticated()
    }
    
    private func hadleNotAuthenticated() {
        if Auth.auth().currentUser == nil {
        //사용자가 회원이 아니라면 로그인 화면을 보여 줄것입니다!
            let loginVC = LoginViewController()
            loginVC.modalPresentationStyle = .fullScreen
            present(loginVC,animated: false)
        }
    }

}

