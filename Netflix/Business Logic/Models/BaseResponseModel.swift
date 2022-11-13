//
//  BaseResponseModel.swift
//  Netflix
//
//  Created by Gerasim Israyelyan on 13.11.22.
//

import Foundation

struct BaseResponseModel<T: Decodable>: Decodable {
    let results: [T]
}
