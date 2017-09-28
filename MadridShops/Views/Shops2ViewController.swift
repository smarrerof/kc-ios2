//
//  Shops2ViewController.swift
//  MadridShops
//
//  Created by Sergio Marrero Fernandez on 9/28/17.
//  Copyright © 2017 Sergio Marrero. All rights reserved.
//

import UIKit
import CoreData
import MapKit

class Shops2ViewController<TModel, TEntity>: UIViewController where TModel: BaseModel, TEntity: NSManagedObject, TEntity: BaseEntity {
    @IBOutlet weak var shopsMapView: MKMapView!
    @IBOutlet weak var shopsTableView: UITableView!
    
    var context: NSManagedObjectContext!
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = NSLocalizedString("ShopsViewControllerTitle", comment: "ShopsViewControllerTitle")
        
        // Create fetch result
        let fetch = Shops2Fetch<TEntity>(context: self.context)
        
        // GPS access from user
        self.locationManager.requestWhenInUseAuthorization()
        
        // Set shopsTableView delegates to display shop list
        self.shopsTableView.register(UINib(nibName: "Shop2ViewCell", bundle: nil), forCellReuseIdentifier: "Shop2Cell")
        let k = Shops2TableView<TEntity>(viewController: self, fetch: fetch, shopsTableView: self.shopsTableView)
        self.shopsTableView.delegate = k
        self.shopsTableView.dataSource = k
        
        
        // Map behaviour
        
        // Center map
        let madridLocation = CLLocation(latitude:40.41889 , longitude: -3.69194)
        self.shopsMapView.setCenter(madridLocation.coordinate, animated: true)
        
        // Set region
        let coordinateRegion = MKCoordinateRegion(center: madridLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 1, longitudeDelta: 1))
        let regionThatFits = self.shopsMapView.regionThatFits(coordinateRegion)
        self.shopsMapView.setRegion(regionThatFits, animated: true)
        
        // Add map annotations
        let l = Shops2Map<TEntity>(viewController: self)
        self.shopsMapView.delegate = l
        if let fetchedObjects = fetch.fetchedResultsController.fetchedObjects {
            for entity in fetchedObjects {
                let shopAnnotation = Shop2Annotation(shopEntity: entity)
                self.shopsMapView.addAnnotation(shopAnnotation)
            }
        }
        
    }
    
    /*override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowShopDetailSegue" {
            let shopDetailViewController = segue.destination as! ShopDetailViewController
            
            let shopEntity: ShopEntity = sender as! ShopEntity
            shopDetailViewController.shop = mapShopEntityIntoShop(shopEntity: shopEntity)
        }
    }*/
}

class Shops2Fetch<TEntity>: NSObject where TEntity: NSManagedObject, TEntity: BaseEntity {
    var context: NSManagedObjectContext!
    var _fetchedResultsController: NSFetchedResultsController<TEntity>? = nil

    init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    // MARK: - Fetched results controller
    var fetchedResultsController: NSFetchedResultsController<TEntity> {
        if (_fetchedResultsController != nil) {
            return _fetchedResultsController!
        }
        
        let fetchRequest = NSFetchRequest<TEntity>(entityName: TEntity.entityName)
        
        // Set the batch size to a suitable number.
        fetchRequest.fetchBatchSize = 20
        fetchRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        // fetchRequest == SELECT * FROM shops ORDER BY name ASC
        _fetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.context!, sectionNameKeyPath: nil, cacheName: "ShopsCacheFile")
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
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class Shops2TableView<TEntity>: NSObject, UITableViewDelegate, UITableViewDataSource where TEntity: NSManagedObject, TEntity: BaseEntity {
    var viewController: UIViewController
    var fetch: Shops2Fetch<TEntity>
    var shopsTableView: UITableView
    
    init(viewController: UIViewController, fetch: Shops2Fetch<TEntity>, shopsTableView: UITableView) {
        self.viewController = viewController
        self.fetch = fetch
        self.shopsTableView = shopsTableView
    }
    
    // MARK: - tableView
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let shopEntity: ShopEntity = self.fetch.fetchedResultsController.object(at: indexPath) as! ShopEntity
        
        //self.performSegue(withIdentifier: "ShowShopDetailSegue" , sender: shopEntity)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = self.fetch.fetchedResultsController.sections![section]
        
        return sectionInfo.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: Shop2ViewCell = shopsTableView.dequeueReusableCell(withIdentifier: "Shop2Cell", for: indexPath) as! Shop2ViewCell
        let shopEntity: ShopEntity = self.fetch.fetchedResultsController.object(at: indexPath) as! ShopEntity
        
        cell.refresh(shop: mapShopEntityIntoShop(shopEntity: shopEntity))
        
        return cell
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class Shops2Map<TEntity>: NSObject, MKMapViewDelegate where TEntity: NSManagedObject, TEntity: BaseEntity {
    var viewController: UIViewController
    
    init(viewController: UIViewController) {
        self.viewController = viewController
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? Shop2Annotation<TEntity> else { return nil }
        
        let identifier = "marker"
        var view: MKPinAnnotationView
        if let dequeuedView = mapView.dequeueReusableAnnotationView(withIdentifier: identifier) as? MKPinAnnotationView {
            dequeuedView.annotation = annotation
            view = dequeuedView
        } else {
            view = MKPinAnnotationView(annotation: annotation, reuseIdentifier: identifier)
            view.canShowCallout = true
            view.calloutOffset = CGPoint(x: -5, y: 5)
            view.isUserInteractionEnabled = true
            
            if let logoData = annotation.shopEntity.logoData {
                let mapsButtom = UIButton(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 30, height: 30)))
                mapsButtom.setBackgroundImage(UIImage(data: logoData), for: UIControlState())
                view.rightCalloutAccessoryView = mapsButtom
            } else {
                view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            }
        }
        return view
    }
    
    /*func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if let annotation = view.annotation as? ShopAnnotation  {
            self.performSegue(withIdentifier: "ShowShopDetailSegue" , sender: annotation.shopEntity)
        }
    }*/
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(calloutTapped))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        view.addGestureRecognizer(tapGesture)
    }
    
    func mapView(_ mapView: MKMapView, didDeselect view: MKAnnotationView) {
        print("didDeselect")
        
        view.gestureRecognizers?.removeAll()
    }
    
    @objc func calloutTapped(sender: UITapGestureRecognizer) {
        if let view = sender.view as? MKPinAnnotationView, let annotation = view.annotation as? Shop2Annotation<TEntity> {
            print("calloutTapped")
            /*self.performSegue(withIdentifier: "ShowShopDetailSegue" , sender: annotation.shopEntity)*/
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
