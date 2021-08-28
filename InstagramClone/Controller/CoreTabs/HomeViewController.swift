//
//  ViewController.swift
//  InstagramClone
//
//  Created by 신지훈 on 2021/08/23.
//
import FirebaseAuth
import UIKit

//4개의 렌더뷰 모델을 래핑하기 위해 구조체를 선언합니다.
struct HomeFeedRenderViewModel {
    let header: PostRenderViewModel
    let post: PostRenderViewModel
    let action: PostRenderViewModel
    let comments: PostRenderViewModel
}


//인스타 그램처럼 피드 항목을 만들것 입니다. 만들기에 앞서 파이어베이스에서 storage를 활성화 시켜주세요!
class HomeViewController: UIViewController {

    private var feedRenderModels = [HomeFeedRenderViewModel]()
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(IGFeedPostTableViewCell.self, forCellReuseIdentifier: IGFeedPostTableViewCell.identifier)
        table.register(IGFeedPostActionTableViewCell.self, forCellReuseIdentifier: IGFeedPostActionTableViewCell.identifier)
        table.register(IGFeedPostGeneralTableViewCell.self, forCellReuseIdentifier: IGFeedPostGeneralTableViewCell.identifier)
        table.register(IGFeedPostHeaderTableViewCell.self, forCellReuseIdentifier: IGFeedPostHeaderTableViewCell.identifier)
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
        return feedRenderModels.count * 4
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let x = section
        let model: HomeFeedRenderViewModel
        if x == 0 {
            model = feedRenderModels[0]
        } else {
            //모델의 위치를 제공 합니다. 4개의 섹션에 대해 같은 모델을 사용하기 위해 이제 모델은 모델 컬렉션이며 여기의 위치는 모델을 제공합니다.
            //여기의 산술을 수행하는 이유는 모델의 컬렉션이 실제로 4개의 섹션을 나타내는 객체들을 보유하기 때문입니다 위의 numberOfSections 모델의 수를 4로 곱한 수이므로 모델을 가져오기 위해 산술을 수행한 다음 각각에 하위 섹션이 있으므로 0,1,2 또는 3을 알아낼 것입니다. 이를 기반으로 다른수의 행을 반환할수 있습니다.
        let position = x % 4 == 0 ? x/4 : ((x - (x % 4)) / 4)
            model = feedRenderModels[position]
        }
        let subSection = x % 4
        //헤더,게시물,액션의 경우 언제나 한개의 행을 반환 받지만 댓글의 경우는 하나 이상이 있을수 있으므로 다릅니다.
        if subSection == 0 {
            //header
            return 1
        } else if subSection == 1 {
            //post
            return 1
        } else if subSection == 2 {
            //action
            return 1
        } else if subSection == 3 {
            //comments
            let commentsModel = model.comments
            switch commentsModel.renderType {
            case .comments(let comments):
                return comments.count > 2 ? 2 : comments.count
            @unknown default: fatalError("올바르지 않은 케이스 입니다.")
            }
            
        }
        
        //        switch feedRenderModels[section].renderType {
        //        case .actions(provider: _): return 1
        //            //코멘트의 수를 제한 합니다 4개의 행만 보여줄것입니다. 4개 이하라면 모두 보여줍니다.
        //        case .comments(comments: let comments): return comments.count > 4 ? 4 : comments.count
        //        case .header(provider: _): return 1
        //        case .primaryContent(Provider: _): return 1
        //        }
        
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let x = indexPath.section
        let model: HomeFeedRenderViewModel
        if x == 0 {
            model = feedRenderModels[0]
        } else {
            let position = x % 4 == 0 ? x/4 : ((x - (x % 4)) / 4)
            model = feedRenderModels[position]
        }
        let subSection = x % 4
        //헤더,게시물,액션의 경우 언제나 한개의 행을 반환 받지만 댓글의 경우는 하나 이상이 있을수 있으므로 다릅니다.
        if subSection == 0 {
            //header
            let headerModel = model.header
            switch headerModel.renderType {
            case .header(let user):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostHeaderTableViewCell.identifier, for: indexPath) as! IGFeedPostHeaderTableViewCell
                return cell
            @unknown default:
                fatalError()
            }
        } else if subSection == 1 {
            //post
            let postModel = model.post
            switch postModel.renderType {
            case .primaryContent(let post):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostTableViewCell.identifier, for: indexPath) as! IGFeedPostTableViewCell
                return cell
            @unknown default:
                fatalError()
            }
        } else if subSection == 2 {
            //action
            let actionModel = model.action
            switch actionModel.renderType {
            case .actions(let provider):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostActionTableViewCell.identifier, for: indexPath) as! IGFeedPostActionTableViewCell
                return cell
            @unknown default:
                fatalError()
            }
        } else if subSection == 3 {
            //comments
            let commentsModel = model.comments
            switch commentsModel.renderType {
            case .comments(let comments):
                let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostGeneralTableViewCell.identifier, for: indexPath) as! IGFeedPostGeneralTableViewCell
                return cell
            @unknown default:
                fatalError()
            }
        }
        
        switch model.renderType {
        case .actions(provider: let actions):
            let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostActionTableViewCell.identifier, for: indexPath) as! IGFeedPostActionTableViewCell
            return cell
        case .comments(comments: let comments):
            let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostGeneralTableViewCell.identifier, for: indexPath) as! IGFeedPostGeneralTableViewCell
            return cell
        case .header(provider: let post):
            let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostHeaderTableViewCell.identifier, for: indexPath) as! IGFeedPostHeaderTableViewCell
            return cell
        case .primaryContent(Provider: let user):
            let cell = tableView.dequeueReusableCell(withIdentifier: IGFeedPostTableViewCell.identifier, for: indexPath) as! IGFeedPostTableViewCell
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let model = feedRenderModels[indexPath.section]
        switch model.renderType {
        case .actions(_): return 60
        case .comments(_): return 50
        case .header(_): return 70
        case .primaryContent(_): return tableView.width
        }
    }
    
}
