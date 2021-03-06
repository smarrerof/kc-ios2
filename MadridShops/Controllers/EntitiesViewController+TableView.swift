//
//  EntitiesViewController+TableView.swift
//  MadridShops
//
//  Created by Sergio Marrero Fernandez on 9/29/17.
//  Copyright © 2017 Sergio Marrero. All rights reserved.
//

import UIKit

extension EntitiesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let entity: Entity = self.entities.fetchedResultsController.object(at: indexPath)
        
        self.performSegue(withIdentifier: "ShowEntityDetailSegue", sender: entity)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = self.entities.fetchedResultsController.sections![section]
        
        return sectionInfo.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: EntityCell = tableView.dequeueReusableCell(withIdentifier: "EntityCell", for: indexPath) as! EntityCell
        let entity: Entity = self.entities.fetchedResultsController.object(at: indexPath)
        
        cell.refresh(entity: entity)
        
        return cell
    }
}
