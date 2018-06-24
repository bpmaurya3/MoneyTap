//
//  DetailFetcherTests.swift
//  MoneyTapTests
//
//  Created by Bhuvanendra Pratap Maurya on 6/24/18.
//  Copyright © 2018 Bhuvanendra Pratap Maurya. All rights reserved.
//

@testable import MoneyTap
import XCTest

class DetailFetcherTests: XCTestCase {
    
    func testFetchingPageDetailsWithValidPageId() {
        let exp = expectation(description: "Retreive page page details")
        let timeOut = 10.0
        
        let fetcher = DetailFetcher()
        
        fetcher
            .onSuccess { (pagedetail) in
                exp.fulfill()
            }
            .onError { _ in
                XCTFail()
            }
            .fetchDetail(pageId: 57570)
        
        waitForExpectations(timeout: timeOut) { (error) in
            XCTAssertNil(error)
        }
    }
    
    func testFetchingPageDetailsWithInValidPageId() {
        let exp = expectation(description: "Failed to Retreive page page details")
        let timeOut = 10.0
        
        let fetcher = DetailFetcher()
        
        fetcher
            .onSuccess { (pagedetail) in
                XCTFail()
            }
            .onError { _ in
                exp.fulfill()
            }
            .fetchDetail(pageId: 340293123128938)
        
        waitForExpectations(timeout: timeOut) { (error) in
            XCTAssertNil(error)
        }
    }
    
}
