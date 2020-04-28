//
//  StorefrontVC.swift
//  foodzilla
//
//  Created by Viktor Yamchinov on 24.04.2020.
//  Copyright © 2020 Viktor Yamchinov. All rights reserved.
//

import UIKit

class StorefrontVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    @IBAction func restoreBtnWasPressed(_ sender: Any) {
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
    
}

