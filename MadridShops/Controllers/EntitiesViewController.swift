//
//  EventsViewController.swift
//  MadridShops
//
//  Created by Sergio Marrero Fernandez on 9/29/17.
//  Copyright © 2017 Sergio Marrero. All rights reserved.
//

import UIKit
import CoreData
import MapKit

class EntitiesViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var tableView: UITableView!
    
    var context: NSManagedObjectContext!
    let locationManager = CLLocationManager()
    var entities: GetEntitiesFromCacheInteractorImpl<Entity>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // GPS access from user
        self.locationManager.requestWhenInUseAuthorization()
        
        // Set shopsTableView delegates to display shop list
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        // Map behaviour
        
        // Center map
        let madridLocation = CLLocation(latitude:40.41889 , longitude: -3.69194)
        self.mapView.setCenter(madridLocation.coordinate, animated: true)
        
        // Set region
        let coordinateRegion = MKCoordinateRegion(center: madridLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
        let regionThatFits = self.mapView.regionThatFits(coordinateRegion)
        self.mapView.setRegion(regionThatFits, animated: true)
        
        // Add map annotations
        self.mapView.delegate = self
        
        if let fetchedObjects = self.entities.fetchedResultsController.fetchedObjects {
            for entity in fetchedObjects {
                let annotation = EntityAnnotation(entity: entity)
                self.mapView.addAnnotation(annotation)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowEntityDetailSegue" {
            let entityDetailViewController = segue.destination as! EntityDetailViewController
            
            let entity: Entity = sender as! Entity
            entityDetailViewController.model = mapEntityIntoModel(entity: entity)
        }
    }
}

