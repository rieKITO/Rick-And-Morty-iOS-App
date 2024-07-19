//
//  CharacterDetailsView.swift
//  SurfRickAndMorty
//
//  Created by Александр Потёмкин on 17.07.2024.
//

import SwiftUI

struct CharacterDetailsView: View {
    let character: Character
    @ObservedObject var viewModel: CharacterListViewModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/) {
                
                Text(character.name)
                    .font(.title)
                    .fontWeight(.heavy)
                
                AsyncImage(url: character.image) { phase in
                    phase.image?
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                }
                .frame(width: 330, height: 330)
                
                Text(character.status)
                    .padding(.vertical, 10)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .background(Colors.getStatusColor(character: character))
                    .cornerRadius(15)
                    .padding(.horizontal, 30)
                    .font(.system(size: 20))
                    .fontWeight(.semibold)
                
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text("Status: ")
                            .font(.headline)
                            .fontWeight(.bold)
                        Text(character.status)
                    }
                    
                    HStack {
                        Text("Species: ")
                            .font(.headline)
                            .fontWeight(.bold)
                        Text(character.species)
                    }
                    
                    HStack {
                        Text("Gender: ")
                            .font(.headline)
                            .fontWeight(.bold)
                        Text(character.gender)
                    }
                    
                    Text("Episodes (\(character.episodeURLs.count)): ")
                        .font(.headline)
                    
                    ForEach(character.episodeURLs, id: \.self) { url in
                        let episode = viewModel.episodes[url]
                        Text(episode!.name)
                            .font(.subheadline)
                        
                    }
                    
                    HStack {
                        Text("Last known location: ")
                            .font(.headline)
                            .fontWeight(.bold)
                        Text(character.location.name)
                    }
                }
                .padding(.top, 20)
                
                Spacer()
            }
        }
        .background(Colors.backgroundColor)
        .navigationBarTitle(Text(character.name), displayMode: .inline)
        .foregroundStyle(Colors.textColor)
    }
}
