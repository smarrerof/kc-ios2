//
//  ActivityDetailViewController.swift
//  MadridShops
//
//  Created by Sergio Marrero Fernandez on 9/28/17.
//  Copyright © 2017 Sergio Marrero. All rights reserved.
//

import UIKit

class ActivityDetailViewController: UIViewController {
    
    @IBOutlet weak var imageImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var openingHoursLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    
    var activity: Activity!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = activity.name
        if let mapData = activity.mapData {
            self.imageImageView.image = UIImage(data: mapData)
        } else if let imageData = activity.imageData {
            self.imageImageView.image = UIImage(data: imageData)
        }
        self.nameLabel.text = self.activity.name
        self.infoLabel.text = self.activity.info
        self.infoLabel.sizeToFit()
        self.openingHoursLabel.text = self.activity.openingHours
        self.addressLabel.text = self.activity.address
    }
}
