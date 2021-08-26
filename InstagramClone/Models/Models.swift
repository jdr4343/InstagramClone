
//
//  Model.swift
//  InstagramClone
//
//  Created by 신지훈 on 2021/08/27.
//

import Foundation
//MARK: - model
public enum UserPostType {
    case photo, video
}

enum Gender {
    case male, female, other
}

//사용자 게시물을 나타내는 모델입니다.
public struct UserPost {
    let identifier: String
    let postType: UserPostType
    let thumbnailImage: URL
    let postURL: URL //비디오url 혹은 사진 입니다.
    let caption: String?
    let linkCount: [PostLikes]
    let comments: [PostComment]
    let createDate: Date
    let taggudUsers: [String]
}

struct PostLikes {
    let username: String
    let postIdentifier: String
}

struct CommentLikes {
    let username: String
    let commentIdentifier: String
}

struct PostComment {
    let identifier: String
    let username: String
    let text: String
    let createDate: Date
    let likes: [CommentLikes]
}

struct User {
    let username: String
    let bio: String
    let name: (first: String, last: String)
    let birthDate: Date
    let gender: Gender
    let counts: UserCounts
    let joinDate: Date
}

struct UserCounts {
    let followers: Int
    let following: Int
    let post: Int
}

//에러 항목을 정의 합니다.
public enum IGStoreageManagerError: Error {
    case failedToDownload
}

