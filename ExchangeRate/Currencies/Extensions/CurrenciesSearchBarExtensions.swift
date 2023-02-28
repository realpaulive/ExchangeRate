//
//  CurrenciesSearchBarExtensions.swift
//  ExchangeRate
//
//  Created by Paul Ive on 28.02.23.
//

import Foundation
import UIKit

// MARK: - Extensions: SearchBar

extension CurrenciesViewController: UISearchBarDelegate {
    
    func setUpSearchBar () {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "Поиск..."
        searchController.searchBar.tintColor = UIColor(named: "Green")
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.keysFiltered.removeAll()
        
        switch searchText {
        case "": break
        case " ": break
        default:
            for key in Constants.currencyKeys {
                let text = searchText.uppercased()
                let keyContains = key.range(of: text)
                let valutesContains = valutes?[key]?.name.uppercased().range(of: text)
                if keyContains != nil || valutesContains != nil {
                    keysFiltered.append(key)
                }
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.keysFiltered.removeAll()
    }
}
