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
    var entities: GetEntitiesFromCacheInteractorImpl<ActivityEntity>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = NSLocalizedString("ActivitiesViewControllerTitle", comment: "ActivitiesViewControllerTitle")
        
        // Data factory to get entities from cache
        self.entities = GetEntitiesFromCacheInteractorImpl<ActivityEntity>(key: "name", ascending: true, context: self.context, entityName: "ActivityEntity")
        
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
        
        if let fetchedObjects = self.entities.fetchedResultsController.fetchedObjects {
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
}
