//
//  SearchResultTableViewCell.swift
//  MoneyTap
//
//  Created by Bhuvanendra Pratap Maurya on 6/23/18.
//  Copyright © 2018 Bhuvanendra Pratap Maurya. All rights reserved.
//

import UIKit
import Kingfisher

class SearchResultTableViewCell: UITableViewCell {

    @IBOutlet weak private var profileImage: UIImageView!
    @IBOutlet weak private var nameLbel: UILabel!
    @IBOutlet weak private var descriptionLabel: UILabel!
    
    var cellModel: SearchResultCellViewModel? {
        didSet {
            guard let data = cellModel else {
                return
            }
            parseData(data: data)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    private func parseData(data: SearchResultCellViewModel) {
        self.profileImage.image = #imageLiteral(resourceName: "Placeholder")
        if let image = data.image {
            profileImage.kf.setImage(with: URL(string: image), placeholder: #imageLiteral(resourceName: "Placeholder"), options: nil, progressBlock: nil, completionHandler: nil)
        }
        nameLbel.text = data.name
        descriptionLabel.text = data.desc
        
        self.profileImage.layer.cornerRadius = 100
    }
}
