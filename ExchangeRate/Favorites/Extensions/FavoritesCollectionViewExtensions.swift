//
//  CollectionViewExtensions.swift
//  ExchangeRate
//
//  Created by Paul Ive on 28.02.23.
//

import Foundation
import UIKit

// MARK: - Extensions: Delegate, DataSourse

extension FavoritesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Constants.favoritesKeys.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let identifier = FavoriteViewCell().reusableCellIdentifier
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! FavoriteViewCell
        
        let key = Constants.favoritesKeys[indexPath.row]
        guard let value = self.valutes?[key] else { return cell }
        cell.setUpFavoriteCell(valutes: value, key: key)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let key = Constants.favoritesKeys[indexPath.row]
        let vc = CurrencySheetViewController().showYourself(from: self, whithKey: key)
        self.present(vc, animated: true)
    }
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        if let sectionHeader = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "SectionHeader", for: indexPath) as? SectionHeader {
            sectionHeader.sectionHeaderlabel.text = self.lastUpdate
            return sectionHeader
        }
        return UICollectionReusableView()
    }
    
}

// MARK: - Extensions: LayoutSettingUp

extension FavoritesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = self.view.frame.width - 32
        return CGSize(width: width, height: 64)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}
