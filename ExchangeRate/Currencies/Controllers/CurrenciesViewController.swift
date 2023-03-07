//
//  CurrenciesViewController.swift
//  ExchangeRate
//
//  Created by Paul Ive on 09.12.22.
//

import UIKit
import SkeletonView

final class CurrenciesViewController: UITableViewController {
    
    // MARK: - Values
    
    var valutes: [String : Valutes]?
    var lastUpdate: String?
    var keysFiltered = [String]() {
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
        let keys = rightKeyWhenSerach()
        let key = keys[indexPath.row]
        let vc = CurrencySheetViewController().showYourself(from: self, whithKey: key)
        self.present(vc, animated: true)
    }
}


// MARK: - Extension: GettingRigthKeysArrayWhenSearching

extension CurrenciesViewController {
    func rightKeyWhenSerach () -> [String] {
        guard self.keysFiltered.isEmpty else {
            return self.keysFiltered
        }
        return Constants.currencyKeys
    }
}
