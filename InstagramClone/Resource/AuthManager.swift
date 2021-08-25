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
    
    //회원가입
    public func registerNewUser(username: String,email: String, password: String, completion: @escaping (Bool) -> Void) {
        
        //-사용자이름을 사용할수 있는지 확입합니다.
        //-아메일을 사용할수 있는지 확인합니다. /계정당 하나의 이메일만 연결 할수 있습니다.
        
        DatabaseManger.shared.canCreateNewUser(with: email, username: username) { canCreate in
            if canCreate {
                //-계정을 생성합니다.
                //-데이터베이스에 계정을 등록합니다.
                Auth.auth().createUser(withEmail: email, password: password) { createResult, error in
                    guard error == nil, createResult != nil else {
                        print("파이어베이스에서 계정을 만들수 없습니다.")
                        completion(false)
                        return
                    }
                    //데이터베이스에 등록
                    DatabaseManger.shared.insertNewUser(with: email, username: username) { inserted in
                        if inserted {
                            print("등록성공")
                            completion(true)
                            return
                        } else {
                            print("등록실패")
                            completion(false)
                            return
                        }
                    }
                }
            } else {
                print("유저 이름 또는 이메일이 잘못되었습니다.")
                completion(false)
            }
        }
    }
    
    ///로그인을 시도 합니다.
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
    
    /// 로그아웃을 시도합니다.
    public func logOut(completion: (Bool) -> Void) {
        do {
            try Auth.auth().signOut()
            completion(true)
            return
        }
        catch {
            print(error)
            completion(false)
            return
        }
    }
    
    
    
}
