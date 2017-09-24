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
        
        if isConnectedToNetwork() {
            ExecuteOnceInteractorImpl().execute(onceClosure: {
                initializeShopsData()
            }) {
                updateUI()
            }
        }
        else {
            showAlert()
            loadingActivityIndicatorView.stopAnimating()
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
    
    func showAlert() {
        let alertController = UIAlertController(title: "Ups, algo fue mal", message:
            "Parece que no hay conectividad a internet. Cierra la aplicación y vuelve a lanzarla cuando se hay solucionado el problema. ", preferredStyle: UIAlertControllerStyle.alert)
        
        alertController.addAction(UIAlertAction(title: "Accept", style: UIAlertActionStyle.default, handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowShopsSegue" {
            let shopsViewController = segue.destination as! ShopsViewController
            shopsViewController.context = self.context
        }
    }
}
