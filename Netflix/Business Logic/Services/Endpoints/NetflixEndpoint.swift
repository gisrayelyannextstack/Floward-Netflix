//
//  NetflixEndpoint.swift
//  Netflix
//
//  Created by Gerasim Israyelyan on 13.11.22.
//

import Foundation

enum NetflixEndpoint {
    case genres
    case movies(genreId: Int, limit: Int)
}

extension NetflixEndpoint: Endpoint {
    var baseURL: URL {
        guard let url = URL(string: "https://unogs-unogs-v1.p.rapidapi.com") else {
            fatalError()
        }
        return url
    }
    
    var path: String {
        switch self {
        case .genres: return "static/genres"
        case .movies: return "search/titles"
        }
    }
    
    var headers: [String : String] {
        ["X-RapidAPI-Key": AppConstants.NETFLIX_API_KEY,
         "X-RapidAPI-Host": "unogs-unogs-v1.p.rapidapi.com"]
    }
    
    var queryItems: [URLQueryItem]? {
        switch self {
        case .genres:
            return nil
        case .movies(let genreId, let limit):
            return [URLQueryItem(name: "genre_list", value: "\(genreId)"),
                    URLQueryItem(name: "limit", value: "\(limit)")]
        }
    }
}
