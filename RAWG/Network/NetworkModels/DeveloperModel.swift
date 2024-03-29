//
//  DeveloperModel.swift
//  RAWG
//
//  Created by Артур on 29.03.2024.
//

import Foundation

struct DeveloperModel: Decodable {
    let id: Int
    let name: String
    let slug: String
    let gamesCount: Int
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case slug
        case gamesCount = "games_count"
    }
}
