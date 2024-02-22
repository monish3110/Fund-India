//
//  RepoListModel.swift
//  Fund India
//
//  Created by Monish M on 20/02/24.
//

import UIKit

struct RepoListModel: Codable {
    let totalCount: Int?
    let items: [RepoListItems]?
    
    enum CodingKeys: String, CodingKey {
        case totalCount = "total_count"
        case items = "items"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        totalCount = try values.decodeIfPresent(Int.self, forKey: .totalCount)
        items = try values.decodeIfPresent([RepoListItems].self, forKey: .items)
    }
}

struct RepoListItems: Codable {
    let name: String?
    let description: String?
    let owner: Owner?
    let fullName: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case description = "description"
        case owner = "owner"
        case fullName = "full_name"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        description = try values.decodeIfPresent(String.self, forKey: .description)
        owner = try values.decodeIfPresent(Owner.self, forKey: .owner)
        fullName = try values.decodeIfPresent(String.self, forKey: .fullName)
    }
}

struct Owner: Codable {
    let avatarUrl: String?
    
    enum CodingKeys: String, CodingKey {
        case avatarUrl = "avatar_url"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        avatarUrl = try values.decodeIfPresent(String.self, forKey: .avatarUrl)
    }
}

