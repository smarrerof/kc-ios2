//
//  EntityDetailViewController.swift
//  MadridShops
//
//  Created by Sergio Marrero Fernandez on 9/29/17.
//  Copyright © 2017 Sergio Marrero. All rights reserved.
//

import UIKit

class EntityDetailViewController: UIViewController {
    
    @IBOutlet weak var imageImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var openingHoursLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    var model: Model!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = model.name
        if let mapData = model.mapData {
            self.imageImageView.image = UIImage(data: mapData)
        } else if let imageData = model.imageData {
            self.imageImageView.image = UIImage(data: imageData)
        }
        self.nameLabel.text = self.model.name
        self.infoLabel.text = self.model.info
        self.infoLabel.sizeToFit()
        self.openingHoursLabel.text = self.model.openingHours
        self.addressLabel.text = self.model.address
    }
}
