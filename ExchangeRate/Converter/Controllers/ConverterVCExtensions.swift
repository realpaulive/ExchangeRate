//
//  ConverterVCExtensions.swift
//  ExchangeRate
//
//  Created by Paul Ive on 02.03.23.
//

import Foundation
import UIKit


// MARK: - TableViewSwipeActions

extension ConverterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        let indexPathForRUR = IndexPath(row: 0, section: 0)
        guard indexPath != indexPathForRUR else {
            return nil
        }
        
        let TrashAction = UIContextualAction(style: .normal, title:  "Удалить", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
           
            let cell = tableView.cellForRow(at: indexPath) as! ConverterCell
            guard let key = cell.valuteKey.text else { return }
            guard let index = Constants.converterKeys.firstIndex(of: key) else { return }
            Constants.converterKeys.remove(at: index)
            tableView.deleteRows(at: [indexPath], with: .left)
            
            success(true)
        })
        TrashAction.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [TrashAction])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}

// MARK: - Extensions: TableViewDataSourses

extension ConverterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.converterKeys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = ConverterCell().reusableCellIdentifier
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! ConverterCell
        let key = Constants.converterKeys[indexPath.row]
        guard let valute = self.valutes[key] else { return cell}
        cell.setUpCell(valutes: valute, key: key, textFieldChange: self.changedValue)
        
        return cell
    }
}

extension ConverterViewController {
    
    @objc func textDidChange(notification: NSNotification){
        let value = returnArrayOfKeysValues(ncDict: notification.userInfo)
        self.changedValue = value[1]
        
        let converterKeys = Constants.converterKeys
        var indexPathArray: [IndexPath] = []
        
        for (index, valute) in converterKeys.enumerated() {
            switch valute {
            case value[0]: break
            default:
                let indexPath = IndexPath(row: index, section: 0)
                indexPathArray.append(indexPath)
            }
        }
        
        converterTableView.reloadRows(at: indexPathArray, with: .none)
        print(value)
    }
    
    func returnArrayOfKeysValues(ncDict dict: [AnyHashable : Any]?) -> [String] {
        var arrayOfKeysValues: [String] = []
        let keyArray = dict.map { Array($0.keys) }
        let valuesArray = dict.map { Array($0.values) }
        for key: String? in keyArray as? [String?] ?? [] {
            guard let key = key else { return arrayOfKeysValues }
            arrayOfKeysValues.append(key)
        }
        for value: String? in valuesArray as? [String?] ?? [] {
            guard let value = value else { return arrayOfKeysValues }
            arrayOfKeysValues.append(value)
        }
        return arrayOfKeysValues
    }
}

