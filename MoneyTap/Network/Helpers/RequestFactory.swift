//
//  RequestFactory.swift
//  MoneyTap
//
//  Created by Bhuvanendra Pratap Maurya on 6/23/18.
//  Copyright © 2018 Bhuvanendra Pratap Maurya. All rights reserved.
//

import Foundation


final internal class RequestFactory: NSObject {
    
    fileprivate static let BaseURL = "https://en.wikipedia.org/w/api.php?action=query"
    
}

extension RequestFactory {
    static func search(text: String) -> URLRequest {
        let seachedText = text.replacingOccurrences(of: " ", with: "+")
        let parameters = "&format=json&prop=pageimages%7Cpageterms&generator=prefixsearch&redirects=1&formatversion=2&piprop=thumbnail&pithumbsize=50&pilimit=10&wbptterms=description&gpssearch=\(seachedText)&gpslimit=10"
        let pathWithParameters = BaseURL + parameters
        print("search request: \(pathWithParameters)")
        let request = RequestBuilder()
            .ofType(.GET)
            .set(urlString: pathWithParameters)
            .set(contentType: "application/json")
            .build()
        
        return request!
    }
    
    static func pageUrl(pageId: Int64) -> URLRequest {
        let parameters = "&prop=info&pageids=\(pageId)&inprop=url&format=json"
        let pathWithParameters = BaseURL + parameters
        print("page request: \(pathWithParameters)")
        let request = RequestBuilder()
            .ofType(.GET)
            .set(urlString: pathWithParameters)
            .set(contentType: "application/json")
            .build()
        
        return request!
    }
}
