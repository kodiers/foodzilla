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
    private var hiddenStatus: Bool = UserDefaults.standard.bool(forKey: "nonConsumablePurchaseWasMade")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        itemImageView.image = item.image
        itemNameLbl.text = item.name
        itemPriceLbl.text = String(describing: item.price)
        buyItemBtn.setTitle("Buy this item for $\(item.price)", for: .normal)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handlePurchase(_:)), name: NSNotification.Name(IAPServicePurchaseNotification), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleFailure), name: NSNotification.Name(IAPServiceFailureNotification), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        showOrHideAds()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @objc func handlePurchase(_ notification: Notification) {
        guard let productId = notification.object as? String else { return }
        switch productId {
        case IAP_MEAL_ID:
            buyItemBtn.isEnabled = true
            debugPrint("meal purchased")
            break
        case IAP_HID_ADS_ID:
            uglyAdView.isHidden = true
            hideAddBtn.isHidden = true
            break
        default:
            break
        }
    }
    
    @objc func handleFailure() {
        buyItemBtn.isEnabled = true
        debugPrint("Purchase failed")
    }
    
    func showOrHideAds() {
        uglyAdView.isHidden = hiddenStatus
        hideAddBtn.isHidden = hiddenStatus
    }

    @IBAction func buyBtnWasPressed(_ sender: Any) {
        buyItemBtn.isEnabled = false
        IAPService.instance.attemptPurchaseForItemWith(productIndex: .meal)
    }
    
    @IBAction func hideAdsWasPressed(_ sender: Any) {
        hideAddBtn.isEnabled = false
        IAPService.instance.attemptPurchaseForItemWith(productIndex: .hideAds)
    }
    
    @IBAction func closeBtnWasPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    func initData(forItem item: Item) {
        self.item = item
       }
}
