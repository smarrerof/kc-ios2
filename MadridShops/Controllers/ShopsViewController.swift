//
//  ShopsViewController.swift
//  MadridShops
//
//  Created by Sergio Marrero Fernandez on 9/21/17.
//  Copyright © 2017 Sergio Marrero. All rights reserved.
//

import UIKit
import CoreData
import MapKit

class ShopsViewController: UIViewController {

    @IBOutlet weak var shopsMapView: MKMapView!
    @IBOutlet weak var shopsTableView: UITableView!
    
    var context: NSManagedObjectContext!
    let locationManager = CLLocationManager()
    var entities: GetEntitiesFromCacheInteractorImpl<ShopEntity>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = NSLocalizedString("ShopsViewControllerTitle", comment: "ShopsViewControllerTitle")
        
        // Data factory to get entities from cache
        self.entities = GetEntitiesFromCacheInteractorImpl<ShopEntity>(key: "name", ascending: true, context: self.context, entityName: "ShopEntity")
        
        // GPS access from user
        self.locationManager.requestWhenInUseAuthorization()
        
        // Set shopsTableView delegates to display shop list
        self.shopsTableView.delegate = self
        self.shopsTableView.dataSource = self
        
        // Map behaviour
        
        // Center map
        let madridLocation = CLLocation(latitude:40.41889 , longitude: -3.69194)
        self.shopsMapView.setCenter(madridLocation.coordinate, animated: true)
        
        // Set region 
        let coordinateRegion = MKCoordinateRegion(center: madridLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
        let regionThatFits = self.shopsMapView.regionThatFits(coordinateRegion)
        self.shopsMapView.setRegion(regionThatFits, animated: true)
        
        // Add map annotations
        self.shopsMapView.delegate = self
        if let fetchedObjects = self.entities.fetchedResultsController.fetchedObjects {
            for shopEntity in fetchedObjects {
                let shopAnnotation = ShopAnnotation(shopEntity: shopEntity)
                self.shopsMapView.addAnnotation(shopAnnotation)
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowShopDetailSegue" {
            let shopDetailViewController = segue.destination as! ShopDetailViewController
            
            let shopEntity: ShopEntity = sender as! ShopEntity
            shopDetailViewController.shop = mapShopEntityIntoShop(shopEntity: shopEntity)
        }
    }
}
