//
//  ApiManager.swift
//  Fund India
//
//  Created by Monish M on 20/02/24.
//

import Foundation

enum NetworkEnvironment {
    case dev
    case stage
    case production
}


class APIManager {
    
    static let shared = APIManager()
    
    let networkEnviroment: NetworkEnvironment = .dev
    
    var baseURL: String {
        switch networkEnviroment {
            case .dev: return "https://api.github.com/"
            case .production: return "https://api.github.com/"
            case .stage: return "https://api.github.com/"
        }
    }
    
    var loginURL = "https://github.com/login/oauth/"
}

struct API {
    static let repoList = "search/repositories?q=is:public"
    static let defaultImageUrl = "https://avatars.githubusercontent.com/u/17589?v=4"
    static let githubOauthApi = "authorize"
    static let getAcessToken = "access_token"
}
