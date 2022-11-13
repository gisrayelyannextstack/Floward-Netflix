//
//  Endpoint.swift
//  Netflix
//
//  Created by Gerasim Israyelyan on 13.11.22.
//

import Foundation

enum HTTPMethod: String {
    case GET
    case POST
    case PUT
    case DELETE
}

protocol Endpoint {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String] { get }
    var queryItems: [URLQueryItem]? { get }
    var parameters: [String: Any]? { get }
}

extension Endpoint {
    var method: HTTPMethod { .GET }
    var headers: [String: String] { [:] }
    var queryItems: [URLQueryItem]? { nil }
    var parameters: [String: Any]? { nil }
}

enum RequestGenerationError: Error {
    case components
}

extension Endpoint {
    public func urlRequest() throws -> URLRequest {

        let url = try self.url()
        var urlRequest = URLRequest(url: url)
        var allHeaders: [String: String] = ["Content-Type": "application/json"]
        headers.forEach { allHeaders.updateValue($1, forKey: $0) }

        
        if let parameters = parameters {
            urlRequest.httpBody = encodeBody(bodyParamaters: parameters)
        }
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = allHeaders
        return urlRequest
    }
    
    private func url() throws -> URL {
        let baseURL = baseURL.absoluteString.last != "/" ? baseURL.absoluteString + "/" : baseURL.absoluteString
        let endpoint = baseURL.appending(path)

        guard var urlComponents = URLComponents(string: endpoint) else { throw RequestGenerationError.components }
        
        if let queryItems = queryItems {
            urlComponents.queryItems = !queryItems.isEmpty ? queryItems : nil
        }
        guard let url = urlComponents.url else { throw RequestGenerationError.components }
        return url
    }
    
    private func encodeBody(bodyParamaters: [String: Any]) -> Data? {
        try? JSONSerialization.data(withJSONObject: bodyParamaters)
    }
}
