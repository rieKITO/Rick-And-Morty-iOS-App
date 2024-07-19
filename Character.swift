//
//  Character.swift
//  SurfRickAndMorty
//
//  Created by Александр Потёмкин on 17.07.2024.
//

import SwiftUI

struct Character: Identifiable, Decodable, Equatable {
    static func == (firstCharacter: Character, secondCharacter: Character) -> Bool {
        return firstCharacter.id == secondCharacter.id
    }
    
    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let episodeURLs: [String]
    let location: Location
    let image: URL

    enum CodingKeys: String, CodingKey {
        case id, name, status, species, gender, image, location
        case episodeURLs = "episode"
    }
}

struct Episode: Identifiable, Decodable {
    let id: Int
    let name: String
    let airDate: String
    let episodeCode: String

    enum CodingKeys: String, CodingKey {
        case id, name
        case airDate = "air_date"
        case episodeCode = "episode"
    }
}

struct Location: Decodable {
    let name: String
    let url: String
}
