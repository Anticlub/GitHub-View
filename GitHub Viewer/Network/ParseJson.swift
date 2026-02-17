
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
    
    let task = session.dataTask(with: URL) { (data, response, error) in
        
        let result: Result<[Repo], RepoFetchError>
        
        if let error {
            result = .failure(.network(error))
        } else {
            let statusCode = (response as? HTTPURLResponse)?.statusCode ?? -1
            
            if statusCode == 404 {
                result = .failure(.userNotFound)
            } else if !(200...299).contains(statusCode) {
                result = .failure(.badStatus(statusCode))
            } else if let data = data,
                      let repos = parseUserReposJSON(data) {
                result = .success(repos)
            } else {
                result = .failure(.decoding)
            }
        }
        DispatchQueue.main.async {
            completion(result)
        }
    }
    task.resume()
}

func parseUserReposJSON(_ data: Data) -> [Repo]? {
    try? JSONDecoder().decode([Repo].self, from: data)
}
