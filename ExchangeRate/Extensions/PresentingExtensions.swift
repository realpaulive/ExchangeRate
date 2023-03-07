//
//  PresentingExtensions.swift
//  ExchangeRate
//
//  Created by Paul Ive on 28.02.23.
//

import Foundation
import UIKit

extension ValutesListViewController {
    func showYourself(from viewController: UIViewController) -> ValutesListViewController {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ValutesListViewController") as! ValutesListViewController
        
        switch viewController {
        case is FavoritesViewController:
            vc.isFromFavorites = true
        case is ConverterViewController:
            vc.isFromConverter = true
        default: break
        }
        
        if let sheet = vc.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.preferredCornerRadius = 22.0
            sheet.prefersGrabberVisible = false
        }
        return vc
    }
}

extension CurrencySheetViewController {
    func showYourself (from viewController: UIViewController, whithKey key: String) -> CurrencySheetViewController {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let sheetVC = storyboard.instantiateViewController(withIdentifier: "CurrencySheetView") as! CurrencySheetViewController
        sheetVC.key = key
        
        switch viewController {
        case is FavoritesViewController:
            sheetVC.isFromFavorites = true
        default: break
        }
        
        if let sheet = sheetVC.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.preferredCornerRadius = 22.0
            sheet.prefersGrabberVisible = true
        }
        return sheetVC
    }
}
