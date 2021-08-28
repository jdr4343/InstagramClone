//
//  IGFeedPostTableViewCell.swift
//  InstagramClone
//
//  Created by 신지훈 on 2021/08/26.
//
import AVFoundation
import SDWebImage
import UIKit
//피드의 기본 게시물에 대한 셀입니다.
//재생중인 비디오를 표시하거나 이미지 뷰를 표시할수 있어야 합니다.
final class IGFeedPostTableViewCell: UITableViewCell {

    static let identifier = "IGFeedPostTableViewCell"
    
    private var player: AVPlayer?
    private var playerlayer = AVPlayerLayer()
    
    //이미지 뷰를 생성합니다.
    private let postImageView: UIImageView = {
    let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.backgroundColor = nil
        imageView.clipsToBounds = true
    return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(postImageView)
        contentView.layer.addSublayer(playerlayer)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        postImageView.frame = contentView.bounds
        playerlayer.frame = contentView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        postImageView.image = nil
    }
    
    public func configure(with post: UserPost) {
        imageView?.image = UIImage(named: "인스타그램아이콘")
        return
        switch post.postType {
        case .photo:
            //이미지를 보여줍니다.
            postImageView.sd_setImage(with: post.postURL, completed: nil)
        case .video:
            //비디오를 재생합니다.
            player = AVPlayer(url: post.postURL)
            //피드를 스크롤 할떄 볼륨이 안들리도록 0으로 설정
            playerlayer.player?.volume = 0
            playerlayer.player?.play()
        }
    }
}
