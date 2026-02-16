//
//  User.swift
//  GitHub Viewer
//
//  Created by cristofer fernandez on 11/2/26.
//

import Foundation

struct Repo: Decodable {
    
    let name: String
    let owner: Owner
    //let imageURL: URL
    //let repos: [UserRepos]
}

struct Owner: Decodable {
    
    let login: String
    
}
