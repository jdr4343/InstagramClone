//
//  StorageManager.swift
//  InstagramClone
//
//  Created by 신지훈 on 2021/08/24.
//
//사용자가 사진이나 비디오를 업로드 하여 firebase 클라우드 저장했을때 사용할 저장소 관리자를 만들어줍니다.
import FirebaseStorage

public class StorageManager {
    
    static let shared = StorageManager()
    
    //스토리지를 사용하기 위해 스토리지를 참조 하겠습니다.
    private let bucket = Storage.storage().reference()
    
    //MARK: - public
    
    //사용자의 사진 게시물을 업로드 합니다.
    public func uploadUserPost(model: UserPost, completion: (Result<URL, Error>) -> Void) {
        
    }
    public func downloadImage(with url:URL)
}

//MARK: - model
public enum UserPostType {
    case photo, video
}

public struct UserPost {
    let postType: UserPostType
}
