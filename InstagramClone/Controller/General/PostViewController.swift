//
//  PostViewController.swift
//  InstagramClone
//
//  Created by 신지훈 on 2021/08/24.
//

import UIKit
/*
 Section
 - Header model
 Section
 - Post Cell model
 Section
 - Action Buttons Cell model
 Section
 - n Number of general models for comments
 */
//랜더링 된 셀인지 여부를 나타냅니다.
enum PostRenderType {
    case header(provider: User)
    case primaryContent(Provider: UserPost) //post
    case actions(provider: String) // like, comment, share
    case comments(comments: [PostComment])
        
}
//렌더링 된 게시물 모델입니다.
struct PostRenderViewModel {
    let renderType: PostRenderType
}


//게시물 화면 입니다.
class PostViewController: UIViewController {
 
    private let model: UserPost?
    
    
    private var renderModels = [PostRenderViewModel]()
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(IGFeedPostTableViewCell.self, forCellReuseIdentifier: IGFeedPostTableViewCell.identifier)
        tableView.register(IGFeedPostActionTableViewCell.self, forCellReuseIdentifier: IGFeedPostActionTableViewCell.identifier)
        tableView.register(IGFeedPostGeneralTableViewCell.self, forCellReuseIdentifier: IGFeedPostGeneralTableViewCell.identifier)
        tableView.register(IGFeedPostHeaderTableViewCell.self, forCellReuseIdentifier: IGFeedPostHeaderTableViewCell.identifier)
        return tableView
    }()
    
    //MARK: - init
    
    init(model: UserPost?) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
        configureModel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
 
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
    
    //모델 설정
    private func configureModel() {
        guard let userPostModel = self.model else {
            return
        }
        //Header
        renderModels.append(PostRenderViewModel(renderType: .header(provider: userPostModel.owner)))
        //Post
        renderModels.append(PostRenderViewModel(renderType: .primaryContent(Provider: userPostModel)))
        //Action
        renderModels.append(PostRenderViewModel(renderType: .actions(provider: "")))
        //4 Comments
        var comments = [PostComment]()
        for x in 0..<4 {
            comments.append(PostComment(identifier: "123_\(x)",
                                        username: "@신지훈",
                                        text: "오늘 날씨가 참 좋네.. ",
                                        createDate: Date(),
                                        likes: []))
        }
        renderModels.append(PostRenderViewModel(renderType: .comments(comments: comments)))
    }

}
extension PostViewController: UITableViewDelegate,UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return renderModels.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch renderModels[section].renderType {
        case .actions(provider: _): return 1
            //코멘트의 수를 제한 합니다 4개의 행만 보여줄것입니다. 4개 이하라면 모두 보여줍니다.
        case .comments(comments: let comments): return comments.count > 4 ? 4 : comments.count
        case .header(provider: _): return 1
        case .primaryContent(Provider: _): return 1
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = renderModels[indexPath.section]
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
        let model = renderModels[indexPath.section]
        switch model.renderType {
        case .actions(_): return 60
        case .comments(_): return 50
        case .header(_): return 70
        case .primaryContent(_): return tableView.width
        }
    }
    
}
