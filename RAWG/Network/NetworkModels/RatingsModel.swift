//
//  RatingsModel.swift
//  RAWG
//
//  Created by Артур on 23.03.2024.
//

import Foundation

struct RatingsModel: Decodable {
    let id: Int?
    let title: String?
    let count: Int?
    let percent: Double?
}
