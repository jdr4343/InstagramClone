//
//  LIstViewController.swift
//  InstagramClone
//
//  Created by 신지훈 on 2021/08/24.
//

import UIKit
//현재 팔로워나 팔로잉을 보여줄 화면입니다.
class ListViewController: UIViewController {

    private let tableView: UITableView = {
        let table = UITableView()
        
        return table
    }()
    
    private let data: [String]
    
    init(data: [String]) {
        self.data = data
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        
    }
    
}
