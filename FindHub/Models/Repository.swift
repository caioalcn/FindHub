//
//  User.swift
//  FindHub
//
//  Created by Caio Alcântara on 02/04/21.
//

import Foundation

struct Repository: Codable {
    let owner: Owner
    let name: String
    let stargazersCount: Int
    let language: String?

    enum CodingKeys: String, CodingKey {
        case owner = "owner"
        case name = "name"
        case stargazersCount = "stargazers_count"
        case language = "language"
    }
}
