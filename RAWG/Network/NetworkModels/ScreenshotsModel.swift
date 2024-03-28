//
//  ScreenshotsModel.swift
//  RAWG
//
//  Created by Артур on 13.03.2024.
//

import Foundation

struct ScreenshotsResponseModel: Decodable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [ScreenshotsModel]?
}

struct ScreenshotsModel: Decodable {
    let id: Int?
    let image: String?
    let width: Int?
    let height: Int?
}
