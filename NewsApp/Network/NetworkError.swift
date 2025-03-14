//
//  NetworkError.swift
//  NewsApp
//
//  Created by Eren Ali Koca on 13.03.2025.
//

import Foundation

enum NetworkError: Error {
    case invalidRequest
    case decodingError
    case requestFailedWith(Int)
    case invalidResponse
    case invalidData
    case customError(Error)
    
    var localizedDescription: String {
        switch self {
        case .invalidRequest:
            "Invalid Request"
        case .decodingError:
            "Decoding Error"
        case .requestFailedWith(let code):
            "Request failed with status code: \(code)"
        case .invalidResponse:
            "Invalid Response"
        case .invalidData:
            "Invalid Data"
        case .customError(let error):
            "An error occured: \(error.localizedDescription)"
        }
    }
}
