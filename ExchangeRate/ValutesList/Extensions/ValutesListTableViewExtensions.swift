//
//  ValutesListTableViewExtensions.swift
//  ExchangeRate
//
//  Created by Paul Ive on 28.02.23.
//

import Foundation
import UIKit

// MARK: - Extensions: TableViewDelegates

extension ValutesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! TinyValutesCell
        guard let key = cell.valuteKey.text else { return }
        
        let cellConfig = configuration(key: key)
        switch cellConfig {
        case .favoritesContainsKey:
            guard let index = Constants.favoritesKeys.firstIndex(of: key) else { return }
            Constants.favoritesKeys.remove(at: index)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadFavorites"), object: nil)
        case .favoritesWithoutKey:
            Constants.favoritesKeys.append(key)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadFavorites"), object: nil)
        case .converterContainsKey:
            guard let index = Constants.converterKeys.firstIndex(of: key) else { return }
            Constants.converterKeys.remove(at: index)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadConverter"), object: nil)
        case .converterWithoutKey:
            Constants.converterKeys.append(key)
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "reloadConverter"), object: nil)
        case .unknownSender:
            print("unknownSender")
        }
        
        let generator = UIImpactFeedbackGenerator(style: .medium)
        generator.impactOccurred()
        
        tableView.reloadData()
    }
}

// MARK: - Extensions: TableViewDataSourses

extension ValutesListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.currencyKeys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = TinyValutesCell().reusableCellIdentifier
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! TinyValutesCell
        let key = Constants.currencyKeys[indexPath.row]
        guard let value = valutes[key] else { return cell}
        cell.setUpCell(valutes: value, key: key)
        
        let cellConfig = configuration(key: key)
        
        switch cellConfig {
        case .favoritesContainsKey:
            cell.accessoryType = .checkmark
        case .favoritesWithoutKey:
            cell.accessoryType = .none
        case .converterContainsKey:
            cell.accessoryType = .checkmark
        case .converterWithoutKey:
            cell.accessoryType = .none
        case .unknownSender:
            cell.accessoryType = .none
            print("unknownSender")
        }
        return cell
    }
}

// MARK: - Extensions: CellConfiguration

extension ValutesListViewController {
    enum ValutesListConfiguration {
        case favoritesContainsKey
        case favoritesWithoutKey
        case converterContainsKey
        case converterWithoutKey
        case unknownSender
    }
    
    private func configuration (key: String) -> ValutesListConfiguration {
        if isFromFavorites && Constants.favoritesKeys.contains(key) {
            return ValutesListConfiguration.favoritesContainsKey
        } else if isFromFavorites && !Constants.favoritesKeys.contains(key) {
            return ValutesListConfiguration.favoritesWithoutKey
        } else if isFromConverter && Constants.converterKeys.contains(key) {
            return ValutesListConfiguration.converterContainsKey
        } else if isFromConverter && !Constants.converterKeys.contains(key) {
            return ValutesListConfiguration.converterWithoutKey
        } else { return ValutesListConfiguration.unknownSender }
    }
}
