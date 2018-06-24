//
//  SearchResultCellViewModel.swift
//  MoneyTap
//
//  Created by Bhuvanendra Pratap Maurya on 6/23/18.
//  Copyright © 2018 Bhuvanendra Pratap Maurya. All rights reserved.
//

import Foundation

class SearchResultCellViewModel: NSObject {
    var pageId: Int64?
    var image: String?
    var name: String?
    var desc: String?
    override init() {
        super.init()
    }
    init(image: String, name: String, desc: String) {
        self.image = image
        self.name = name
        self.desc = desc
    }
    
    init(with page: Page) {
        self.image = page.thumbnail?.source
        self.name = page.title
        if let description = page.terms?.description {
            self.desc = description[0]
        }
        self.pageId = page.pageid
        _ = User.saveObject(image: self.image ?? "", name: self.name ?? "", desc: self.desc ?? "", pageid: self.pageId ?? 0, url: "")
    }
    init(with page: User) {
        self.image = page.image
        self.name = page.name
        self.desc = page.desc
        self.pageId = page.pageid
    }
}
