//
//  DetailsViewController.swift
//  MoneyTap
//
//  Created by Bhuvanendra Pratap Maurya on 6/23/18.
//  Copyright © 2018 Bhuvanendra Pratap Maurya. All rights reserved.
//

import UIKit
import WebKit

class DetailsViewController: UIViewController {

    @IBOutlet weak private var webView: WKWebView!
    var pageId: Int64 = 0
    
    var viewModel: DetailViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        webView.navigationDelegate = self
        
        viewModel = DetailViewModel(fetcher: DetailFetcher(), pageId: pageId)
        
        self.viewModel.bindToURL = { [unowned self] in
            if let url = URL(string: self.viewModel.url) {
                var request = URLRequest(url: url)
                self.displayActivityIndicator()
                request.cachePolicy = .returnCacheDataElseLoad
                self.webView.load(request)
            }
        }
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
extension DetailsViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.hideActivityIndicator()
    }
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        self.hideActivityIndicator()
    }
    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        self.hideActivityIndicator()
    }
}
