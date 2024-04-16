//
//  APIConstants.swift
//  RAWG
//
//  Created by Артур on 27.02.2024.
//

import Foundation

enum APIContants: String {
    case baseUrl = "https://api.rawg.io/api/"
    case apiKey = "6c329f0a4d654cc79253bdcaff16dc47"
    case games = "games"
    case key = "key"
    case page = "page"
    case pageSize = "page_size"
    case genres = "genres"
    case search = "search"
    case gameId = "id"
    case screenshots = "screenshots"
    case ordering = "ordering"
    case onMetacritic = "-metacritic"
    case trending = "https://api.rawg.io/api/games?dates=2023-01-01,2024-12-31&ordering=-added"
    case screenshotsTestUrl = "https://api.rawg.io/api/games/3498/screenshots?key=6c329f0a4d654cc79253bdcaff16dc47"
    case detailsTestUrl = "https://api.rawg.io/api/games/3498?key=6c329f0a4d654cc79253bdcaff16dc47"
}
