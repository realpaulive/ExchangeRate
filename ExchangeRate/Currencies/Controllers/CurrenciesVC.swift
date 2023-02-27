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
    
    private let searchController = UISearchController(searchResultsController: nil)
    private var valutes: [String : Valutes]?
    private let reusableCellIdentifier = "Cell"
    
    // MARK: - ViewMethods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.refreshControl = myRefreshControl
        
        tableView.isSkeletonable = true
        tableView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: UIColor(named: "Skeletonable")!), transition: .crossDissolve(0.4))
        
        FetchRequest.shared.currencyRequest { valutes in
            DispatchQueue.main.async {
                self.valutes = valutes
                self.tableView.hideSkeleton(transition: .crossDissolve(0.4))
                self.tableView.reloadData()
            }
        }
        setUpSearchBar()
    }
    
    // MARK: - Actions
    
    @IBAction func reloadAction(_ sender: UIBarButtonItem) {
        
    }
    
    // MARK: - TableViewFunctions
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
//    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//
//        return "Время"
//    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return Constants.currencyKeys.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reusableCellIdentifier, for: indexPath) as! CurrencyTableViewCell
        cell.backgroundColor = UIColor(named: "LightGray")
        
        let key = Constants.currencyKeys[indexPath.row]
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
    
    // MARK: - TableViewSwipeActions
    
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let TrashAction = UIContextualAction(style: .normal, title:  "Trash", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            print("Update action ...")
            let cell = tableView.cellForRow(at: indexPath)
            cell?.accessoryType = .checkmark
            success(true)
        })
        TrashAction.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [TrashAction])
    }
    
    override func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let TrashAction = UIContextualAction(style: .normal, title:  "Trash", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            let cell = tableView.cellForRow(at: indexPath)
            cell?.accessoryType = .none
            print("Update action ...")
            success(true)
        })
        TrashAction.backgroundColor = .yellow
        return UISwipeActionsConfiguration(actions: [TrashAction])
    }
    
}

// MARK: - Extensions: SearchBar

extension CurrenciesViewController: UISearchBarDelegate {
    
    private func setUpSearchBar () {
        navigationItem.searchController = searchController
        self.searchController.searchBar.delegate = self
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
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
        
        FetchRequest.shared.currencyRequest { valutes in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                self.valutes = valutes
                tableView.hideSkeleton(transition: .crossDissolve(0.4))
                tableView.reloadData()
            }
        }
    }
    
}

// MARK: - Extension: SkeletonViewDataSourse

extension CurrenciesViewController: SkeletonTableViewDataSource {
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return reusableCellIdentifier
    }
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    

}
