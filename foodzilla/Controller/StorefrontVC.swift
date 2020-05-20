//
//  StorefrontVC.swift
//  foodzilla
//
//  Created by Viktor Yamchinov on 24.04.2020.
//  Copyright © 2020 Viktor Yamchinov. All rights reserved.
//

import UIKit

class StorefrontVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource  {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var subscriptionStatusLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self
        
        IAPService.instance.delegate = self
        IAPService.instance.loadProducts()
        
        NotificationCenter.default.addObserver(self, selector: #selector(showAlert), name: NSNotification.Name(rawValue: IAPServiceRestoreNotification), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(subscriptionStatusWasChanged(_:)), name: NSNotification.Name(rawValue: IAPServiceSubsInfoChangedNotification), object: nil)
    }

    @IBAction func restoreBtnWasPressed(_ sender: Any) {
        let alertVC = UIAlertController(title: "Restore purchases?", message: "Do you want to restore purchases?", preferredStyle: .actionSheet)
        let action = UIAlertAction(title: "Restore", style: .default) { (action) in
            IAPService.instance.restorePurchases()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertVC.addAction(action)
        alertVC.addAction(cancel)
        present(alertVC, animated: true, completion: nil)
    }
    
    @IBAction func subscribeBtnPressed(_ sender: Any) {
        IAPService.instance.attemptPurchaseForItemWith(productIndex: .monthlySub)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return foodItems.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "itemCell", for: indexPath) as? ItemCell else {
            return UICollectionViewCell()
        }
        cell.configureCell(forItem: foodItems[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let detailVc = storyboard?.instantiateViewController(identifier: "detailVC") as? DetailVC else {
            return
        }
        detailVc.initData(forItem: foodItems[indexPath.row])
        present(detailVc, animated: true, completion: nil)
    }
    
    @objc func showAlert() {
        let alertVC = UIAlertController(title: "Success", message: "Your purchases restored", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertVC.addAction(action)
        present(alertVC, animated: true, completion: nil)
    }
    
    @objc func subscriptionStatusWasChanged(_ notification: Notification) {
        guard let status = notification.object as? Bool else { return }
        if status {
            // perform actions for actve subscriptions
        } else {
            // perform actions for expired
        }
    }
    
}


extension StorefrontVC: IAPServiceDelegate {
    
    func iapProductLoaded() {
        print("LOADED")
    }
    
    
}
