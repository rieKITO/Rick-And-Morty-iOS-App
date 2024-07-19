//
//  CharacterListView.swift
//  SurfRickAndMorty
//
//  Created by Александр Потёмкин on 17.07.2024.
//

import SwiftUI

struct CharacterListView: View {
    @ObservedObject var viewModel = CharacterListViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 10) {
                    Text("Rick & Morty Characters")
                        .foregroundColor(Colors.textColor)
                        .font(.title)
                        .padding(.bottom, 30)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    ForEach(viewModel.characters, id: \.id) { character in
                        NavigationLink(destination: CharacterDetailsView(character: character, viewModel: viewModel)) {
                            CharacterCellView(character: character)
                                .foregroundColor(Colors.textColor)
                                .padding(.vertical, 5)
                        }
                    }
                }
            }
            .background(Colors.backgroundColor)
            .onAppear {
                viewModel.fetchCharacters()
            }
            .onChange(of: viewModel.characters.count) { _ in
                if viewModel.hasMorePages && !viewModel.isLoading {
                    loadMoreData()
                }
            }
            .navigationBarTitle("Rick & Morty Characters", displayMode: .inline)
        }
    }
    
    private func loadMoreData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            viewModel.fetchCharacters()
        }
    }
}
