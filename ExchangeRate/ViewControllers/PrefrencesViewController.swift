//
//  PrefrencesViewController.swift
//  ExchangeRate
//
//  Created by Paul Ive on 09.12.22.
//

import UIKit

class PrefrencesViewController: UIViewController {
    
    @IBOutlet weak var tableViewForFrame: UITableView!
    
    var prefrencesTableElements = ["App version","Rate us", "Share the app", "Contact us"]
    var prefrencesTableView = UITableView()
    let identifire = "Cell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createTable()
    }
    
    @IBAction func doneBarButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
    
    func createTable () {
        self.prefrencesTableView = UITableView(frame: tableViewForFrame.frame, style: .insetGrouped)
        prefrencesTableView.register(UITableViewCell.self, forCellReuseIdentifier: identifire)
        
        self.prefrencesTableView.delegate = self
        self.prefrencesTableView.dataSource = self
        
        
        view.addSubview(prefrencesTableView)
    }
    
    
}

extension PrefrencesViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch section {
        case 0:
            return 0
        case 1:
            return prefrencesTableElements.count
        default:
            break
        }
        return prefrencesTableElements.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        switch section {
        case 0:
            return "First section"
        case 1:
            return "Second section"
        default:
            break
        }
        
        return "Nonamed section"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: identifire, for: indexPath)
        
        cell.textLabel?.text = prefrencesTableElements[indexPath.row]
        
        return cell
    }
    
    
}





