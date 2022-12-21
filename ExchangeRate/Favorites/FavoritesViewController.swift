//
//  ViewController.swift
//  ExchangeRate
//
//  Created by Paul Ive on 09.12.22.
//

import UIKit



class FavoritesViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var favoritesArray = ["USD"]
    
    let updatedCurrencies = UpdateCurrencies.shared
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.reloadData()
       
    }


}

extension FavoritesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell") as! FavoriteViewCell
        
        let key = favoritesArray[indexPath.row]
        let value = updatedCurrencies.valutes[key]
        guard let values = value else { return cell }
        cell.setUpFavoriteCell(valutes: values, key: key)
        return cell
    }
    
    
}


