//
//  ContentView.swift
//  GitHub Viewer
//
//  Created by cristofer fernandez on 11/2/26.
//

import SwiftUI

struct HomeView: View {
    @State private var userName: String = ""
    @State private var repos: [Repo]? = []
    @State private var goToDetail: Bool = false
    @State private var isLoading = false
    
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
                    isLoading = true
                    getUserRepos(userURL, completion: { repos in
                        isLoading = false
                        self.repos = repos
                        print("el id es \(repos?.first?.name ?? "none")")
                        
                        if self.repos != nil {
                            goToDetail = true
                        }
                    })
                }
            }
            .padding()
            .navigationDestination(isPresented: $goToDetail){
                if let repos = repos {
                    DetailView(repo: repos)
                } else {
                    Text("No se pudo cargar el usuario")
                }
                
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
