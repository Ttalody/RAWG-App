//
//  GameDetailsModel.swift
//  RAWG
//
//  Created by Артур on 20.03.2024.
//

import Foundation

struct GameDetailsModel: Decodable {
    let id: Int?
    let slug: String?
    let name: String?
    let nameOriginal: String?
    let description: String?
    let metacritic: Int?
    let metacriticPlatforms: [MetacriticPlatform]?
    let released: String?
    let tba: Bool?
    let updated: String?
    let backgroundImage: String?
    let backgroundImageAdditional: String?
    let website: String?
    let rating: Double?
    let ratingTop: Double?
    let ratings: [RatingsModel]?
    let playtime: Int?
    let screenshotsCount: Int?
    let moviesCount: Int?
    let creatorsCount: Int?
    let ratingsCount: Int?
    let suggestionsCount: Int?
    let alternativeNames: [String]?
    let metacriticUrl: String?
    let parentsCount: Int?
    let additionsCount: Int?
    let gameSeriesCount: Int?
    let esrbRating: ESRBRatingModel?
    let platforms: [PlatformInfoModel]?
    
    private enum CodingKeys: String, CodingKey {
        case id
        case slug
        case name
        case nameOriginal = "name_original"
        case description
        case metacritic
        case metacriticPlatforms = "metacritic_platforms"
        case released
        case tba
        case updated
        case backgroundImage = "background_image"
        case backgroundImageAdditional = "background_image_additional"
        case website
        case rating
        case ratingTop = "rating_top"
        case ratings
        case playtime
        case screenshotsCount = "screenshots_count"
        case moviesCount = "movies_count"
        case creatorsCount = "creators_count"
        case ratingsCount = "ratings_count"
        case suggestionsCount = "suggestions_count"
        case alternativeNames = "alternative_names"
        case metacriticUrl = "metacritic_url"
        case parentsCount = "parents_count"
        case additionsCount = "additions_count"
        case gameSeriesCount = "game_series_count"
        case esrbRating = "esrb_rating"
        case platforms
    }
}

struct MetacriticPlatform: Decodable {
    let metascore: Int?
    let url: String?
}
