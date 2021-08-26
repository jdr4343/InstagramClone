//
//  EditProfileViewController.swift
//  InstagramClone
//
//  Created by 신지훈 on 2021/08/24.
//

import UIKit

class EditProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "저장",
                                                            style: .done,
                                                            target: self,
                                                            action: #selector(didTabSave))
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "닫기",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(didTabCancel))

        
    }
    
    
    @objc func didTabSave() {
        
    }

    @objc func didTabCancel() {
        
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

}
