//
//  Data+Extension.swift
//  FindHub
//
//  Created by Caio Alcântara on 06/04/21.
//

import Foundation

extension Data {
    func decodeJSON<T: Codable>(model: T.Type) -> (response: T?, err: Error?) {
        do {
            let response = try JSONDecoder().decode(model, from: self)
            
            return (response, nil)
        } catch(let err) {
            print("Failed to decode:", err.localizedDescription)

            return (nil, err)
        }
    }
}
