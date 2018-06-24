//
//  SearchResult.swift
//  MoneyTap
//
//  Created by Bhuvanendra Pratap Maurya on 6/23/18.
//  Copyright © 2018 Bhuvanendra Pratap Maurya. All rights reserved.
//

import Foundation

struct SearchResult: Decodable {
    let query: Query?
}

struct Query: Decodable {
    let pages: [Page]?
}

struct Page: Decodable {
    let pageid: Int64?
    let title: String?
    let thumbnail: Thumbnail?
    let terms: Terms?
}

struct Thumbnail: Decodable {
    let source: String?
}

struct Terms: Decodable {
    let description: [String]?
}
