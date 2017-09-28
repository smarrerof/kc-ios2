//
//  ShopsViewController+TableView.swift
//  MadridShops
//
//  Created by Sergio Marrero Fernandez on 9/28/17.
//  Copyright © 2017 Sergio Marrero. All rights reserved.
//

import UIKit

extension ShopsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let shopEntity: ShopEntity = self.entities.fetchedResultsController.object(at: indexPath)
        
        self.performSegue(withIdentifier: "ShowShopDetailSegue", sender: shopEntity)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = self.entities.fetchedResultsController.sections![section]
        
        return sectionInfo.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ShopCell = shopsTableView.dequeueReusableCell(withIdentifier: "ShopCell", for: indexPath) as! ShopCell
        let shopEntity: ShopEntity = self.entities.fetchedResultsController.object(at: indexPath)
        
        cell.refresh(shop: mapShopEntityIntoShop(shopEntity: shopEntity))
        
        return cell
    }
}
