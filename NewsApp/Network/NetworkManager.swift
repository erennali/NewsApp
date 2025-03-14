//
//  NetworkManager.swift
//  NewsApp
//
//  Created by Eren Ali Koca on 13.03.2025.
//

import Foundation

enum HTTPMethod: String {
    case GET
    case POST
}

protocol NetworkManagerProtocol {
    func request<T: Codable> (
        url: URL,
        method:HTTPMethod,
        completion: @escaping (Result<T, NetworkError>) -> Void
    )
}

final class NetworkManager {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
}

extension NetworkManager: NetworkManagerProtocol {
    func request<T>(url:URL, method : HTTPMethod, completion: @escaping (Result<T, NetworkError>) -> Void) where
    T : Decodable, T: Encodable {
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        let task = session.dataTask(with: request) { data , response , error in
            if let error = error {
                completion(.failure(.customError(error)))
                return
            }
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.invalidResponse))
                return
            }
            
            guard (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.requestFailedWith(httpResponse.statusCode)))
                return
            }
            
            guard let data = data else {
                completion(.failure(.invalidData))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(.decodingError))
            }
        }
        task.resume()
    }
}
