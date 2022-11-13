//
//  Genre.swift
//  Netflix
//
//  Created by Gerasim Israyelyan on 13.11.22.
//

import Foundation

struct Genre: Decodable {
    let id: Int
    let title: String
    var movies: [Movie] = []
    
    enum CodingKeys: String, CodingKey {
        case id = "netflix_id"
        case title = "genre"
    }
}
