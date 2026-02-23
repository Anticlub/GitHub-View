//
//  HomeViewModel.swift
//  GitHub Viewer
//
//  Created by cristofer fernandez on 17/2/26.
//

import Foundation
internal import Combine

@MainActor
class HomeViewModel: ObservableObject {
    
    @Published var userName: String = ""
    @Published var repos: [Repo] = []
    @Published var goToDetail: Bool = false
    @Published var isLoading = false
    @Published var showError = false
    @Published var errorMessage = ""
    
    private var userURL: String {
        let cleanUserName = userName.trimmingCharacters(in: .whitespacesAndNewlines)
        //return "https://api.github.com/users/\(cleanUserName)/repos"
        return "https://api.github.com/user"
    }

    func search() {
        goToDetail = false
        isLoading = true
        showError = false
        errorMessage = ""
        getUserRepos(userURL) { [weak self] result in
            guard let self else {return}
            
            self.isLoading = false
            
            switch result {
            case .success(let repos):
                self.repos = repos
                self.goToDetail = true
                
            case .failure(let err):
                switch err {
                case .userNotFound:
                    self.errorMessage = "User not found. Please, enter another username"
                case .network:
                    self.errorMessage = "A network error has occurred. Check your Internet connection and try again later."
                case .invalidURL:
                    self.errorMessage = "URL no valida"
                case .badStatus(let code):
                    self.errorMessage = "El servidor devolvió un error (código: \(code)"
                default:
                    self.errorMessage = "Algo ha sido mal, vuelvelo a intentar"
                }
                self.showError = true
            }
        }
    }
}

//#Preview {
//    HomeViewModel()
//}
