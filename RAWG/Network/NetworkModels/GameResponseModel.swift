//
//  GameResponseModel.swift
//  RAWG
//
//  Created by Артур on 27.02.2024.
//

import Foundation

struct GameResponseModel: Decodable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [GameModel]?
    
    private enum CodingKeys: String, CodingKey {
        case count
        case next
        case previous
        case results
    }
}

struct GameModel: Decodable {
    let id: Int?
    let slug: String?
    let name: String?
    let released: String?
    let tba: Bool?
    let backgroundImage: String?
    let rating: Double?
    let ratingTop: Double?
    let ratings: [RatingsModel]?
    let ratingsCount: Int?
    let added: Int?
    let metacritic: Int?
    let playtime: Int?
    let suggestionsCount: Int?
    let updated: String?
    let esrbRating: ESRBRatingModel?
    let platforms: [PlatformInfoModel]?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case slug
        case name
        case released
        case tba
        case backgroundImage = "background_image"
        case rating
        case ratingTop = "rating_top"
        case ratings
        case ratingsCount = "ratings_count"
        case added
        case metacritic
        case playtime
        case suggestionsCount = "suggestions_count"
        case updated
        case esrbRating = "esrb_rating"
        case platforms
    }
}
