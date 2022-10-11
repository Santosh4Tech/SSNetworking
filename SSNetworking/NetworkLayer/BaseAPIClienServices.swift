//
//  BaseAPIClienServices.swift
//  SPlayer
//
//  Created by Santosh Sahoo on 29/09/22.
//

import Foundation

public struct BaseAPIClienServices: APIServices {
    
    public init() {
        
    }
    
    public func fetchDataFor<T: Codable>(_ request: APIRequest, completionHandler: @escaping ((Result<T, NetworkError>?) -> Void)) {
        let manager: NetworkManagerServices = BaseNetworkManager()
        let handler: (Result<T, NetworkError>?) -> Void = { result in
            DispatchQueue.main.async {
                completionHandler(result)
            }
        }
        manager.makeRequest(request) { (data, resp, error) in
            if let data = data {
                do {
                    let model = try JSONDecoder().decode(T.self, from: data)
                    handler(.success(model))
                } catch let error {
                    handler(.failure(.parsingError(error)))
                }
            } else {
                handler(.failure(.noData))
            }
        }
    }
        
}
