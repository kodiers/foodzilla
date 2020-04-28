//
//  ItemCell.swift
//  foodzilla
//
//  Created by Viktor Yamchinov on 29.04.2020.
//  Copyright © 2020 Viktor Yamchinov. All rights reserved.
//

import UIKit

class ItemCell: UICollectionViewCell {
    
    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemNameLbl: UILabel!
    @IBOutlet weak var itemPriceLbl: UILabel!
    
    func configureCell(forItem item: Item) {
        itemImageView.image = item.image
        itemNameLbl.text = item.name
        itemPriceLbl.text = "\(item.price)"
    }
}
