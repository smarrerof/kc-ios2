//
//  EntityCell.swift
//  MadridShops
//
//  Created by Sergio Marrero Fernandez on 9/29/17.
//  Copyright © 2017 Sergio Marrero. All rights reserved.
//

import UIKit

class EntityCell: UITableViewCell {
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var openingHoursLabel: UILabel!
    
    var entity: EntityProtocol?
    
    func refresh(entity: EntityProtocol) {
        // Set cell backgroud
        let imageView = UIImageView(image: #imageLiteral(resourceName: "cell-background.png"))
        self.backgroundView = imageView
        
        // Set cell data
        self.entity = entity
        if let logoData = entity.logoData {
            self.logoImageView.image = UIImage(data: logoData)
        }
        self.nameLabel.text = entity.name
        self.openingHoursLabel.text = entity.openingHours
    }
}
