//
//  GithubUserRepository.swift
//  MVVM_github_client
//
//  Created by 堀知海 on 2020/05/18.
//  Copyright © 2020 umichan. All rights reserved.
//

import RxSwift
import Alamofire
import SwiftyJSON

class GithubUserRepository: UserRepository {
    func getUsers() -> Observable<Response<Array<User>>> {
        return Observable.create { observer -> Disposable in
            let url = "https://api.github.com/users"
            
            AF.request(url, method: .get).responseJSON { response in
                switch response.result {
                case .success(let value):
                    // TODO parse
                    let json = JSON(value)
                    var users: [User] = []
                    for githubUser in json.array! {
                        users.append(User(
                            id: githubUser["id"].intValue,
                            name: githubUser["login"].stringValue,
                            iconUrl: githubUser["avatar_url"].stringValue,
                            webURL: githubUser["html_url"].stringValue
                        ))
                    }
                    let resData = Response(status: .ok, data: users)
                    observer.onNext(resData)
                    observer.onCompleted()
                case let .failure(error):
                    observer.onError(error)
                }
            }
            
            return Disposables.create()
        }
    }
}
