//
//  SearchFetcher.swift
//  MoneyTap
//
//  Created by Bhuvanendra Pratap Maurya on 6/23/18.
//  Copyright © 2018 Bhuvanendra Pratap Maurya. All rights reserved.
//

import Foundation

final internal class SearchFetcher: Fetcher {
    typealias SuccessHandler = (([Page]) -> Void)?
    fileprivate var successHandler: SuccessHandler = { _ in }
    
    @discardableResult
    func onSuccess(success: SuccessHandler) -> Self {
        self.successHandler = success
        return self
    }
    func search(searchText: String) {
        self.networkFetch(request: RequestFactory.search(text: searchText))
    }
    override func parse(data: Data) {
        let jsonDecoder = JSONDecoder()
        do {
            let response = try jsonDecoder.decode(SearchResult.self, from: data)
            guard let pages = response.query?.pages else {
                self.errorHandler("No result found")
                return
            }
            self.successHandler!(pages)
        } catch let jsonError {
            print("Json Parsing Error: \(jsonError)")
            self.errorHandler(jsonError.localizedDescription)
        }
    }
}
