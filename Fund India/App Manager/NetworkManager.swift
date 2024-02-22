//
//  NetworkManager.swift
//  Fund India
//
//  Created by Monish M on 20/02/24.
//

import Alamofire

typealias completionBlock = (_ response: AFDataResponse<Any>?) -> Void

class NetworkManager: NSObject {
    
    static let shared = NetworkManager()
    let reachabilityManager = NetworkReachabilityManager()
    var tokenValue = ""
    let clientID = ProcessInfo.processInfo.environment["GITHUB_CLIENT_ID"] ?? ""
    let clientSecret = ProcessInfo.processInfo.environment["GITHUB_CLIENT_SECRET"] ?? ""
    
    func hasConnected(shouldAlert: Bool) -> Bool{
        if reachabilityManager?.isReachable == true{
            return true
        }
        return false
    }
    
    func configureCurrentSession() -> HTTPHeaders {
        let manager = Session.default
        manager.session.configuration.timeoutIntervalForRequest = 10800
        manager.session.configuration.timeoutIntervalForResource = 10800
        manager.session.configuration.headers = .default
        var headers = manager.session.configuration.headers
        
        headers["Accept"] = "application/vnd.github+json"
        headers["Authorization"] = "Bearer \(tokenValue)"
        return headers
    }
    
    func getApiRequest(url:String, parameters:Dictionary<String, Any>?, completion:@escaping completionBlock) {
        let headers = configureCurrentSession()
        AF.request(url,method: .get,parameters: parameters, encoding : JSONEncoding.default,headers:headers).responseJSON { sessionData in
            completion(sessionData)
        }
    }
    
    func postApiRequest(url:String, parameters:Dictionary<String, Any>,completion:@escaping completionBlock) {
        let headers = configureCurrentSession()
        AF.request(url,method: .post,parameters: parameters, encoding : JSONEncoding.default, headers: headers).responseJSON { (sessionData) in
            completion(sessionData)
        }
    }
    
}
