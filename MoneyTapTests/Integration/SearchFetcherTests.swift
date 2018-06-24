//
//  SearchFetcherTests.swift
//  MoneyTapTests
//
//  Created by Bhuvanendra Pratap Maurya on 6/24/18.
//  Copyright © 2018 Bhuvanendra Pratap Maurya. All rights reserved.
//
@testable import MoneyTap
import XCTest

class SearchFetcherTests: XCTestCase {
    
    func testFetchingSearchResultWithSearchText() {
        let exp = expectation(description: "Retreive Searched User")
        let timeOut = 10.0
        
        let fetcher = SearchFetcher()
        
        fetcher
            .onSuccess { (searchResult) in
                exp.fulfill()
            }
            .onError { _ in
                XCTFail()
            }
            .search(searchText: "Sachin T")
        
        waitForExpectations(timeout: timeOut) { (error) in
            XCTAssertNil(error)
        }
    }
    
    func testFetchingSearchResultWithoutSearchText() {
        let exp = expectation(description: "Failed to get results")
        let timeOut = 10.0
        
        let fetcher = SearchFetcher()
        
        fetcher
            .onSuccess { (searchResult) in
                XCTFail()
            }
            .onError { _ in
                exp.fulfill()
            }
            .search(searchText: "")
        
        waitForExpectations(timeout: timeOut) { (error) in
            XCTAssertNil(error)
        }
    }
    
    func testFetchingSearchResultWithInvalidText() {
        let exp = expectation(description: "Failed to get results")
        let timeOut = 10.0
        
        let fetcher = SearchFetcher()
        
        fetcher
            .onSuccess { (searchResult) in
                XCTFail()
            }
            .onError { _ in
                exp.fulfill()
            }
            .search(searchText: "djfdshjfbsjhdfbjshd")
        
        waitForExpectations(timeout: timeOut) { (error) in
            XCTAssertNil(error)
        }
    }
    
}
