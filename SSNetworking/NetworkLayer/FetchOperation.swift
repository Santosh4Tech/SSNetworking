//
//  FetchOperation.swift
//  SPlayer
//
//  Created by Santosh Sahoo on 07/10/22.
//

import Foundation

class FetchOperation: Operation {
    
    let request: APIRequest
    let session: URLSessionProtocol
    
    override var isExecuting: Bool { return state == .executing }
    override var isFinished: Bool { return state == .finished }

    var state = State.ready {
        willSet {
            willChangeValue(forKey: state.keyPath)
            willChangeValue(forKey: newValue.keyPath)
        }
        didSet {
            didChangeValue(forKey: state.keyPath)
            didChangeValue(forKey: oldValue.keyPath)
        }
    }

    enum State: String {
        case ready = "Ready"
        case executing = "Executing"
        case finished = "Finished"
        fileprivate var keyPath: String { return "is" + self.rawValue }
    }

    override func start() {
        if self.isCancelled {
            state = .finished
        } else {
            state = .ready
            main()
        }
    }
    
    //Response props
    private(set) var data: Data?
    private(set) var resp: URLResponse?
    private(set) var error: NetworkError?
    
    init(request: APIRequest, session: URLSessionProtocol = URLSession.shared) {
        self.request = request
        self.session = session
    }
    
    override func main() {
        if isCancelled {
            state = .finished
            return
        }
        state = .executing
        guard let urlReq = request.build() else {
            return
        }
        let task = session.dataTask(with: urlReq) { data, resp, error in
            self.data = data
            self.resp = resp
            if let error = error {
                self.error = .apiError(error)
            }
            
            self.state = .finished
        }
        task.resume()
    }
    
}
