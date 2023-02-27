//
//  ConverterViewController.swift
//  ExchangeRate
//
//  Created by Paul Ive on 09.12.22.
//

import UIKit
import SkeletonView

class ConverterViewController: UIViewController {
    
    // MARK: - Values
    
    private var valutes = [String : Valutes]()
    private let reusableCellIdentifier = "ConverterCell"
    
    // MARK: - Outlets
    
    @IBOutlet weak var converterTableView: UITableView! {
        didSet {
            converterTableView.delegate = self
            converterTableView.dataSource = self
        }
    }
    
    // MARK: - ViewMethods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadConverter), name: NSNotification.Name(rawValue: "reloadConverter"), object: nil)
        
        converterTableView.isSkeletonable = true
        converterTableView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: UIColor(named: "Skeletonable")!), transition: .crossDissolve(0.4))
        
        
        FetchRequest.shared.currencyRequest { valutes in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.valutes = valutes
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
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ValutesListViewController") as! ValutesListViewController
        vc.isFromConverter = true
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.preferredCornerRadius = 22.0
            sheet.prefersGrabberVisible = false
        }
        self.present(vc, animated: true)
    }
    
}

// MARK: - TableViewSwipeActions

extension ConverterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let TrashAction = UIContextualAction(style: .normal, title:  "Trash", handler: { (ac:UIContextualAction, view:UIView, success:(Bool) -> Void) in
            print("Update action ...")
            let cell = tableView.cellForRow(at: indexPath) as! ConverterCell
            guard let key = cell.valuteKey.text else { return }
            guard let index = Constants.converterKeys.firstIndex(of: key) else { return }
            Constants.converterKeys.remove(at: index)
            tableView.reloadData()
            success(true)
        })
        TrashAction.backgroundColor = .red
        return UISwipeActionsConfiguration(actions: [TrashAction])
    }
    
}

// MARK: - Extensions: TableViewDataSourses

extension ConverterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.converterKeys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reusableCellIdentifier, for: indexPath) as! ConverterCell
        let key = Constants.converterKeys[indexPath.row]
        guard let value = valutes[key] else { return cell}
        cell.setUpCell(valutes: value, key: key)
        
        return cell
    }
}


// MARK: - Extension: SkeletonViewDataSourse

extension ConverterViewController: SkeletonTableViewDataSource {
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return reusableCellIdentifier
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
}
