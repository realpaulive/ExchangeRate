//
//  ConverterViewController.swift
//  ExchangeRate
//
//  Created by Paul Ive on 09.12.22.
//

import UIKit
import SkeletonView

final class ConverterViewController: UIViewController {
    
    // MARK: - Values
    
    private var valutes = [String : Valutes]()
    
    
    // MARK: - Outlets
    
    @IBOutlet weak var converterTableView: UITableView! {
        didSet {
            converterTableView.delegate = self
            converterTableView.dataSource = self
            converterTableView.sectionHeaderHeight = 60
            converterTableView.register(UINib(nibName: "ConverterHeaderView", bundle: nil), forHeaderFooterViewReuseIdentifier: "ConverterHeaderView")
        }
    }
    
    // MARK: - ViewMethods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadConverter), name: NSNotification.Name(rawValue: "reloadConverter"), object: nil)
      
        converterTableView.isSkeletonable = true
        converterTableView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: UIColor(named: "Skeletonable")!), transition: .crossDissolve(0.4))
        
        
        FetchRequest.shared.currencyRequest { [unowned self] valutes, _ in
            DispatchQueue.main.async {
                self.valutes = valutes
                self.valutes["RUR"] = Constants.ruble
                self.converterTableView.hideSkeleton(transition: .crossDissolve(0.4))
                self.converterTableView.reloadData()
            }
        }
        
        
        
    }
    
    @objc func reloadConverter(notification: NSNotification){
        self.converterTableView.reloadData()
    }
    
    
    // MARK: - Actions
    
    @IBAction func addNewValutesAction(_ sender: Any) {
        let vc = ValutesListViewController().showYourself(from: self)
        self.present(vc, animated: true)
    }
    
}

// MARK: - TableViewSwipeActions

extension ConverterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let TrashAction = UIContextualAction(style: .normal, title:  "Trash", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
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
        guard let value = valutes[key] else { return cell}
        cell.setUpCell(valutes: value, key: key)
        cell.valuteValue.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = converterTableView.dequeueReusableHeaderFooterView(withIdentifier: "ConverterHeaderView") as! ConverterHeaderView
        guard let valute = valutes["RUR"] else { return headerView }
        headerView.setUpHeader(valutes: valute, key: "RUR", textFieldChange: nil)
        headerView.valuteValue.delegate = self
        return headerView
    }
}

extension ConverterViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        
        return true
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.converterTableView.reloadData()
    }
}
