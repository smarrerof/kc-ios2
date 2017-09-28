//
//  ActivitiesViewController.swift
//  MadridShops
//
//  Created by Sergio Marrero Fernandez on 9/28/17.
//  Copyright © 2017 Sergio Marrero. All rights reserved.
//

import UIKit
import CoreData
import MapKit

class ActivitiesViewController: UIViewController {
    
    @IBOutlet weak var activitiesMapView: MKMapView!
    @IBOutlet weak var activitiesTableView: UITableView!
    
    var context: NSManagedObjectContext!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = NSLocalizedString("ActivitiesViewControllerTitle", comment: "ActivitiesViewControllerTitle")
        
        // GPS access from user
        self.locationManager.requestWhenInUseAuthorization()
        
        // Set shopsTableView delegates to display shop list
        self.activitiesTableView.delegate = self
        self.activitiesTableView.dataSource = self
        
        // Map behaviour
        
        // Center map
        let madridLocation = CLLocation(latitude:40.41889 , longitude: -3.69194)
        self.activitiesMapView.setCenter(madridLocation.coordinate, animated: true)
        
        // Set region
        let coordinateRegion = MKCoordinateRegion(center: madridLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
        let regionThatFits = self.activitiesMapView.regionThatFits(coordinateRegion)
        self.activitiesMapView.setRegion(regionThatFits, animated: true)
        
        // Add map annotations
        self.activitiesMapView.delegate = self
        if let fetchedObjects = fetchedResultsController.fetchedObjects {
            for activityEntity in fetchedObjects {
                let activityAnnotation = ActivityAnnotation(activityEntity: activityEntity)
                self.activitiesMapView.addAnnotation(activityAnnotation)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowActivityDetailSegue" {
            let activityDetailViewController = segue.destination as! ActivityDetailViewController
            
            let activityEntity: ActivityEntity = sender as! ActivityEntity
            activityDetailViewController.activity = mapActivityEntityIntoActivity(activityEntity: activityEntity)
        }
    }
    
    // MARK: - Fetched results controller
    var _fetchedResultsController: NSFetchedResultsController<ActivityEntity>? = nil
    
    var fetchedResultsController: NSFetchedResultsController<ActivityEntity> {
        if (_fetchedResultsController != nil) {
            return _fetchedResultsController!
        }
        
        let fetchRequest: NSFetchRequest<ActivityEntity> = ActivityEntity.fetchRequest()
        
        // Set the batch size to a suitable number.
        fetchRequest.fetchBatchSize = 20
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        // fetchRequest == SELECT * FROM activities ORDER BY name ASC
        _fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.context!, sectionNameKeyPath: nil, cacheName: "ActivitiesCacheFile")
        // aFetchedResultsController.delegate = self
        
        do {
            try _fetchedResultsController!.performFetch()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
        return _fetchedResultsController!
    }
}
