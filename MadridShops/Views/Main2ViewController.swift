//
//  Main2ViewController.swift
//  MadridShops
//
//  Created by Sergio Marrero Fernandez on 9/28/17.
//  Copyright © 2017 Sergio Marrero. All rights reserved.
//

import UIKit
import CoreData

class Main2ViewController: UIViewController {

    @IBOutlet weak var loadingActivityIndicatorView: UIActivityIndicatorView!
    @IBOutlet weak var shopsButton: UIButton!
    @IBOutlet weak var activitesButton: UIButton!
    
    @IBAction func shopsButtonTapped(_ sender: Any) {
        let viewController = Shops2ViewController<Shop, ShopEntity>(nibName: "Shops2ViewController", bundle: nil)
        viewController.context = self.context
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
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
        let alertController = UIAlertController(title: NSLocalizedString("NetworkErrorTitle", comment: "NetworkErrorTitle"), message:
            NSLocalizedString("NetworkErrorText", comment: "NetworkErrorText"), preferredStyle: UIAlertControllerStyle.alert)
        
        alertController.addAction(UIAlertAction(title: "Accept", style: UIAlertActionStyle.default, handler: nil))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowShopsSegue" {
            let shopsViewController = segue.destination as! ShopsViewController<Shop>
            shopsViewController.context = self.context
        }
    }

}
