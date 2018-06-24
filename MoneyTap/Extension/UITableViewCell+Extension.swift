//
//  UITableViewCell.swift
//  MoneyTap
//
//  Created by Bhuvanendra Pratap Maurya on 6/23/18.
//  Copyright © 2018 Bhuvanendra Pratap Maurya. All rights reserved.
//

import UIKit

extension UITableViewCell {
    /// Reuse Identifier String
    static var reuseIdentifier: String {
        return "\(self.self)"
    }
    
    /// Registers the Nib with the provided table
    static func registerWithTable(_ table: UITableView) {
        let bundle = Bundle(for: self)
        let nib = UINib(nibName: self.reuseIdentifier , bundle: bundle)
        table.register(nib, forCellReuseIdentifier: self.reuseIdentifier)
    }
}
