//
//  SearchResultViewModel.swift
//  MoneyTap
//
//  Created by Bhuvanendra Pratap Maurya on 6/23/18.
//  Copyright © 2018 Bhuvanendra Pratap Maurya. All rights reserved.
//

import Foundation

class SearchResultViewModel: NSObject {
    private var fetcher: SearchFetcher!
    
    @objc dynamic private(set) var tableDataSource: [SearchResultCellViewModel] = [SearchResultCellViewModel]()
    
    var observer: NSKeyValueObservation?
    var bindToTableDataSource: (() -> Void) = { }
    
    
    init(fetcher: SearchFetcher) {
        self.fetcher = fetcher
        super.init()
        self.observer = self.observe(\.tableDataSource, options: NSKeyValueObservingOptions.new, changeHandler: { [unowned self] (_, _) in
            self.bindToTableDataSource()
        })
        self.fetcheCachedResult()
    }
    func fetcheCachedResult() {
        if let user = User.fetchObject() {
            var cellDataArray = [SearchResultCellViewModel]()
            for page in user {
                cellDataArray.append(SearchResultCellViewModel.init(with: page))
            }
            self.tableDataSource = cellDataArray
        }
    }
    func fetchSearchedUser(searchedText: String) {
        self.fetcher
            .onSuccess { [weak self] (result) in
                _ = User.deleteRecords()

                var cellDataArray = [SearchResultCellViewModel]()
                for page in result {
                    cellDataArray.append(SearchResultCellViewModel(with: page))
                }
                self?.tableDataSource = cellDataArray
            }
            .onError { [weak self] (error) in
                Helper.showAlert(message: error, title: "")
                self?.tableDataSource = []
            }
            .search(searchText: searchedText)
    }
    
    func resetTableDataSource() {
        self.tableDataSource = []
    }
}
