//
//  NewsService.swift
//  NewsApp
//
//  Created by Eren Ali Koca on 13.03.2025.
//

import Foundation

protocol NewsServiceProtocol {
    func fetchTopNews(
        country: String,
        page: Int,
        pageSize: Int,
        completion: @escaping (Result<NewsModel, NetworkError>) -> Void
    )
}

final class NewsService {
    
    private let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol = NetworkManager()) {
        self.networkManager = networkManager
    }
}

extension NewsService: NewsServiceProtocol {
    func fetchTopNews(
        country: String,
        page: Int,
        pageSize: Int,
        completion: @escaping (Result<NewsModel, NetworkError>) -> Void
    ) {
        var urlComponents = URLComponents(string: NetworkConstants.baseUrl + "top-headlines")
        urlComponents?.queryItems = [
            URLQueryItem(name: "country", value: country),
            URLQueryItem(name: "page", value: String(page)),
            URLQueryItem(name: "pageSize", value: String(pageSize)),
            URLQueryItem(name: "apiKey", value: NetworkConstants.apiKey)
        ]
        
        guard let url = urlComponents?.url else {
            completion(.failure(.invalidRequest))
            return
        }
        
        networkManager.request(
            url: url,
            method: .GET,
            completion: completion
        )
        
    }
}
