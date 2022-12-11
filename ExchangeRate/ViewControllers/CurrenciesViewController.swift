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
        return "\(response?.timestamp ?? "нет данных")"
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return constants.currencyKeys.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CurrencyTableViewCell
        cell.backgroundColor = UIColor(named: "LightGray")
        
        let key = constants.currencyKeys[indexPath.row]
        guard let resp = response?.valute[key] else { return cell }
        let value = Valutes(currentRateData: (resp))
        
        
        
        cell.currencyKey?.text = key
        cell.currancyName?.text = { return value!.nominalString + " " + value!.name }()
        cell.currancyValue.text =  { return value!.currencyValueString + " ₽" }()
        cell.dailyChange.text = value?.dailyChangeString
        cell.dailyChange.textColor = UIColor(named: value!.dailyChangeColor)
    
        cell.currencyImage.image = UIImage(named: key)
        cell.currencyImage.layer.cornerRadius = cell.currencyImage.frame.size.height / 4
        cell.currencyImage.layer.borderWidth = 0.2
        cell.currencyImage.layer.borderColor = CGColor(gray: 0.1, alpha: 1)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(constants.currencyKeys[indexPath.row])
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let sheetVC = storyboard.instantiateViewController(withIdentifier: "CurrancySheetView") as! CurrancySheetViewController
        
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
