//
//  CurrenciesViewController.swift
//  ExchangeRate
//
//  Created by Paul Ive on 09.12.22.
//

import UIKit

class CurrenciesViewController: UITableViewController {
    
    let constants = Constants()
    var response: Response? = nil
    
    let searchController = UISearchController(searchResultsController: nil)
    let networkService = NetworkService()
    
    let urlString = "https://www.cbr-xml-daily.ru/daily_json.js"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpSearchBar()
        networkService.fetchRequest(whithURL: urlString) { [weak self] result in
            switch result {
            case .success(let response):
                self?.response = response
                self?.tableView.reloadData()
                let time = response.timestamp
                print(time)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    
// MARK: - TableViewFunctions
    
    private func setUpSearchBar () {
        navigationItem.searchController = searchController
        self.searchController.searchBar.delegate = self
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Last update: \(response?.timestamp ?? "unknown")"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return constants.currencyKeys.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.backgroundColor = UIColor(named: "LightGray")
        
        let key = constants.currencyKeys[indexPath.row]
        let value = Valutes(currentRateData: (response?.valute[key])!)
        
        cell.textLabel?.text = key
        cell.detailTextLabel?.text = value?.name
        
        return cell
    }
    
}

// MARK: - Extensions

extension CurrenciesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}
