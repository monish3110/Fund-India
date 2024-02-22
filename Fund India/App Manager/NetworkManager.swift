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
    var tokenValue = "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"
    let clientID = "7f0715dce47dee4dad9f"
    let clientSecret = "074d8bed3a218ed5e28bdcabf5cd2c2e2c8b73f8"
    
    func hasConnected(shouldAlert: Bool) -> Bool{
        if reachabilityManager?.isReachable == true{
            return true
        }
        return false
    }
    
    func configureCurrentSession() -> HTTPHeaders {
        print("headertokenvalue",tokenValue)
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
