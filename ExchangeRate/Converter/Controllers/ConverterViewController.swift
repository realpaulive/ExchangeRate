//
//  ConverterViewController.swift
//  ExchangeRate
//
//  Created by Paul Ive on 09.12.22.
//

import UIKit

class ConverterViewController: UIViewController {
    
    // MARK: - Values
    
    private var valutes = [String : Valutes]()
    
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
        
        FetchRequest.shared.currencyRequest { valutes in
            self.valutes = valutes
            DispatchQueue.main.async {
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

// MARK: - Extensions: TableViewDelegates

extension ConverterViewController: UITableViewDelegate {
    
}

// MARK: - Extensions: TableViewDataSourses

extension ConverterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.converterKeys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ConverterCell", for: indexPath) as! ConverterCell
        let key = Constants.converterKeys[indexPath.row]
        guard let value = valutes[key] else { return cell}
        cell.setUpCell(valutes: value, key: key)
        
        return cell
    }
}
