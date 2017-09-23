//
//  ShopsViewController.swift
//  MadridShops
//
//  Created by Sergio Marrero Fernandez on 9/21/17.
//  Copyright © 2017 Sergio Marrero. All rights reserved.
//

import UIKit
import CoreData

class ShopsViewController: UIViewController {

    @IBOutlet weak var shopsTableView: UITableView!
    
    var context: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ExecuteOnceInteractorImpl().execute {
            initializeData()
        }
        
        self.shopsTableView.delegate = self
        self.shopsTableView.dataSource = self
    }
    
    func initializeData() {
        let downloadAllShopsInteractor = DownloadAllShopsInteractorNSUrlSessionImpl()
        downloadAllShopsInteractor.execute { (shops: Shops) in
            let saveAllShopsInteractor = SaveAllShopsInteractorImpl()
            saveAllShopsInteractor.execute(shops: shops, context: self.context, onSuccess: { (shops: Shops) in
                SetExecutedOnceInteractorImpl().execute()
                
                self._fetchedResultsController = nil
                self.shopsTableView.delegate = self
                self.shopsTableView.dataSource = self
                self.shopsTableView.reloadData()
            })
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let shopEntity: ShopEntity = self.fetchedResultsController.object(at: indexPath)
        self.performSegue(withIdentifier: "ShowShopDetailSegue" , sender: shopEntity)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowShopDetailSegue" {
            let shopDetailViewController = segue.destination as! ShopDetailViewController
            
            let shopEntity: ShopEntity = sender as! ShopEntity
            shopDetailViewController.shop = mapShopEntityIntoShop(shopEntity: shopEntity)
        }
    }
    
    // MARK: - Fetched results controller
    var _fetchedResultsController: NSFetchedResultsController<ShopEntity>? = nil
    
    var fetchedResultsController: NSFetchedResultsController<ShopEntity> {
        if (_fetchedResultsController != nil) {
            return _fetchedResultsController!
        }
        
        let fetchRequest: NSFetchRequest<ShopEntity> = ShopEntity.fetchRequest()
        
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
}

extension ShopsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        /*if let shops = self.shops {
            return shops.count()
        }
        return 0*/
        
        let sectionInfo = fetchedResultsController.sections![section]
        return sectionInfo.numberOfObjects
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /*let cell: ShopCell = shopsTableView.dequeueReusableCell(withIdentifier: "ShopCell", for: indexPath) as! ShopCell
        let shop: Shop = (self.shops?.get(index: indexPath.row))!
        cell.refresh(shop: shop)
        return cell*/
        let cell: ShopCell = shopsTableView.dequeueReusableCell(withIdentifier: "ShopCell", for: indexPath) as! ShopCell
        let shopEntity: ShopEntity = fetchedResultsController.object(at: indexPath)
        cell.refresh(shop: mapShopEntityIntoShop(shopEntity: shopEntity))
        return cell
    }
}
