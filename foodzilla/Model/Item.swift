//
//  Item.swift
//  foodzilla
//
//  Created by Viktor Yamchinov on 29.04.2020.
//  Copyright © 2020 Viktor Yamchinov. All rights reserved.
//

import UIKit

class Item {
    
    public private(set) var image: UIImage
    public private(set) var name: String
    public private(set) var price: Double
    
    init(image: UIImage, name: String, price: Double) {
        self.image = image
        self.name = name
        self.price = price
    }
    
}
