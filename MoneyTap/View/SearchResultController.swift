//
//  SearchResultController.swift
//  MoneyTap
//
//  Created by Bhuvanendra Pratap Maurya on 6/23/18.
//  Copyright © 2018 Bhuvanendra Pratap Maurya. All rights reserved.
//

import UIKit

class SearchResultController: UIViewController {
    @IBOutlet weak private var tableView: UITableView!
    @IBOutlet weak private var searchBar: UISearchBar!
    
    private var dataSource: TableViewDataSource<SearchResultTableViewCell, SearchResultCellViewModel>!
    private var viewModel: SearchResultViewModel!
    private var pageId: Int64?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Search Wiki's Personalities"
        self.searchBar.placeholder = "Search"
        
        SearchResultTableViewCell.registerWithTable(tableView)
        self.tableView.tableFooterView?.isHidden = true
       
        viewModel = SearchResultViewModel(fetcher: SearchFetcher())
        viewModel.bindToTableDataSource = { [unowned self] in
            self.setDataSource()
        }
        setDataSource()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension SearchResultController {
    private func setDataSource() {
        self.dataSource = TableViewDataSource(cellIdentifier: SearchResultTableViewCell.reuseIdentifier , items: self.viewModel.tableDataSource) { cell, vm in
            cell.cellModel = vm
        }
        self.tableView.dataSource = self.dataSource
        self.tableView.reloadData()
    }
}
extension SearchResultController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.pageId = self.viewModel.tableDataSource[indexPath.row].pageId
        self.performSegue(withIdentifier: "DetailsViewController", sender: nil)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "DetailsViewController", let destination = segue.destination as? DetailsViewController {
            destination.pageId = self.pageId ?? 0
        }
    }
}
extension SearchResultController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar,
                   textDidChange searchText: String) {
        if searchText == "" {
            self.viewModel.resetTableDataSource()
        }
    }
    func searchBar(_ searchBar: UISearchBar, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if searchBar.textInputMode?.primaryLanguage == nil || searchBar.textInputMode?.primaryLanguage == "emoji" {
            return false
        }
        return true
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
        guard let text = searchBar.text?.trimmingCharacters(in: .whitespacesAndNewlines) else {
            return
        }
        self.viewModel.fetchSearchedUser(searchedText: text)
    }
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.showsScopeBar = true
        searchBar.sizeToFit()
        searchBar.setShowsCancelButton(true, animated: true)
        return true
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        searchBar.showsScopeBar = false
        searchBar.sizeToFit()
        searchBar.setShowsCancelButton(false, animated: true)
        return true
    }
}
