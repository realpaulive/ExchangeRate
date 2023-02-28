//
//  RefreshControl.swift
//  ExchangeRate
//
//  Created by Paul Ive on 28.02.23.
//

import Foundation
import UIKit


// MARK: - Extension: RefreshControl

extension FavoritesViewController {
    var myRefreshControl: UIRefreshControl {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshValues(sender:)), for: .valueChanged)
        return refreshControl
    }
    
    @objc
    private func refreshValues(sender: UIRefreshControl) {
        self.valutes = nil
        self.collectionView.reloadData()
        self.collectionView.startSkeletonAnimation()
        self.collectionView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: UIColor(named: "Skeletonable")!), transition: .crossDissolve(0.4))
        
        FetchRequest.shared.currencyRequest { [unowned self] valutes, timestamp in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                self.valutes = valutes
                self.lastUpdate = timestamp
                self.collectionView.hideSkeleton(transition: .crossDissolve(0.4))
                self.collectionView.reloadData()
            }
        }
        sender.endRefreshing()
    }
}
