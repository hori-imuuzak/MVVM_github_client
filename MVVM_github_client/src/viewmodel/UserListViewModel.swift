//
//  UserListViewModel.swift
//  MVVM_github_client
//
//  Created by 堀知海 on 2020/05/18.
//  Copyright © 2020 umichan. All rights reserved.
//

import RxSwift

enum UserListState {
    case empty
    case loading
    case completed
    case error(Error)
}

class UserListViewModel {
    private let stateSubject = BehaviorSubject<UserListState>(value: .empty)
    var userListState: Observable<UserListState> { return stateSubject }
    private let userListSubject = BehaviorSubject<Array<User>>(value: [])
    var userList: Observable<Array<User>> { return userListSubject }
    
    private let disposeBag = DisposeBag()
    private var userRepository: UserRepository!
    
    var userCellViewModelList: [UserCellViewModel] = []
    
    init(userRepository: UserRepository) {
        self.userRepository = userRepository
    }
    
    func getUsers() {
        stateSubject.onNext(.loading)
        
        self.userRepository.getUsers().subscribe(onNext: { (response: Response<Array<User>>) in
            if response.status == .ok {
                let userList = response.data
                for user in userList {
                    self.userCellViewModelList.append(UserCellViewModel(user: user))
                }
                self.userListSubject.onNext(userList)
            } else {
                self.stateSubject.onNext(.error(response.status))
            }
        }, onError: { error in
            self.stateSubject.onNext(.error(error))
        }, onCompleted: {
            self.stateSubject.onNext(.completed)
        }) {
        }.disposed(by: disposeBag)
    }
    
    func userCount() -> Int {
        return (try? userListSubject.value().count) ?? 0
    }
    
    deinit {
        self.stateSubject.dispose()
        self.userListSubject.dispose()
    }
}
