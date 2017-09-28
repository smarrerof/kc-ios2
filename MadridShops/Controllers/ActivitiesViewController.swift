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

extension ActivitiesViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        guard let annotation = annotation as? ActivityAnnotation else { return nil }
        
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
            
            if let logoData = annotation.activityEntity.logoData {
                let mapsButtom = UIButton(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 30, height: 30)))
                mapsButtom.setBackgroundImage(UIImage(data: logoData), for: UIControlState())
                view.rightCalloutAccessoryView = mapsButtom
            } else {
                view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
            }
        }
        return view
    }
    
    func mapView(_ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
        if let annotation = view.annotation as? ActivityAnnotation  {
            self.performSegue(withIdentifier: "ShowActivityDetailSegue" , sender: annotation.activityEntity)
        }
    }
    
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
        if let view = sender.view as? MKPinAnnotationView, let annotation = view.annotation as? ActivityAnnotation {
            print("calloutTapped")
            self.performSegue(withIdentifier: "ShowActivityDetailSegue" , sender: annotation.activityEntity)
        }
    }
}

