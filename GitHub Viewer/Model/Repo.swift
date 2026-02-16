//
//  User.swift
//  GitHub Viewer
//
//  Created by cristofer fernandez on 11/2/26.
//

import Foundation

struct Repo: Decodable, Identifiable {
    
    let id: Int
    let name: String
    let owner: Owner
    var avatarURL: URL? {
        URL(string: owner.avatar)
    }
    
    
}

struct Owner: Decodable {
    
    let login: String
    let avatar: String
    
    enum CodingKeys: String, CodingKey {
        case login
        case avatar = "avatar_url"
    }
    
}


