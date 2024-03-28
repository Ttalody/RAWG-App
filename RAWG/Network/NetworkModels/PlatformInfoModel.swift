//
//  PlatformInfoModel.swift
//  RAWG
//
//  Created by Артур on 23.03.2024.
//

import Foundation

struct PlatformInfoModel: Decodable {
    let platform: PlatformModel?
    let releasedAt: String?
    let requirements: RequirementsModel?
    
    private enum CodingKeys: String, CodingKey {
        case platform
        case releasedAt = "released_at"
        case requirements
    }
}
