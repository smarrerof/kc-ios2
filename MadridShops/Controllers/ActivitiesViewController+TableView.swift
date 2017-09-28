//
//  ActivitiesViewController+TableView.swift
//  MadridShops
//
//  Created by Sergio Marrero Fernandez on 9/28/17.
//  Copyright © 2017 Sergio Marrero. All rights reserved.
//

import UIKit

extension ActivitiesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let activityEntity: ActivityEntity = self.fetchedResultsController.object(at: indexPath)
        
        self.performSegue(withIdentifier: "ShowActivityDetailSegue", sender: activityEntity)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = fetchedResultsController.sections![section]
        
        return sectionInfo.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ActivityCell = activitiesTableView.dequeueReusableCell(withIdentifier: "ActivityCell", for: indexPath) as! ActivityCell
        let activityEntity: ActivityEntity = fetchedResultsController.object(at: indexPath)
        
        cell.refresh(activity: mapActivityEntityIntoActivity(activityEntity: activityEntity))
        
        return cell
    }
}
