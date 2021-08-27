
//
//  Model.swift
//  InstagramClone
//
//  Created by 신지훈 on 2021/08/27.
//

import Foundation
//MARK: - model

//사용자가 포스트한 게시물의 타입에 대한 모델입니다.
public enum UserPostType: String{
    case photo = "Photo"
    case video = "Video"
}

//사용자 게시물을 나타내는 모델입니다.
public struct UserPost {
    let identifier: String
    let postType: UserPostType
    let thumbnailImage: URL
    let postURL: URL //비디오url 혹은 사진 입니다.
    let caption: String?
    let likeCount: [PostLikes]
    let comments: [PostComment]
    let createDate: Date
    let taggudUsers: [String]
    let owner: User
}

//좋아요를 누른 사람에대한 정보입니다.
struct PostLikes {
    let username: String
    let postIdentifier: String
}

struct CommentLikes {
    let username: String
    let commentIdentifier: String
}

//댓글을 쓴 사람에 대한 정보입니다.
struct PostComment {
    let identifier: String
    let username: String
    let text: String
    let createDate: Date
    let likes: [CommentLikes]
}

//사용자의 정보를 나타내는 모델입니다.
struct User {
    let username: String
    let bio: String
    let name: String
    let Profilephoto: URL
    let birthDate: Date
    let gender: Gender
    let counts: UserCounts
    let joinDate: Date
}

//프로필 화면의 헤더에 표시될 정보들입니다.
struct UserCounts {
    let followers: Int
    let following: Int
    let post: Int
}

//성별을 나타냅니다.
enum Gender {
    case male, female, other
}

//에러 항목을 정의 합니다.
public enum IGStoreageManagerError: Error {
    case failedToDownload
}

