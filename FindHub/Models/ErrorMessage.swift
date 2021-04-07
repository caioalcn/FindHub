//
//  ErrorMessage.swift
//  FindHub
//
//  Created by Caio Alcântara on 06/04/21.
//

import Foundation

struct ErrorMessage: Codable {
    let message: String = ""
    let documentationUrl: String = ""
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case documentationUrl = "documentation_url"
    }
}
