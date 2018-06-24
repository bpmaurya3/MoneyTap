//
//  DetailViewModel.swift
//  MoneyTap
//
//  Created by Bhuvanendra Pratap Maurya on 6/23/18.
//  Copyright © 2018 Bhuvanendra Pratap Maurya. All rights reserved.
//

import Foundation

class DetailViewModel: NSObject {
    let fetcher: DetailFetcher!
    let pageId: Int64!
    
    @objc dynamic private(set) var url: String = ""
    
    var observer: NSKeyValueObservation?
    var bindToURL: (() -> Void) = { }
    
    init(fetcher: DetailFetcher, pageId: Int64) {
        self.fetcher = fetcher
        self.pageId = pageId
        
        super.init()
        
        self.observer = self.observe(\.url, options: NSKeyValueObservingOptions.new, changeHandler: { [unowned self] (_, _) in
            self.bindToURL()
        })
        if let user = User.fetchObject(pageid: self.pageId), let urlString = user.url, urlString != "" {
            DispatchQueue.main.async {
                self.url = urlString
            }
        } else {
            self.fetchPage()
        }
    }
    
    private func fetchPage() {
        self.fetcher
            .onSuccess { [weak self] (urlString) in
                self?.url = urlString
                _ = User.updateObject(pageid: (self?.pageId)!, url: urlString)
            }
            .onError { (error) in
                Helper.showAlert(message: error, title: "")
            }
            .fetchDetail(pageId: self.pageId)
    }
}
