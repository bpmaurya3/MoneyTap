//
//  SearchResultController.swift
//  MoneyTap
//
//  Created by Bhuvanendra Pratap Maurya on 6/23/18.
//  Copyright © 2018 Bhuvanendra Pratap Maurya. All rights reserved.
//

import Foundation
import UIKit

class TableViewDataSource<Cell: UITableViewCell, ViewModel> : NSObject, UITableViewDataSource {
    
    private var cellIdentifier: String!
    private var items: [ViewModel]!
    var configureCell: (Cell, ViewModel) -> Void
    
    init(cellIdentifier: String, items: [ViewModel], configureCell: @escaping (Cell, ViewModel) -> Void) {
        
        self.cellIdentifier = cellIdentifier
        self.items = items
        self.configureCell = configureCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath) as? Cell, self.items.count > indexPath.row else {
            return UITableViewCell()
        }
        let item = self.items[indexPath.row]
        self.configureCell(cell, item)
        return cell
    }
    
}
