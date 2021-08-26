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
    
    //사용자의 게시물을 업로드 합니다.
    public func uploadUserPost(model: UserPost, completion: @escaping (Result<URL, Error>) -> Void) {
        
    }
    
    //URL이 포함된 다운로드 이미지를 다운로드 합니다.
    public func downloadImage(with reference:String, completion: @escaping (Result<URL, IGStoreageManagerError>) -> Void) {
        bucket.child(reference).downloadURL(completion: { url, error in
            guard let url = url, error == nil else {
                completion(.failure(.failedToDownload))
                return
            }
            completion(.success(url))
        })
    }
}


//MARK: - model
public enum UserPostType {
    case photo, video
}

public struct UserPost {
    let postType: UserPostType
}

//에러 항목을 정의 합니다.
public enum IGStoreageManagerError: Error {
    case failedToDownload
}

