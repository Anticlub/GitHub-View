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
        return "https://api.github.com/users/\(cleanUserName)/repos"
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
                    self.errorMessage = L10n.errorUserNotFound
                case .network:
                    self.errorMessage = L10n.errorNetwork
                case .invalidURL:
                    self.errorMessage = L10n.errorInvalidURL
                case .badStatus(let code):
                    self.errorMessage = String(format: L10n.errorBadStatus, code)
                default:
                    self.errorMessage = L10n.errorDefault
                }
                self.showError = true
            }
        }
    }
}

//#Preview {
//    HomeViewModel()
//}
