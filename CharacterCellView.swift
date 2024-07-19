//
//  CharacterCellView.swift
//  SurfRickAndMorty
//
//  Created by Александр Потёмкин on 17.07.2024.
//

import SwiftUI

struct CharacterCellView: View {
    let character: Character
    
    var body: some View {
        HStack {
            AsyncImage(url: character.image) { phase in
                switch phase {
                case .empty:
                    ProgressView()
                        .frame(width: 100, height: 80)
                        .background(Color.gray.opacity(0.2))
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                case .success(let image):
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 80)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                case .failure:
                    Image(systemName: "photo")
                        .resizable()
                        .frame(width: 100, height: 80)
                        .background(Color.gray.opacity(0.2))
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                @unknown default:
                    EmptyView()
                }
            }
            
            VStack(alignment: .leading) {
                Text(character.name)
                    .font(.headline)
                    .lineLimit(1)
                HStack {
                    let statusColor = Colors.getStatusColor(character: character)
                    Text("\(character.status)")
                        .foregroundStyle(statusColor)
                    Text("•")
                        .fontWeight(.heavy)
                    Text("\(character.species)")
                }
                Text(character.gender)
                    .font(.subheadline)
                Spacer()
            }
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 10)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Colors.characterCellBackgroundColor)
        .cornerRadius(15)
    }
    
}
