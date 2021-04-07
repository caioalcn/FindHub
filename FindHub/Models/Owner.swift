//
//  Owner.swift
//  FindHub
//
//  Created by Caio Alcântara on 04/04/21.
//

import Foundation

struct Owner: Codable, Hashable {
    let login: String
    let avatarUrl: String
    
    enum CodingKeys: String, CodingKey {
        case login = "login"
        case avatarUrl = "avatar_url"
    }
}
