//
//  SettingsViewController.swift
//  InstagramClone
//
//  Created by 신지훈 on 2021/08/24.
//

//MARK: - 모델

struct SettingCellModel {
    let title: String
    let handler: (() -> Void)
}

//MARK: - final class

import UIKit
///컨트롤러 화면 사용자 설정을 표시합니다.
final class SettingsViewController: UIViewController {

    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped)
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    //모델을 2차원 배열로 연결합니다 2차원 배열인 이유는 여러개의 섹션이 존재 할것이기 때문입니다! 🥶
    //배열안의 배열이라고 생각하면 좀더 이해하시기 수월 할거 같습니다..! [[1,1,1,1],[1,1,1,1],[1,1,1,1] 이런식으로 배열안에 배열이 있는 거죠!
    //configureModels 함수를 예시를 들어서 보면 우리가 만든 모델을 [[section],[secction]] 이런식으로 나누어 주고 있습니다.section에는 우리가 만든 모델의 요소가 들어있습니다.
    //만약 [[title,hendler],[title,hendler]] 이런식으로 2차원 배열을 만들어주면 우리는 이제 4개의 요소와 2개의 섹션이 있습니다. 아래의 테이블 뷰 델리게이트에서는 요소.count를 해서 행의 수를 반환하고 섹션.count를 해서 섹션의 수를 반환 하고 있습니다.그럼 2개의 섹션과 4개의 셀을 얻을수 있겠죠?
    private var data = [[SettingCellModel]]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureModels()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self

    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
//MARK: - 함수
    private func configureModels() {
        let section = [
            SettingCellModel(title: "로그아웃") { [weak self] in
                self?.didTabLogOut()
            }
        ]
        data.append(section)
    }
    //로그아웃 기능을 구현합니다.
    private func didTabLogOut() {
        AuthManager.shared.logOut(completion: { success in
            DispatchQueue.main.async {
                if success {
                    //로그인 화면 호출
                    let loginVC = LoginViewController()
                    loginVC.modalPresentationStyle = .fullScreen
                    self.present(loginVC,animated: true) {
                        //현재 설정화면과 모든 스택을 사라지게 하고 rootViewController로 돌아갑니다.그러한 후 탭바중 0번째 인덱스로 이동합니다.
                        self.navigationController?.popToRootViewController(animated: true)
                        self.tabBarController?.selectedIndex = 0
                    }
                } else {
                    //error
                }
            }
        })
    }

   
}

//MARK: - 확장

extension SettingsViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = data[indexPath.section][indexPath.row].title
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        //셀 선택을 처리
        let model = data[indexPath.section][indexPath.row].handler()
        
    }
    
}
