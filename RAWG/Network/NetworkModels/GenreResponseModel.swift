//
//  GenreResponse.swift
//  RAWG
//
//  Created by Артур on 07.03.2024.
//

import Foundation

struct GenreResponseModel: Decodable {
    let count: Int
    let next: String
    let previous: String
    let results: [GenreModel]
}

struct GenreModel: Decodable {
    let id: Int
    let name: String
    let slug: String
    let games_count: Int
    let image_background: String
}
