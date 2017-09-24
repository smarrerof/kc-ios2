//
//  ShopDetailViewController.swift
//  MadridShops
//
//  Created by Sergio Marrero Fernandez on 9/23/17.
//  Copyright © 2017 Sergio Marrero. All rights reserved.
//

import UIKit

class ShopDetailViewController: UIViewController {

    @IBOutlet weak var imageImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var openingHoursLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    var shop: Shop!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = shop.name
        //self.shop.image.loadImage(into: self.imageImageView)
        if let imageData = shop.imageData {
            self.imageImageView.image = UIImage(data: imageData)
        }
        self.nameLabel.text = self.shop.name
        self.infoLabel.text = self.shop.info
        self.infoLabel.sizeToFit()
        self.openingHoursLabel.text = self.shop.openingHours
        self.addressLabel.text = self.shop.address
    }
}
