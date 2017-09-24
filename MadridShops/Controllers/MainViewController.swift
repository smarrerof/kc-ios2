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

    @IBOutlet weak var loadingActivityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var shopsButton: UIButton!
    
    var context: NSManagedObjectContext!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ExecuteOnceInteractorImpl().execute(onceClosure: {
            initializeShopsData()
        }) {
            updateUI()
        }
    }
    
    func initializeShopsData() {
        let downloadAllShopsInteractor = DownloadAllShopsInteractorNSUrlSessionImpl()
        downloadAllShopsInteractor.execute { (shops: Shops) in
            let saveAllShopsInteractor = SaveAllShopsInteractorImpl()
            saveAllShopsInteractor.execute(shops: shops, context: self.context, onSuccess: { (shops: Shops) in
                SetExecutedOnceInteractorImpl().execute()
                self.updateUI()
            })
        }
    }
    
    func updateUI() {
        loadingActivityIndicatorView.stopAnimating()
        shopsButton.isEnabled = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowShopsSegue" {
            let shopsViewController = segue.destination as! ShopsViewController
            shopsViewController.context = self.context
        }
    }
}
