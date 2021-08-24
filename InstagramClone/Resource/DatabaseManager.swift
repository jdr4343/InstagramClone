//
//  DatabaseManager.swift
//  InstagramClone
//
//  Created by 신지훈 on 2021/08/24.
//

//데이터를 관리할 파일을 만듭니다!
import FirebaseDatabase

//모든 파일들에서 접근할수 있도록 public으로 만들어 줍니다! 그리고 단일 인스턴스를 가질것 이므로 static으로 정적 상수를 만들어 줍니다!
public class DatabaseManger {
    
    static let shared = DatabaseManger()
    
    //데이터 베이스를 사용하기 위해 데이터베이스를 참조 하겠습니다.
    private let database = Database.database().reference()
    
    //MARK: - public
    
     
    ///이메일과 유저이름을 사용할수 있는지 확인합니다.
    ///-parameter
    ///    -email: 이메일을 나타내는 문자열입니다.
    ///    -username: 유저이름을 나타내는 문자열입니다
    public func canCreateNewUser(with email: String, username: String, completion: (Bool) -> Void) {
        completion(true)
    }
    ///신규 회원가입 유저의 데이터를 데이터베이스에 추가합니다.
    ///-parameter
    ///    -email: 이메일을 나타내는 문자열입니다.
    ///    -username: 유저이름을 나타내는 문자열입니다
    ///    -completion: 데이터베이스 입력이 성공한 경우 결과에 대한 비동기 콜백입니다.
    public func insertNewUser(with email: String, username: String, completion: @escaping (Bool) -> Void) {
        //노드 삽입 / 키가 이메일이될 자식함수를 생성합니다.
        
        database.child(email.safeDatabaseKey()).setValue(["username": username]) { error, _  in
            if error == nil {
                //성공
                completion(true)
                return
            } else {
                //실패
                completion(false)
                return
            }
            
        }
    }

    
    
    
}

