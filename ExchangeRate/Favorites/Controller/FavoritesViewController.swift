//
//  ViewController.swift
//  ExchangeRate
//
//  Created by Paul Ive on 09.12.22.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    // MARK: - Values
    
    var valutes = [String : Valutes]()
    
    // MARK: - Outlets
    
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(loadList), name: NSNotification.Name(rawValue: "load"), object: nil)
        
        FetchRequest.currencyRequest { valutes in
            self.valutes = valutes
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.collectionView.reloadData()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.collectionView.reloadData()
    }
    
    // MARK: - Methods

    @objc func loadList(notification: NSNotification){
        //load data here
        self.collectionView.reloadData()
    }
    
    // MARK: - Actions
    
    @IBAction func prefrensesAction(_ sender: Any) {
        self.collectionView.reloadData()
    }
}

// MARK: - Extensions: Delegate, DataSourse

extension FavoritesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Constants.favoritesKeys.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FavoriteCell", for: indexPath) as! FavoriteViewCell
        
        let key2 = Constants.favoritesKeys[indexPath.row]
        let value = self.valutes[key2]
        guard let values = value else { return cell }
        cell.setUpFavoriteCell(valutes: values, key: key2)
        cell.backgroundColor = UIColor(named: "LightGray")
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
        let image = UIImage(named: imageName)
        let itemProvider = NSItemProvider(object: imageName as NSItemProviderWriting)
        let dragItem = UIDragItem(itemProvider: itemProvider)
        dragItem.localObject = imageName
        return dragItem
    }
}
