//
//  ContentView.swift
//  GitHub Viewer
//
//  Created by cristofer fernandez on 11/2/26.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var vm = HomeViewModel()
    
    var body: some View {

        NavigationStack {
            VStack {
                TextField(L10n.textFieldUsername, text: $vm.userName)
                    .multilineTextAlignment(.center)
                    .padding()

                Button(L10n.searchButton) {
                    vm.search()
                }
                .disabled(vm.isLoading)
            }
            .padding()
            .navigationDestination(isPresented: $vm.goToDetail){
                DetailView(repo: vm.repos)
            }
            .alert(L10n.errorTitle, isPresented: $vm.showError) {
                Button (L10n.errorButton, role: .cancel) {}
            } message: {
                Text(vm.errorMessage)
            }
        }
        
        if vm.isLoading{
            ProgressView(L10n.searchingUser)
        }
        
    }
}

#Preview {
    HomeView()
}
