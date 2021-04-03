//
//  User.swift
//  FindHub
//
//  Created by Caio Alcântara on 02/04/21.
//

import Foundation

struct Repository: Codable {
    let id: Int
    let nodeId: String
    let name: String
    let fullName: String
    let htmlUrl: String
    let description: String?
    let createdAt: String
    let updatedAt: String
    let pushedAt: String
    let stargazersCount: Int
    let watchersCount: Int
    let language: String?
    let forks: Int
    let openIssues: Int
    let watchers: Int
    let defaultBranch: String

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case nodeId = "node_id"
        case name = "name"
        case fullName = "full_name"
        case htmlUrl = "html_url"
        case description = "description"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case pushedAt = "pushed_at"
        case stargazersCount = "stargazers_count"
        case watchersCount = "watchers_count"
        case language = "language"
        case forks = "forks"
        case openIssues = "open_issues"
        case watchers = "watchers"
        case defaultBranch = "default_branch"
    }
}
