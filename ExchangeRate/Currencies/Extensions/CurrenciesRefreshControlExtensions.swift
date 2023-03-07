//
//  RefreshControlExtensions.swift
//  ExchangeRate
//
//  Created by Paul Ive on 28.02.23.
//

import Foundation
import UIKit

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
