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
    
    var valutes = [String : Valutes]()
    var changedValue: String?
    
    
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(textDidChange), name: NSNotification.Name(rawValue: "textDidChange"), object: nil)
        
        
        
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
