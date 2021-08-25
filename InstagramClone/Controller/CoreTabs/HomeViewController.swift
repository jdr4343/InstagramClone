//
//  ViewController.swift
//  InstagramClone
//
//  Created by 신지훈 on 2021/08/23.
//
import FirebaseAuth
import UIKit

//인스타 그램처럼 피드 항목을 만들것 입니다. 만들기에 앞서 파이어베이스에서 storage를 활성화 시켜주세요!
class HomeViewController: UIViewController {

    private let tableView: UITableView = {
        let table = UITableView()
        table.register(IGFeedPostTableViewCell.self, forCellReuseIdentifier: IGFeedPostTableViewCell.identifier)
        return table
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
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

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostTableViewCell.identifier, for: indexPath) as? IGFeedPostTableViewCell else {
            fatalError()
        }
        cell.textLabel?.text = ""
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
