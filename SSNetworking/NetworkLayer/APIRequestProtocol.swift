//
//  APIRequestProtocol.swift
//  SPlayer
//
//  Created by Santosh Sahoo on 03/10/22.
//

import Foundation

public enum HTTPMethod {
    case get, post, put
}

public struct URLComponent {
    
    let baseUrl: String
    let path: String
    
    public init(baseUrl: String, path: String) {
        self.baseUrl = baseUrl
        self.path = path
    }
    
    func completeUrl() -> String {
        return baseUrl + path
    }
}

public protocol APIRequest {
    var method: HTTPMethod { set get }
    var url: URLComponent { set get }
    var requestBody: [String: Any]? { set get }
    var header: [String: Any]? { set get }
    var queryParams: [String: Any]? { set get }
    func build() -> URLRequest?
}
