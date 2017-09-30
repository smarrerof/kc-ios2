//
//  MainViewController.swift
//  MadridShops
//
//  Created by Sergio Marrero Fernandez on 9/19/17.
//  Copyright © 2017 Sergio Marrero. All rights reserved.
//

import UIKit
import CoreData

class MainViewController: UIViewController {

    @IBOutlet weak var refreshButton: UIBarButtonItem!
    @IBOutlet weak var loadingActivityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var viewShops: UIView!
    @IBOutlet weak var viewActivities: UIView!
    
    @IBAction func refreshButtonTapped(_ sender: Any) {
        self.startApp()
    }
    
    var context: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.startApp()
    }
    
    func startApp() {
        if isConnectedToNetwork() {
            ExecuteOnceInteractorImpl().execute(onceClosure: {
                self.setCachingUI()
                initializeShopsData()
            }) {
                self.setApplicationUI()
            }
        }
        else {
            showAlert()
            self.setNotConnectedUI()
        }
    }
    
    func initializeShopsData() {
        let downloadAllShopsInteractor = DownloadAllShopsInteractorNSUrlSessionImpl()
        downloadAllShopsInteractor.execute { (shops: Shops) in
            let saveAllShopsInteractor = SaveAllShopsInteractorImpl()
            saveAllShopsInteractor.execute(shops: shops, context: self.context, onSuccess: { (shops: Shops) in
                self.initializeActivitiesData()
            })
        }
    }
    
    func initializeActivitiesData() {
        let downloadAllActivitiesInteractor = DownloadAllActivitiesInteractorNSUrlSessionImpl()
        downloadAllActivitiesInteractor.execute { (activities: Activities) in
            let saveAllActivitiesInteractor = SaveAllActivitiesInteractorImpl()
            saveAllActivitiesInteractor.execute(activities: activities, context: self.context, onSuccess: { (activities: Activities) in
                SetExecutedOnceInteractorImpl().execute()
                self.setApplicationUI()
            })
        }
    }
    
    func setCachingUI() {
        self.navigationItem.rightBarButtonItem = nil
        loadingActivityIndicatorView.startAnimating()
        viewShops.isHidden = true
        viewActivities.isHidden = true
    }
    
    func setNotConnectedUI() {
        self.navigationItem.rightBarButtonItem = refreshButton
        loadingActivityIndicatorView.stopAnimating()
        viewShops.isHidden = true
        viewActivities.isHidden = true
    }
    
    func setApplicationUI() {
        self.navigationItem.rightBarButtonItem = nil
        loadingActivityIndicatorView.stopAnimating()
        viewShops.isHidden = false
        viewActivities.isHidden = false
    }
    
    func showAlert() {
        let alertController = UIAlertController(title: NSLocalizedString("NetworkErrorTitle", comment: "NetworkErrorTitle"), message:
            NSLocalizedString("NetworkErrorText", comment: "NetworkErrorText"), preferredStyle: UIAlertControllerStyle.alert)
        
        alertController.addAction(UIAlertAction(title: "Accept", style: UIAlertActionStyle.default, handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowEntityShopsSegue" {
            let entitiesViewController = segue.destination as! EntitiesViewController
            entitiesViewController.title = NSLocalizedString("EntityShopsViewControllerTitle", comment: "EntityShopsViewControllerTitle")
            entitiesViewController.context = self.context
            entitiesViewController.entities = GetEntitiesFromCacheInteractorImpl<Entity>(key: "name", ascending: true, context: self.context, entityName: "ShopEntity")
        }
        if segue.identifier == "ShowEntityActivitiesSegue" {
            let entitiesViewController = segue.destination as! EntitiesViewController
            entitiesViewController.title = NSLocalizedString("EntityActivitiesViewControllerTitle", comment: "EntityActivitiesViewControllerTitle")
            entitiesViewController.context = self.context
            entitiesViewController.entities = GetEntitiesFromCacheInteractorImpl<Entity>(key: "name", ascending: true, context: self.context, entityName: "ActivityEntity")
        }
    }
}
