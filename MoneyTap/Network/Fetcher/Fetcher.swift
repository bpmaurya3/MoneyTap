//
//  Fetcher.swift
//  MoneyTap
//
//  Created by Bhuvanendra Pratap Maurya on 6/23/18.
//  Copyright © 2018 Bhuvanendra Pratap Maurya. All rights reserved.
//

import Foundation

class Fetcher: Equatable {
    
    var name: String { return String(describing: self) }
    
    var errorHandler: ((String) -> Void) = { _ in }
    var tokenExpiredHandler: (() -> Void) = { }
    fileprivate var session: URLSession?
    func networkFetch(request: URLRequest) {
        let sessionConfig = URLSessionConfiguration.default
        session = URLSession(configuration: sessionConfig)
        let task = session!.dataTask(with: request, completionHandler: { [weak self] (data, response, error) in
            guard let strongSelf = self else {
                return
            }
            
            if let error = error {
                print("Request Error: \(error)")
                DispatchQueue.main.async { [weak strongSelf] in
                    if let strongSelf2 = strongSelf {
                        strongSelf2.errorHandler(String(error.localizedDescription))
                    }
                }
                return
            }
            if let response = response as? HTTPURLResponse {
                strongSelf.handleDataTaskResults(forData: data, response: response)
            }
        })
        
        task.resume()
    }
    
    // Cancel Request
    func cancelTask() {
        guard let session = session else {
            return
        }
        session.getAllTasks { (dataTasks) in
            for task in dataTasks {
                task.cancel()
            }
        }
        //task.cancel()
    }
    // MARK: - Parser
    
    func parse(data: Data) {
        fatalError("Subclass should implement this function")
    }
    
    // MARK: - Handlers
    
    @discardableResult
    func onError(error: @escaping ((String) -> Void)) -> Self {
        self.errorHandler = error
        
        return self
    }
    func onTokenExpired(tokenExpired: @escaping (() -> Void)) -> Self {
        self.tokenExpiredHandler = tokenExpired
        
        return self
    }
    
    static func ==(lhs: Fetcher, rhs: Fetcher) -> Bool {
        return lhs === rhs
    }
}

// MARK: - Data / Response

extension Fetcher {
    
    fileprivate func handleDataTaskResults(forData data: Data?, response: HTTPURLResponse) {
        switch response.statusCode {
        case 200:
            DispatchQueue.main.async { [weak self] in
                self?.extract(data: data)
            }
        case 500:
            self.errorHandler("Internal server error - 500")
        default:
            self.errorHandler("Internal error - Please try again")
            break
        }
    }
    
    fileprivate func extract(data: Data?) {
        guard let data = data else {
            return
        }
        self.parse(data: data)
    }
}
