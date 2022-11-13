//
//  Movie.swift
//  Netflix
//
//  Created by Gerasim Israyelyan on 13.11.22.
//

import Foundation

struct Movie: Decodable {
    let title: String
    let imageURLString: String
    let id: Int
    let synopsis: String
    let rating: String
    let year: String
    let runtime: String
    let posterUrlString: String
    let date: String // "2022-11-13"
    
    enum CodingKeys: String, CodingKey {
        case title
        case imageURLString = "img"
        case id = "netflix_id"
        case synopsis
        case rating
        case year
        case runtime
        case posterUrlString = "poster"
        case date = "title_date"
    }
    
    var posterUrl: URL? { URL(string: posterUrlString) }
}
