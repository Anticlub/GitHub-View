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
                TextField("Introduce tu nombre", text: $vm.userName)
                    .multilineTextAlignment(.center)
                    .padding()

                Button("Buscar") {
                    vm.search()
                }
                .disabled(vm.isLoading)
            }
            .padding()
            .navigationDestination(isPresented: $vm.goToDetail){
                DetailView(repo: vm.repos)
            }
            .alert("Error", isPresented: $vm.showError) {
                Button ("OK", role: .cancel) {}
            } message: {
                Text(vm.errorMessage)
            }
        }
        
        if vm.isLoading{
            ProgressView("Cargando...")
        }
        
    }
}

#Preview {
    HomeView()
}
