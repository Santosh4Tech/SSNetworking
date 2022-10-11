//
//  BaseNetworkManager.swift
//  SPlayer
//
//  Created by Santosh Sahoo on 29/09/22.
//

import Foundation

open class BaseNetworkManager: NetworkManagerServices {
    
    let operationQueue: OperationQueue = .init()
    open func makeRequest(_ request: APIRequest, completionHandler: @escaping (Data?, URLResponse?, NetworkError?)-> Void) {
        let operation = FetchOperation(request: request)
        operation.completionBlock = {
            completionHandler(operation.data, operation.resp, operation.error)
        }
        operationQueue.addOperation(operation)
    }
    
    func cancellAllRequest() {
        operationQueue.cancelAllOperations()
    }
    
}
