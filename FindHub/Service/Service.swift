//
//  Service.swift
//  FindHub
//
//  Created by Caio Alcântara on 01/04/21.
//

import Foundation

class ServiceLayer {
    class func request<T: Codable>(router: Router, completion: @escaping (Result<T, Error>) -> ()) {
        
        var components = URLComponents()
        components.scheme = router.scheme
        components.host = router.base
        components.path = router.path
        components.queryItems = router.parameters
        
        guard let url = components.url else { return }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = router.method.rawValue

        let session = URLSession(configuration: .default)
        
        let dataTask = session.dataTask(with: urlRequest) { (data, response, error) in
            if let err = error {
                completion(.failure(err))
                return
            }
            
            guard response != nil, let data = data else { return }
            
            print(urlRequest.url ?? "")
          //  print(String(data: data, encoding: .utf8) ?? "Error parsing data")
            
            do {
                let responseObject = try JSONDecoder().decode(T.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(responseObject))
                }
            } catch(let err) {
                DispatchQueue.main.async {
                    completion(.failure(err))
                }
                print("Failed to decode:", err.localizedDescription)
            }
        }
        dataTask.resume()
    }
}
