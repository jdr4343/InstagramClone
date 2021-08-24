//
//  Extention.swift
//  InstagramClone
//
//  Created by 신지훈 on 2021/08/24.
//

import UIKit
//프레임을 정할때 편히 하기 위해서 도우미 파일을 만듭니다.
//이렇게 도우미 파일을 만들어두면 반복작업을 수행할일이 많이 줄어듭니다!

extension UIView {
    
    public var width: CGFloat {
        return frame.size.width
    }
    public var height: CGFloat {
        return frame.size.height
    }
    public var top: CGFloat {
        return frame.origin.y
    }
    public var bottom: CGFloat {
        return frame.origin.y + frame.size.height
    }
    public var left: CGFloat {
        return frame.origin.x
    }
    public var right: CGFloat {
        return frame.origin.x + frame.size.width
    }
}

//자주 사용할거 같은 모서리 조정을 저장하겠습니다.
struct Constants {
    static let cornerRadius: CGFloat = 8.0
}


//firebase의 데이터 베이스에는 마침표를 사용할수 없습니다. 따라서 그냥 email을 child에 삽입 할경우 에러가 나기 때문에 안전한 이메일을 생성하는 함수를 만들어 줘야 합니다.
extension String {
     func safeDatabaseKey() -> String {
        return self.replacingOccurrences(of: "@", with: "-").replacingOccurrences(of: ".", with: "-")
    }
}
