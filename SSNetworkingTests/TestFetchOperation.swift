//
//  TestFetchOperation.swift
//  SSNetworkingTests
//
//  Created by Santosh Sahoo on 09/10/22.
//

import XCTest
@testable import SSNetworking

final class TestFetchOperation: XCTestCase {
    
    var fetchOperation: FetchOperation!
    var session: MockURLSession!
    var operationQueue: OperationQueue!
    
    override func setUpWithError() throws {
        let req: BaseRequestBuilder = .init(method: .get, url: .init(baseUrl: "https://test.com", path: "/test"))
        session = MockURLSession()
        fetchOperation = .init(request: req, session: session)
        operationQueue = .init()
        
    }

    override func tearDownWithError() throws {
//        fetchOperation = nil
//        session = nil
//        operationQueue = nil
    }
    
    func testFetchOperation() throws {
        fetchOperation.completionBlock = {
            XCTAssertNil(self.fetchOperation.data)
        }
        operationQueue.addOperation(fetchOperation)
    }


    func testFetchOperationWithData() {
        session.data = try? JSONSerialization.data(withJSONObject: ["key": "value"])
        fetchOperation.completionBlock = {
            XCTAssertNotNil(self.fetchOperation.data)
        }
        operationQueue.addOperation(fetchOperation)
    }
    
    func testFetchOperationWithError() {
        session.error = .apiError(NetworkError.noInternet)
        fetchOperation.completionBlock = {
            XCTAssertNotNil(self.fetchOperation.error)
//            XCTAssertEqual(fetchOperation.error, NetworkError.noData)
        }
        operationQueue.addOperation(fetchOperation)
    }
    
    func testInvalidRequestURL() {
        let req: BaseRequestBuilder = .init(method: .get, url: .init(baseUrl: "", path: ""))
        let fetchOperation1: FetchOperation = .init(request: req, session: session)

        fetchOperation1.completionBlock = {
            XCTAssertNotNil(fetchOperation1.error)
//            XCTAssertEqual(fetchOperation.error, NetworkError.noData)
        }
        operationQueue.addOperation(fetchOperation1)
    }
}

class MockURLSession: URLSessionProtocol {
    
    var nextDataTask = MockURLSessionDataTask()
    private (set) var lastURL: URL?
    var data: Data?
    var error: NetworkError?
    
    func dataTask(with request: URLRequest, handler: @escaping @Sendable (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTaskProtocol {
        lastURL = request.url
        handler(data, successHttpURLResponse(req: request), error)
            return nextDataTask
    }
    
    func successHttpURLResponse(req: URLRequest) -> HTTPURLResponse? {
        guard let url = req.url else {
            return nil
        }
        return HTTPURLResponse(url: url, statusCode: 200, httpVersion:  "HTTP/1.1", headerFields: nil)
    }
    
    
}

class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    func resume() {  }
}
