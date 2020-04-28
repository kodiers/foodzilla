//
//  DetailVC.swift
//  foodzilla
//
//  Created by Viktor Yamchinov on 28.04.2020.
//  Copyright © 2020 Viktor Yamchinov. All rights reserved.
//

import UIKit

class DetailVC: UIViewController {

    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemNameLbl: UILabel!
    @IBOutlet weak var itemPriceLbl: UILabel!
    @IBOutlet weak var uglyAdView: UIView!
    @IBOutlet weak var buyItemBtn: UIButton!
    @IBOutlet weak var hideAddBtn: UIButton!
    
    public private(set) var item: Item!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        itemImageView.image = item.image
        itemNameLbl.text = item.name
        itemPriceLbl.text = String(describing: item.price)
        buyItemBtn.setTitle("Buy this item for $\(item.price)", for: .normal)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func buyBtnWasPressed(_ sender: Any) {
    }
    
    @IBAction func hideAdsWasPressed(_ sender: Any) {
    }
    
    @IBAction func closeBtnWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func initData(forItem item: Item) {
        self.item = item
       }
}
