//
//  Service.swift
//  FindHub
//
//  Created by Caio Alcântara on 01/04/21.
//

import Foundation

class ServiceLayer {
    class func request<T: Codable>(router: Router, completion: @escaping (Result<T, ServiceErrors>) -> ()) {
        if Reachability.isConnectedToNetwork() {
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
                    DispatchQueue.main.async {
                        completion(.failure(.serverResponseErrorWith(message: err.localizedDescription)))
                    }
                    return
                }
                
                print(urlRequest.url ?? "")
                //  print(String(data: data, encoding: .utf8) ?? "Error parsing data")
                
                guard response != nil, let data = data else { return }
                
                guard let httpResponse = response as? HTTPURLResponse else { return }

                if httpResponse.statusCode == 404 {
                    let errorDecoded = data.decodeJSON(model: ErrorMessage.self)

                    if let err = errorDecoded.err {
                        DispatchQueue.main.async {
                            completion(.failure(.serverResponseErrorWith(message: err.localizedDescription)))
                        }
                    }
                    
                    guard let errorMessage = errorDecoded.response else { return }
                    DispatchQueue.main.async {
                        completion(.failure(.NotFound(error: errorMessage)))
                    }
                    
                } else if httpResponse.statusCode == 403 {
                    let errorDecoded = data.decodeJSON(model: ErrorMessage.self)

                    if let err = errorDecoded.err {
                        DispatchQueue.main.async {
                            completion(.failure(.serverResponseErrorWith(message: err.localizedDescription)))
                        }
                    }
                    
                    guard let errorMessage = errorDecoded.response else { return }
                    DispatchQueue.main.async {
                        completion(.failure(.NotFound(error: errorMessage)))
                    }
                } else {
                    let decoded = data.decodeJSON(model: T.self)

                    if let err = decoded.err {
                        DispatchQueue.main.async {
                            completion(.failure(.serverResponseErrorWith(message: err.localizedDescription)))
                        }
                    }
                    
                    guard let resposeObject = decoded.response else { return }
                    DispatchQueue.main.async {
                        completion(.success(resposeObject))
                    }
                }
            }
            dataTask.resume()
        } else {
            DispatchQueue.main.async {
                completion(.failure(.noInternet))
            }
        }
    }
}
