//
//  ShopCell.swift
//  MadridShops
//
//  Created by Sergio Marrero Fernandez on 9/21/17.
//  Copyright © 2017 Sergio Marrero. All rights reserved.
//

import UIKit

class ShopCell: UITableViewCell {
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var shop: Shop?
    
    func refresh(shop: Shop) {
        self.shop = shop
        
        self.shop?.logo.loadImage(into: logoImageView)
        self.nameLabel.text = shop.name
    }
}
