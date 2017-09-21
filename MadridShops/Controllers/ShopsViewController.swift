//
//  ShopsViewController.swift
//  MadridShops
//
//  Created by Sergio Marrero Fernandez on 9/21/17.
//  Copyright © 2017 Sergio Marrero. All rights reserved.
//

import UIKit

class ShopsViewController: UIViewController {

    @IBOutlet weak var shopsTableView: UITableView!
    
    var shops: Shops?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initializeData()
    }
    
    func initializeData() {
        let interactor = DownloadAllShopsInteractorFakeImpl()
        interactor.execute { (shops: Shops) in
            self.shops = shops

            self.shopsTableView.delegate = self
            self.shopsTableView.dataSource = self
        }
    }
}

extension ShopsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let shops = self.shops {
            return shops.count()
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ShopCell = shopsTableView.dequeueReusableCell(withIdentifier: "ShopCell", for: indexPath) as! ShopCell
        let shop: Shop = (self.shops?.get(index: indexPath.row))!
        cell.refresh(shop: shop)
        return cell
    }
}
