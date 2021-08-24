//
//  AuthManager.swift
//  InstagramClone
//
//  Created by 신지훈 on 2021/08/24.
//

//인증 항목을 관리할 파일을 만듭니다!
import FirebaseAuth

public class AuthManager {
    static let shared = AuthManager()
    
    //MARK: - public
    
    public func registerNewUser(username: String,email: String, password: String) {
        
    }
    
    public func loginUser(username: String?, email: String?, password: String, completion: @escaping (Bool) -> Void) {
        if let email = email {
            Auth.auth().signIn(withEmail: email, password: password) { authResult, error in
                //인증 결과가 nil이 아니고 오류가 nil과 같을떄 completion(true)를 호출하고 else라면 false를 반환 합니다!
                guard authResult != nil, error == nil else {
                    completion(false)
                    return
                }
                completion(true)
            }
        } else if let username = username {
            print(username)
        }
    }
}
