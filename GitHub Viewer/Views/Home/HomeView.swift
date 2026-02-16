//
//  ContentView.swift
//  GitHub Viewer
//
//  Created by cristofer fernandez on 11/2/26.
//

import SwiftUI

struct HomeView: View {
    @State private var userName: String = ""
    @State private var repos: [Repo] = []
    @State private var goToDetail: Bool = false
    @State private var isLoading = false
    @State private var showError = false
    @State private var errorMessage = ""
    
    var userURL: String {
        "https://api.github.com/users/\(userName)/repos"
    }
    
    var body: some View {

        NavigationStack {
            VStack {
                TextField("Introduce tu nombre", text: $userName)
                    .multilineTextAlignment(.center)
                    .padding()

                Button("Buscar") {
                    goToDetail = false
                    isLoading = true
                    getUserRepos(userURL) { result in
                        isLoading = false
                        
                        switch result {
                        case .success(let repos):
                            self.repos = repos
                            goToDetail = true
                            
                        case .failure(let err):
                            switch err {
                            case .userNotFound:
                                errorMessage = "User not found. Please, enter another username"
                            case .network:
                                errorMessage = "A network error has occurred. Check your Internet connection and try again later."
                            case .invalidURL:
                                errorMessage = "URL no valida"
                            default:
                                errorMessage = "Algo ha sido mal, vuelvelo a intentar"
                            }
                            showError = true
                        }
                    }
                }
                .disabled(isLoading)
            }
            .padding()
            .navigationDestination(isPresented: $goToDetail){
                DetailView(repo: repos)
            }
            .alert("Error", isPresented: $showError) {
                Button ("OK", role: .cancel) {}
            } message: {
                Text(errorMessage)
            }
        }
        
        if isLoading{
            ProgressView("Cargando...")
        }
        
    }
}

#Preview {
    HomeView()
}
