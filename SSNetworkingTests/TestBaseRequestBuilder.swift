//
//  TestBaseRequestBuilder.swift
//  SSNetworkingTests
//
//  Created by Santosh Sahoo on 08/10/22.
//

import XCTest
@testable import SSNetworking

final class TestBaseRequestBuilder: XCTestCase {

    var baseReqBuilder: BaseRequestBuilder!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        baseReqBuilder = .init(method: .get, url: .init(baseUrl: "https://test.com", path: "/test"))
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        baseReqBuilder = nil
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testBuild() throws {
        //given
        //url = "https://test.com/test"
        
        //when
        let req = baseReqBuilder.build()
        
        //then
        XCTAssertNotNil(req, "Request is Nil")
        XCTAssertEqual(req?.url?.absoluteString, "https://test.com/test")
        
        
        baseReqBuilder = .init(method: .get, url: .init(baseUrl: "", path: ""))
        
        let req1 = baseReqBuilder.build()
        
        //then
        XCTAssertNil(req1, "Request is Nil")
    }


}
