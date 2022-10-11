//
//  NLProtocols.swift
//  SPlayer
//
//  Created by Santosh Sahoo on 20/09/22.
//

import Foundation

typealias APISuccessHandler =  (Data, URLResponse?) -> Void
typealias APIFailureHandler = (URLResponse?, NetworkError?) -> Void

public protocol APIServices {
    func fetchDataFor<T: Codable>(_ request: APIRequest, completionHandler: @escaping ((Result<T, NetworkError>?)->Void) )
    
}

public protocol NetworkManagerServices {
    
    func makeRequest(_ request: APIRequest, completionHandler: @escaping (Data?, URLResponse?, NetworkError?) -> Void)
}

public protocol URLSessionProtocol {
    func dataTask(with request: URLRequest, handler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol
}

public protocol URLSessionDataTaskProtocol {
    func resume()
}

extension URLSessionDataTask: URLSessionDataTaskProtocol { }

extension URLSession: URLSessionProtocol {
    public func dataTask(with request: URLRequest, handler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        return self.dataTask(with: request, completionHandler: handler) as URLSessionDataTaskProtocol
    }
    
    
}
