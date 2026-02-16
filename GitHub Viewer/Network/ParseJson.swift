//
//  git.swift
//  GitHub Viewer
//
//  Created by cristofer fernandez on 11/2/26.
//

import Foundation

func getUserRepos(_ userURL: String,
                  session: URLSession = .shared,
                  completion: @escaping ([Repo]?) -> Void){
    
    guard let URL = URL(string: userURL) else {return}
    
    let request = URLRequest(url: URL)
    
    let task = session.dataTask(with: URL) { (data, response, error) in
        if error == nil,
           let statusCode = (response as? HTTPURLResponse)?.statusCode,
           let data = data {
            parseUserReposJSON(data) { repo in
                DispatchQueue.main.async{
                    completion(repo)
                }
                
            }
            
        } else {
            completion(nil)
        }
        
    }
    task.resume()
}

func parseUserReposJSON(_ data: Data, completion: ([Repo]?) -> Void){
    
    let repos = try? JSONDecoder().decode([Repo].self, from: data)
    
    completion(repos)
    
}
