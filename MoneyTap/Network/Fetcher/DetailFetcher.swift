//
//  DetailFetcher.swift
//  MoneyTap
//
//  Created by Bhuvanendra Pratap Maurya on 6/23/18.
//  Copyright © 2018 Bhuvanendra Pratap Maurya. All rights reserved.
//

import Foundation

final internal class DetailFetcher: Fetcher {
    private var pageId: Int64?
    typealias SuccessHandler = ((String) -> Void)?
    fileprivate var successHandler: SuccessHandler = { _ in }
    
    @discardableResult
    func onSuccess(success: SuccessHandler) -> Self {
        self.successHandler = success
        return self
    }
    func fetchDetail(pageId: Int64) {
        self.pageId = pageId
        self.networkFetch(request: RequestFactory.pageUrl(pageId: pageId))
    }
    override func parse(data: Data) {
        let jsonDecoder = JSONDecoder()
        do {
            let response = try jsonDecoder.decode(PageDetail.self, from: data)
            guard let pages = response.query?.pages, let url = pages["\(self.pageId ?? 0)"]?.fullurl else {
                self.errorHandler("No detail found")
                return
            }
            self.successHandler!(url)
        } catch let jsonError {
            print("Json Parsing Error: \(jsonError)")
            self.errorHandler(jsonError.localizedDescription)
        }
    }
}
