//
//  Language.swift
//  FindHub
//
//  Created by Caio Alcântara on 04/04/21.
//

import Foundation

struct Language: Codable {
    struct LanguageKey: CodingKey {
        var stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        
        var intValue: Int? { return nil }
        init?(intValue: Int) { return nil }
    }
    
    var name: [String] = []
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: LanguageKey.self)
        
        for key in container.allKeys {
            name.append(key.stringValue)
        }
    }
}
