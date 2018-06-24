//
//  PageDetail.swift
//  MoneyTap
//
//  Created by Bhuvanendra Pratap Maurya on 6/23/18.
//  Copyright © 2018 Bhuvanendra Pratap Maurya. All rights reserved.
//

import Foundation

struct PageDetail: Decodable {
    let batchcomplete: String?
    let query: PageQuery?
}
struct PageQuery: Decodable {
    let pages: [String: PageInfo]?
}
struct PageInfo: Decodable {
    let pageid: Int?
    let fullurl: String?
}
