//
//  LoginModel.swift
//  Fund India
//
//  Created by Monish M on 22/02/24.
//

import Foundation

struct LoginModel {
    var client_id: String?
    var client_secret: String?
    var code: String?
    
    func toDictionary() -> [String: Any] {
        var dictionary = [String: Any]()
        
        let mirror = Mirror(reflecting: self)
        for child in mirror.children {
            if let label = child.label {
                dictionary[label] = child.value
            }
        }
        
        return dictionary
    }
}

struct TokenData: Codable {
    let accessToken: String?
    let tokenType: String?
    
    enum CodingKeys: String, CodingKey {
        case accessToken = "access_token"
        case tokenType = "token_type"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        accessToken = try values.decodeIfPresent(String.self, forKey: .accessToken)
        tokenType = try values.decodeIfPresent(String.self, forKey: .tokenType)
    }
}
