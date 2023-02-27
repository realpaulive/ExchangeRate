//
//  ViewController.swift
//  ExchangeRate
//
//  Created by Paul Ive on 09.12.22.
//

import UIKit
import SPAlert
import SkeletonView

class FavoritesViewController: UIViewController {
    
    // MARK: - Values
    
    private var valutes: [String : Valutes]?
    private let reusableCellIdentifier = "FavoriteCell"
    
    // MARK: - Outlets
    
    @IBOutlet weak var noValutesButton: UIButton!
    @IBOutlet weak var collectionView: UICollectionView! {
        didSet {
            collectionView.delegate = self
            collectionView.dataSource = self
            collectionView.dragDelegate = self
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
        
        FetchRequest.shared.currencyRequest { valutes in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                self.valutes = valutes
                self.collectionView.hideSkeleton(transition: .crossDissolve(0.4))
                self.collectionView.reloadData()
            }
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        hideNoValutesLabel()
        
    }
    
    // MARK: - Methods
    
    @objc private func reloadFavorites(notification: NSNotification){
        hideNoValutesLabel()
        self.collectionView.reloadData()
    }
    
    // MARK: - Actions
    
    
    @IBAction func noValutesButtonAction(_ sender: Any) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ValutesListViewController") as! ValutesListViewController
        vc.isFromFavorites = true
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.preferredCornerRadius = 22.0
            sheet.prefersGrabberVisible = false
        }
        self.present(vc, animated: true)
    }
    
    @IBAction func prefrensesAction(_ sender: Any) {
        
        let alertView = SPAlertView(title: "Connection error", preset: .error)
        alertView.layout.iconSize = CGSize(width: 24, height: 24)
        alertView.cornerRadius = 22
        alertView.duration = 1
        alertView.dismissInTime = true
        
        alertView.present()
        
        
    }
}

// MARK: - Extensions: Delegate, DataSourse

extension FavoritesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Constants.favoritesKeys.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reusableCellIdentifier, for: indexPath) as! FavoriteViewCell
        
        let key = Constants.favoritesKeys[indexPath.row]
        guard let value = self.valutes?[key] else { return cell }
        cell.setUpFavoriteCell(valutes: value, key: key)
//        cell.backgroundColor = UIColor(named: "LightGray")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let key = Constants.favoritesKeys[indexPath.row]
        
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let sheetVC = storyboard.instantiateViewController(withIdentifier: "CurrencySheetView") as! CurrencySheetViewController
        sheetVC.key = key
        sheetVC.isLastVCwasFavoriteVC = true
        if let sheet = sheetVC.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.preferredCornerRadius = 22.0
            sheet.prefersGrabberVisible = true
        }
        self.present(sheetVC, animated: true)
    }
}

// MARK: - Extensions: LayoutSettingUp

extension FavoritesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = self.view.frame.width - 32
        return CGSize(width: width, height: 64)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 8
    }
}

// MARK: - Extensions: DragDelegate

extension FavoritesViewController: UICollectionViewDragDelegate {
    func collectionView(_ collectionView: UICollectionView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        let dragItem = self.dragItem(forItemAt: indexPath)
        return [dragItem]
    }
    
    
    // Helper method
    private func dragItem(forItemAt indexPath: IndexPath) -> UIDragItem {
        let imageName = Constants.favoritesKeys[indexPath.row]
//        let image = UIImage(named: imageName)
        let itemProvider = NSItemProvider(object: imageName as NSItemProviderWriting)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = imageName
        return dragItem
    }
}

// MARK: - Extensions: BusinessLogic

extension FavoritesViewController {
    func hideNoValutesLabel() {
        if Constants.favoritesKeys != [] {
            self.noValutesButton.isHidden = true
        } else {
            self.noValutesButton.isHidden = false
        }
    }
}

// MARK: - Extension: RefreshControl

extension FavoritesViewController {
    var myRefreshControl: UIRefreshControl {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshValues(sender:)), for: .valueChanged)
        return refreshControl
    }
    
    @objc
    private func refreshValues(sender: UIRefreshControl) {
        self.valutes = nil
        self.collectionView.reloadData()
        self.collectionView.startSkeletonAnimation()
        self.collectionView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: UIColor(named: "Skeletonable")!), transition: .crossDissolve(0.4))
        
        FetchRequest.shared.currencyRequest { valutes in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                self.valutes = valutes
                self.collectionView.hideSkeleton(transition: .crossDissolve(0.4))
                self.collectionView.reloadData()
            }
        }
        
        sender.endRefreshing()
    }
}


// MARK: - Extension: SkeletonViewDataSourse

extension FavoritesViewController: SkeletonCollectionViewDataSource {
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> SkeletonView.ReusableCellIdentifier {
        return reusableCellIdentifier
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Constants.favoritesKeys.count
    }
    
    
}
