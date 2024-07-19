//
//  CharacterListViewModel.swift
//  SurfRickAndMorty
//
//  Created by Александр Потёмкин on 17.07.2024.
//

import SwiftUI

class CharacterListViewModel: ObservableObject {
    @Published var characters: [Character] = []
    @Published var episodes: [String: Episode] = [:]
    @Published var isLoading = false
    @Published var hasMorePages = true
    private var currentPage = 1
    private let delay: TimeInterval = 1.5 // Задержка в секундах
    
    init() {
        fetchCharacters()
    }
    
    func fetchCharacters() {
        guard !isLoading, hasMorePages else { return }
        
        isLoading = true
        
        guard let url = URL(string: "https://rickandmortyapi.com/api/character?page=\(currentPage)") else {
            isLoading = false
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data else {
                DispatchQueue.main.async {
                    self?.isLoading = false
                }
                return
            }
            
            do {
                let result = try JSONDecoder().decode(CharactersResponse.self, from: data)
                DispatchQueue.main.async {
                    self?.characters.append(contentsOf: result.results)
                    self?.hasMorePages = result.info.next != nil
                    self?.currentPage += 1
                    self?.fetchEpisodes(for: result.results)
                    self?.isLoading = false
                }
            } catch {
                print("Error decoding JSON: \(error)")
                DispatchQueue.main.async {
                    self?.isLoading = false
                }
            }
        }.resume()
    }
    
    func fetchEpisodes(for characters: [Character]) {
        let episodeURLs = Set(characters.flatMap { $0.episodeURLs })
        
        for url in episodeURLs {
            guard let episodeURL = URL(string: url) else { continue }
            
            URLSession.shared.dataTask(with: episodeURL) { data, response, error in
                guard let data = data else { return }
                
                do {
                    let episode = try JSONDecoder().decode(Episode.self, from: data)
                    DispatchQueue.main.async {
                        self.episodes[url] = episode
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }.resume()
        }
    }
}

struct CharactersResponse: Decodable {
    let info: Info
    let results: [Character]
}

struct Info: Decodable {
    let next: String?
}
