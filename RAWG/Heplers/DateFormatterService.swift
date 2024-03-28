//
//  DateFormatterService.swift
//  RAWG
//
//  Created by Артур on 28.03.2024.
//

import Foundation

final class DateFormatterService {
    
    static let shared = DateFormatterService()
    
    private init() {}
    
    func makePretty(_ str: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-mm-d"
        let date = formatter.date(from: str)
        
        formatter.dateStyle = .long
        let dateString = formatter.string(from: date ?? Date())
        return dateString
    }
}
