//
//  BaseRequestBuilder.swift
//  SPlayer
//
//  Created by Santosh Sahoo on 30/09/22.
//

import Foundation

public class BaseRequestBuilder: APIRequest {
    
    public var method: HTTPMethod
    
    public var url: URLComponent
    
    public var requestBody: [String : Any]?
    
    public var header: [String : Any]?
    
    public var queryParams: [String : Any]?
    
     init(method: HTTPMethod,
         url: URLComponent,
         requestBody: [String : Any]? = nil,
         header: [String : Any]? = nil,
         queryParams: [String : Any]? = nil) {
        self.method = method
        self.url = url
        self.requestBody = requestBody
        self.header = header
        self.queryParams = queryParams
    }
    
    public func build() -> URLRequest? {
        let urlStr = url.completeUrl()
        guard let url: URL = URL(string: urlStr) else {
            return nil
        }
        let urlRequest: URLRequest = .init(url: url)
        return urlRequest
    }
}
