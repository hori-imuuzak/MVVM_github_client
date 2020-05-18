//
//  File.swift
//  MVVM_github_client
//
//  Created by 堀知海 on 2020/05/18.
//  Copyright © 2020 umichan. All rights reserved.
//

final class User {
    let id: Int
    let name: String
    let iconUrl: String
    let webURL: String
    
    init(id: Int, name: String, iconUrl: String, webURL: String) {
        self.id = id
        self.name = name
        self.iconUrl = iconUrl
        self.webURL = webURL
    }
}
