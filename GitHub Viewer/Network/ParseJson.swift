
import Foundation

enum RepoFetchError: Error {
    case invalidURL
    case userNotFound
    case network(Error)
    case badStatus(Int)
    case decoding
}

func getUserRepos(_ userURL: String,
                  session: URLSession = .shared,
                  completion: @escaping (Result<[Repo], RepoFetchError>) -> Void) {
    
    guard let URL = URL(string: userURL) else {
        completion(.failure(.invalidURL))
        return
    }
    
    let request = URLRequest(url: URL)
    
    let task = session.dataTask(with: URL) { (data, response, error) in
        if let error {
            DispatchQueue.main.async{
                completion(.failure(.network(error)))
            }
            return
        }
        
        
        let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
        
        if statusCode == 404 {
            DispatchQueue.main.async{
                completion(.failure(.userNotFound))
            }
            return
        }
        
        guard (200...299).contains(statusCode) else {
            DispatchQueue.main.async{
                completion(.failure(.badStatus(statusCode)))
            }
            return
        }
        
        guard let data = data else{
            DispatchQueue.main.async{
                completion(.failure(.decoding))
            }
            return
        }
        
        parseUserReposJSON(data) { repos in
            DispatchQueue.main.async{
                if let repos {
                    completion(.success(repos))
                } else {
                    completion(.failure(.decoding))
                }
            }
        }
    }
        task.resume()
    }
    
    func parseUserReposJSON(_ data: Data, completion: ([Repo]?) -> Void){
        
        let repos = try? JSONDecoder().decode([Repo].self, from: data)
        completion(repos)
        
    }

