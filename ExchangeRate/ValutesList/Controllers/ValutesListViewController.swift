//
//  ValutesListViewController.swift
//  ExchangeRate
//
//  Created by Paul Ive on 29.01.23.
//

import UIKit
import SkeletonView

final class ValutesListViewController: UIViewController {
    
    // MARK: - Values
    
    var isFromFavorites = false
    var isFromConverter = false
    var valutes = [String : Valutes]()
    
    // MARK: - Outlets
    
    @IBOutlet weak var valutesList: UITableView! {
        didSet {
            valutesList.delegate = self
            valutesList.dataSource = self
        }
    }
    
    // MARK: - ViewMethods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        valutesList.isSkeletonable = true
        valutesList.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: UIColor(named: "Skeletonable")!), transition: .crossDissolve(0.4))
        
        FetchRequest.shared.currencyRequest { [unowned self] valutes, _ in
            DispatchQueue.main.async {
                self.valutes = valutes
                self.valutesList.hideSkeleton(transition: .crossDissolve(0.4))
                self.valutesList.reloadData()
            }
        }
    }
    
    // MARK: - Actions
    
    @IBAction func dismissButtonAction (_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}

// MARK: - Extensions: SheetPresentationDelegates

extension ValutesListViewController: UISheetPresentationControllerDelegate {
    override var sheetPresentationController: UISheetPresentationController? {
        presentationController as? UISheetPresentationController
    }
}
