//
//  CurrenciesVC.swift
//  ExchangeRate
//
//  Created by Paul Ive on 09.12.22.
//

import UIKit

class CurrenciesViewController: UITableViewController {
    
    let constants = Constants()
    let searchController = UISearchController(searchResultsController: nil)
    
    let updatedCurrencies = UpdateCurrencies.shared
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.reloadData()
        setUpSearchBar()
    }
    
    @IBAction func reloadAction(_ sender: UIBarButtonItem) {
        self.tableView.reloadData()
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
        return "\(updatedCurrencies.data?.timestamp ?? "нет данных")"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return updatedCurrencies.valutes.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CurrencyTableViewCell
        cell.backgroundColor = UIColor(named: "LightGray")
        
        let key = constants.currencyKeys[indexPath.row]
        let value = updatedCurrencies.valutes[key]
        
        cell.setUpCell(valutes: value!, key: key)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let key = constants.currencyKeys[indexPath.row]
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let sheetVC = storyboard.instantiateViewController(withIdentifier: "CurrencySheetView") as! CurrencySheetViewController
        sheetVC.key = key
        if let sheet = sheetVC.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.preferredCornerRadius = 22.0
            sheet.prefersGrabberVisible = true
        }
    
        self.present(sheetVC, animated: true)
    }
    
}

// MARK: - Extensions

extension CurrenciesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }
}
//extension CurrenciesViewController: UISheetPresentationControllerDelegate {
//    override var sheetPresentationController: UISheetPresentationController? {
//        presentationController as? UISheetPresentationController
//    }
//}