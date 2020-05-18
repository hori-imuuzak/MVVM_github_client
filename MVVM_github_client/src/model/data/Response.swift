//
//  API.swift
//  MVVM_github_client
//
//  Created by 堀知海 on 2020/05/18.
//  Copyright © 2020 umichan. All rights reserved.
//

import Foundation

enum APIStatus: Error, CustomStringConvertible {
    case ok
    case unknown
    case invalidURL
    case invalidResponse
    
    var description: String {
        switch self {
        case .ok:
            return "OK"
        case .unknown:
            return "不明なエラーです"
        case .invalidURL:
            return "無効なURLです"
        case .invalidResponse:
            return "フォーマットが無効なレスポンスを受け取りました"
        }
    }
}

class Response<T> {
    let status: APIStatus
    let data: T
    
    init(status: APIStatus, data: T) {
        self.status = status
        self.data = data
    }
}
