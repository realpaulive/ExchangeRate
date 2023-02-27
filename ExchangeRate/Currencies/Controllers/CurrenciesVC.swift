//
//  CurrenciesVC.swift
//  ExchangeRate
//
//  Created by Paul Ive on 09.12.22.
//

import UIKit
import SkeletonView

class CurrenciesViewController: UITableViewController {
    
    // MARK: - Values
    
    private var valutes: [String : Valutes]?
    private var lastUpdate: String?
    private var keysFiltered = [String]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    // MARK: - ViewMethods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refreshControl = myRefreshControl
        
        tableView.isSkeletonable = true
        tableView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: UIColor(named: "Skeletonable")!), transition: .crossDissolve(0.4))
        
        FetchRequest.shared.currencyRequest { [unowned self]  valutes, timestamp in
            DispatchQueue.main.async {
                self.valutes = valutes
                self.lastUpdate = timestamp
                self.tableView.hideSkeleton(transition: .crossDissolve(0.4))
                self.tableView.reloadData()
            }
        }
        setUpSearchBar()
    }
    
    // MARK: - Actions
    
    @IBAction func reloadAction(_ sender: UIBarButtonItem) {
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        update(tableView: self.tableView)
    }
    
    // MARK: - TableViewFunctions
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard self.keysFiltered.isEmpty else {
            return self.keysFiltered.count
        }
        return Constants.currencyKeys.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = CurrencyTableViewCell().reusableCellIdentifier
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! CurrencyTableViewCell
        cell.backgroundColor = UIColor(named: "LightGray")
        
        var keys: [String] {
            guard self.keysFiltered.isEmpty else {
                return self.keysFiltered
            }
            return Constants.currencyKeys
        }
        let key = keys[indexPath.row]
        guard let value = self.valutes?[key] else { return cell}
        cell.setUpCell(valutes: value, key: key)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let key = Constants.currencyKeys[indexPath.row]
        
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


// MARK: - Extensions: SearchBar

extension CurrenciesViewController: UISearchBarDelegate {
    
    private func setUpSearchBar () {
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


// MARK: - Extension: RefreshControl

extension CurrenciesViewController {
    var myRefreshControl: UIRefreshControl {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshValues(sender:)), for: .valueChanged)
        return refreshControl
    }
    
    @objc
    private func refreshValues(sender: UIRefreshControl) {
        update(tableView: self.tableView)
        sender.endRefreshing()
    }
    
    func update(tableView: UITableView) {
        self.valutes = nil
        tableView.reloadData()
        tableView.startSkeletonAnimation()
        tableView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: UIColor(named: "Skeletonable")!), transition: .crossDissolve(0.4))
        
        FetchRequest.shared.currencyRequest { [unowned self] valutes, timestamp in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                self.valutes = valutes
                self.lastUpdate = timestamp
                
                tableView.hideSkeleton(transition: .crossDissolve(0.4))
                tableView.reloadData()
            }
        }
    }
}

