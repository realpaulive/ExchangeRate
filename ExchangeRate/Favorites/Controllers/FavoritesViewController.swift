//
//  ViewController.swift
//  ExchangeRate
//
//  Created by Paul Ive on 09.12.22.
//

import UIKit
import SPAlert
import SkeletonView

final class FavoritesViewController: UIViewController {
    
    // MARK: - Values
    
    var valutes: [String : Valutes]?
    var lastUpdate: String?
    
    // MARK: - Outlets
    
    @IBOutlet weak var noValutesButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.dragInteractionEnabled = true
        }
    }
    
    // MARK: - ViewMethods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(reloadFavorites), name: NSNotification.Name(rawValue: "reloadFavorites"), object: nil)
        
    
        collectionView.refreshControl = myRefreshControl
        
        collectionView.isSkeletonable = true
        collectionView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: UIColor(named: "Skeletonable")!), transition: .crossDissolve(0.4))
        
        FetchRequest.shared.currencyRequest { [unowned self] valutes, timestamp in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.valutes = valutes
                self.lastUpdate = timestamp
                self.collectionView.hideSkeleton(transition: .crossDissolve(0.4))
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showOrHideLabels()
        
    }
    
    // MARK: - Methods
    
    @objc private func reloadFavorites(notification: NSNotification){
        showOrHideLabels()
        self.collectionView.reloadData()
    }
    
    // MARK: - Actions
    
    
    @IBAction func noValutesButtonAction(_ sender: Any) {
        let vc = ValutesListViewController().showYourself(from: self)
        self.present(vc, animated: true)
    }
    
    @IBAction func prefrensesAction(_ sender: Any) {
        let vc = ValutesListViewController().showYourself(from: self)
        self.present(vc, animated: true)
    }
}

// MARK: - Extensions: BusinessLogic

extension FavoritesViewController {
    func showOrHideLabels() {
        if Constants.favoritesKeys != [] {
            self.collectionView.isHidden = false
            self.noValutesButton.isHidden = true
        } else {
            self.collectionView.isHidden = true
            self.noValutesButton.isHidden = false
        }
    }
}


