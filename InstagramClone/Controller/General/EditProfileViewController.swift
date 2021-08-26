//
//  EditProfileViewController.swift
//  InstagramClone
//
//  Created by 신지훈 on 2021/08/24.
//

import UIKit

struct EditProfileFormModel {
    let label: String
    let placeholder: String
    var value : String?
}


final class EditProfileViewController: UIViewController {

    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    private var models = [[EditProfileFormModel]]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.tableHeaderView = createTableHeaderView()
        tableView.dataSource = self
        configureModels()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTabSave))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "닫기",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(didTabCancel))
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }

    private func configureModels() {
        //이름, 사용자 이름, 웹사이트, 약력
        let sectionLabels1 = ["이름","사용자 이름","약력"]
        var section1 = [EditProfileFormModel]()
        for label in sectionLabels1 {
            let model = EditProfileFormModel(label: label, placeholder: "Enter\(label)...", value: nil)
            section1.append(model)
        }
        models.append(section1)
        //이메일, 폰번호 , 성별
        let sectionLabels2 = ["이메일","전화 번호","성별"]
        var section2 = [EditProfileFormModel]()
        for label in sectionLabels2 {
            let model = EditProfileFormModel(label: label, placeholder: "Enter\(label)...", value: nil)
            section2.append(model)
        }
        models.append(section2)
    }
    
    
    //MARK: - 액션
    
    @objc private func didTabSave() {
        
    }

    @objc private func didTabCancel() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc private func didTapChangeProfilePicture() {
        let actionSheet = UIAlertController(title: "프로필 사진 변경",
                                            message: "프로필 사진을 변경 하시겠습니까?",
                                            preferredStyle: .actionSheet)
        actionSheet.addAction(UIAlertAction(title: "사진 찍기",style: .default,handler: { _ in
                                                
                                            }))
        actionSheet.addAction(UIAlertAction(title: "사진 앨범에서 선택하기",style: .default,handler: { _ in
                                                
                                            }))
        actionSheet.addAction(UIAlertAction(title: "닫기",style: .cancel,handler: nil))
        
        //아이패드에서 크래쉬를 겪지 않기 위해 두가지 코드 추가
        actionSheet.popoverPresentationController?.sourceView = view
        actionSheet.popoverPresentationController?.sourceRect = view.bounds
        
        present(actionSheet, animated: true)
    }

    @objc private func didTabProfilePhotoButton() {
        
    }
}

//MARK: -테이블 뷰

extension EditProfileViewController: UITableViewDataSource {
    //헤더 생성
    private func createTableHeaderView() -> UIView {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: view.width, height: view.height/4).integral)
        
            //사용자의 프로필의 현재사진을 보여주고 그것을 탭 하면 사용자가 자신의 사진을 변경할수 있도록 하는 버튼을 추가하겠습니다
        let size = header.height/1.5
        let ProfilePhotoButton = UIButton(frame: CGRect(x: (view.width-size)/2,
                                                        y: (header.height-size)/2,
                                                        width: size, height: size))
        header.addSubview(ProfilePhotoButton)
        ProfilePhotoButton.layer.masksToBounds = true
        ProfilePhotoButton.layer.cornerRadius = size/2.0
        ProfilePhotoButton.setBackgroundImage(UIImage(systemName: "person.circle"), for: .normal)
        ProfilePhotoButton.tintColor = .label
        ProfilePhotoButton.layer.borderWidth = 1
        ProfilePhotoButton.layer.borderColor = UIColor.secondarySystemBackground.cgColor
        ProfilePhotoButton.addTarget(self, action: #selector(didTabProfilePhotoButton), for: .touchUpInside)
        
        
        
        return header
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.section][indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = model.label
        return cell
    }
    //푸터
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        guard section == 1 else{
            return nil
        }
        return "개인 정보"
    }
    
}
