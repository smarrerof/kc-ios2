//
//  ActivityCell.swift
//  MadridShops
//
//  Created by Sergio Marrero Fernandez on 9/28/17.
//  Copyright © 2017 Sergio Marrero. All rights reserved.
//

import UIKit

class ActivityCell: UITableViewCell {
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var openingHoursLabel: UILabel!
    
    var activity: Activity?
    
    func refresh(activity: Activity) {
        self.activity = activity
        if let logoData = activity.logoData {
            self.logoImageView.image = UIImage(data: logoData)
        }
        self.nameLabel.text = activity.name
        self.openingHoursLabel.text = activity.openingHours
    }
}
