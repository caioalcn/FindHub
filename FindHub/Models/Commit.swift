//
//  Commit.swift
//  FindHub
//
//  Created by Caio Alcântara on 04/04/21.
//

import Foundation

struct Commit: Codable {
    let author: Author
    let committer: Committer
    let message: String
}
