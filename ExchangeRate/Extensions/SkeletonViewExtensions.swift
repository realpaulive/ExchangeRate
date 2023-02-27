//
//  SkeletonViewExtensions.swift
//  ExchangeRate
//
//  Created by Paul Ive on 27.02.23.
//

import Foundation
import SkeletonView

// MARK: - Extension: FavoritesViewController

extension FavoritesViewController: SkeletonCollectionViewDataSource {
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> SkeletonView.ReusableCellIdentifier {
        let identifier = FavoriteViewCell().reusableCellIdentifier
        return identifier
    }
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Constants.favoritesKeys.count
    }
}


// MARK: - Extension: ConverterViewController

extension ConverterViewController: SkeletonTableViewDataSource {
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        let identifier = ConverterCell().reusableCellIdentifier
        return identifier
    }
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
}


// MARK: - Extension: CurrenciesViewController

extension CurrenciesViewController: SkeletonTableViewDataSource {
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        let identifier = CurrencyTableViewCell().reusableCellIdentifier
        return identifier
    }
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
}


// MARK: - Extension: ValutesListViewController

extension ValutesListViewController: SkeletonTableViewDataSource {
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        let identifier = TinyValutesCell().reusableCellIdentifier
        return identifier
    }
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
}
