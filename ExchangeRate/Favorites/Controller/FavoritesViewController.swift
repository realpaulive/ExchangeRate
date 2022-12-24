//
//  ViewController.swift
//  ExchangeRate
//
//  Created by Paul Ive on 09.12.22.
//

import UIKit



class FavoritesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var constants = Constants()
    var valutes = [String : Valutes]()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        FetchRequest.currencyRequest { valutes in
            self.valutes = valutes
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return constants.favoritesKeys.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell") as! FavoriteViewCell
        
//        let key = favoritesArray[indexPath.row]
        let key2 = constants.favoritesKeys[indexPath.row]
        let value = self.valutes[key2]
        guard let values = value else { return cell }
        cell.setUpFavoriteCell(valutes: values, key: key2)
        return cell
    }
    
    
}


