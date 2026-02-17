//
//  DetailView.swift
//  GitHub Viewer
//
//  Created by cristofer fernandez on 11/2/26.
//

import SwiftUI

struct DetailView: View {
    let repo: [Repo]
    let widthImage: CGFloat = 150
    let heightImage: CGFloat = 150
    let sizeCornerRadius: CGFloat = 150
    
    var body: some View {
        VStack{
            AsyncImage(url: repo.first?.avatarURL) { image in
                image
                    .resizable()
                    .frame(width: widthImage, height: heightImage, alignment: .center)
                    .cornerRadius(sizeCornerRadius)
                
            } placeholder: {
                VStack{
                    ProgressView()
                    Text("Loading avatar...")
                }
            }
            
            Text(repo.first?.owner.login.localizedCapitalized ?? "Sin usuario")
                
            
            Divider()
            
            VStack{
                List(repo) { repos in
                    Text("\(repos.name.localizedCapitalized)\n\(repos.language?.localizedCapitalized ?? "Sin lenguaje")")
                }
            }
        }
    }
}

//#Preview {
//    DetailView()
//}
