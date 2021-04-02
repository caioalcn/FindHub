//
//  APIGitHub.swift
//  FindHub
//
//  Created by Caio Alcântara on 01/04/21.
//

import Foundation

class APIGitHub {
    
    class func fetchUser(text: String, completion: @escaping (String?, Error?) -> ()) {
        ServiceLayer.request(router: .search(name: text)) { (response: Result<String, Error>) in
            switch response {
            case .success(let result):
                completion(result, nil)
            case .failure(let err):
                completion(nil, err)
            }
        }
    }
}
