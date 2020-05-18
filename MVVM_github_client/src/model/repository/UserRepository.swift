//
//  UserRepository.swift
//  MVVM_github_client
//
//  Created by 堀知海 on 2020/05/18.
//  Copyright © 2020 umichan. All rights reserved.
//

import RxSwift

protocol UserRepository {
    func getUsers() -> Observable<Response<Array<User>>>
}
