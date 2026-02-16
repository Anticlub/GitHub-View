//
//  DetailView.swift
//  GitHub Viewer
//
//  Created by cristofer fernandez on 11/2/26.
//

import SwiftUI

struct DetailView: View {
    let repo : [Repo]
    
    var body: some View {
        VStack{
            AsyncImage(url: repo.first?.avatarURL) { image in
                image
                    .resizable()
                    .frame(width: 150, height: 150, alignment: .center)
                    .cornerRadius(150)
                
            } placeholder: {
                VStack{
                    ProgressView()
                    Text("Loading avatar...")
                }
            }
            Text(repo.first?.owner.login ?? "Sin usuario")
            
            Divider()
            
            VStack{
//                List (repo) { repo in
//                
//                    Text("\(repo.name)\n\(repo.language ?? "Sin lenguaje")")
//                }
            }
        }
    }
}

//#Preview {
//    DetailView()
//}
