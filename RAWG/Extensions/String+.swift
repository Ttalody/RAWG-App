//
//  String+.swift
//  RAWG
//
//  Created by Артур on 29.03.2024.
//

import Foundation
import NaturalLanguage

extension String {
    func removeHTMLTags() -> String {
        return self.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
    }
    
    func removeNonEnglishText() -> String {
        let tagger = NLTagger(tagSchemes: [.language])
        tagger.string = self
        
        let language = tagger.dominantLanguage
        
        if language == NLLanguage.english {
            return self
        } else {
            return ""
        }
    }
}
