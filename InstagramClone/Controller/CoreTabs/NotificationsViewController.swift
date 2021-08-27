//
//  NotificationsViewController.swift
//  InstagramClone
//
//  Created by 신지훈 on 2021/08/24.
//

import UIKit

enum UserNotificationType {
    case like(post: UserPost)
    case follow(state: FollowState)
}

struct UserNotification {
    let type: UserNotificationType
    let text: String
    let user: User
}

final class NotificationsViewController: UIViewController {

    private let tableView: UITableView = {
        let table = UITableView()
        table.register(NotificationLikeEventTableViewCell.self,
                       forCellReuseIdentifier: NotificationLikeEventTableViewCell.identifier)
        table.register(NotificationFollowEventTableViewCell.self,
                       forCellReuseIdentifier: NotificationFollowEventTableViewCell.identifier)
        table.isHidden = false
        return table
    }()
    //NoNotificationView를 lazy로 선언합니다. 필요하지 않은 경우 인스턴스화 하지 않기 위해서 입니다.
    private lazy var noNotificationView = NoNotificationView()
    
    private var models = [UserNotification]()
    //MARK: Lifecycle
    
    //알림을 불러오고 있는 로딩시간에 보여줄 스피너를 추가 하겠습니다.
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(style: .large)
        spinner.hidesWhenStopped = true
        spinner.tintColor = .label
        return spinner
    }()
      
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //탭바에 타이틀이 뜨지 않기 위해 navigationItem으로 지정 했습니다.
        navigationItem.title = "알림"
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        view.addSubview(spinner)
      //  spinner.startAnimating()
        tableView.delegate = self
        tableView.dataSource = self
        fetchNotification()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        spinner.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        spinner.center = view.center
    }
    
    
    
    private func addNoNotification() {
        view.addSubview(tableView)
        tableView.isHidden = true
        noNotificationView.frame = CGRect(x: 0, y: 0, width: view.width/2, height: view.width/4)
        noNotificationView.center = view.center
    }
    
    private func fetchNotification() {
        for x in 0...100 {
            let user = User(username: "sjh_04_26",
                                bio: "",
                                name: "신지훈",
                                Profilephoto: URL(string: "https://www.google.com/")!,
                                birthDate: Date(),
                                gender: .male,
                                counts: UserCounts(followers: 9999, following: 120, post: 99),
                                joinDate: Date())
            
            
            let post = UserPost(identifier: "",
                                postType: .photo,
                                thumbnailImage: URL(string: "https://www.google.com/")!,
                                postURL: URL(string: "https://www.google.com/")!,
                                caption: nil,
                                likeCount: [],
                                comments: [],
                                createDate: Date(),
                                taggudUsers: [],
                                owner: user)
            let model = UserNotification(type: x % 2 == 0 ? .like(post: post) : .follow(state: .Unfollowing),
                                         text: "..난 할수 있다!!",
                                         user: user)
            models.append(model)
        }
    }
}


extension NotificationsViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = models[indexPath.row]
        switch model.type {
        case .like(_):
            //라이크 셀 연결
            let cell = tableView.dequeueReusableCell(withIdentifier: NotificationLikeEventTableViewCell.identifier, for: indexPath) as! NotificationLikeEventTableViewCell
            cell.configure(with: model)
            cell.delegate = self
            return cell
        case .follow:
            //팔로우 셀 연결
            let cell = tableView.dequeueReusableCell(withIdentifier: NotificationFollowEventTableViewCell.identifier, for: indexPath) as! NotificationFollowEventTableViewCell
            //cell.configure(with: model)
            cell.delegate = self
            return cell
        }
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    //셀높이
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 84
    }
    
    
}
//MARK: - NotificationLikeEventTableViewCellDelegate
//포스트 버튼 액션
extension NotificationsViewController: NotificationLikeEventTableViewCellDelegate {
    func didTapRelatedPostButton(model: UserNotification) {
        //게시물을 오픈 합니다.
        switch model.type {
        //좋아요의 경우 게시물을 가져오고 팔로우 알림이 있는 경우 게시물에 대한 좋아요 버튼은 좋아요에만 표시되어야 하므로 fatalError() 를 반환 합니다.
        case .like(post: let post):
            let vc = PostViewController(model: post)
            vc.title = post.postType.rawValue
            vc.navigationItem.largeTitleDisplayMode = .never
            navigationController?.pushViewController(vc, animated: true)
        case .follow(state: _):
            fatalError("개발오류: 콜을 받으면 안됩니다.")
        }
        
        
    }
}

//MARK: - NotificationFollowEventTableViewDelegate

extension NotificationsViewController: NotificationFollowEventTableViewCellDelegate {
    
    func didTapFollowUnFollowButton(model: UserNotification) {
        //데이터베이스 업데이트 수행
       print("팔로우 버튼이 클릭 되었습니다")
    }
    
    
}
