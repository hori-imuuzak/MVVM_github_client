//
//  UserListCellViewModel.swift
//  MVVM_github_client
//
//  Created by 堀知海 on 2020/05/18.
//  Copyright © 2020 umichan. All rights reserved.
//

import Foundation
import RxSwift

class UserCellViewModel {
    private var user: User
    
    var nickName: String {
        return user.name
    }
    
    var webURL: String {
        return user.webURL
    }
    
    init(user: User) {
        self.user = user
    }
}
