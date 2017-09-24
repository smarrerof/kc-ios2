//
//  DownloadAllShopsInteractorNSUrlSessionImp.swift
//  MadridShops
//
//  Created by Sergio Marrero Fernandez on 9/23/17.
//  Copyright © 2017 Sergio Marrero. All rights reserved.
//

import Foundation

class DownloadAllShopsInteractorNSUrlSessionImpl: DownloadAllShopsInteractor {
    func execute(onSuccess: @escaping shopsSuccessClosure) {
        execute(onSuccess: onSuccess, onError: nil)
    }
    
    func execute(onSuccess: @escaping shopsSuccessClosure, onError: errorClosure = nil) {
        let urlString = "https://madrid-shops.com/json_new/getShops.php"
        
        let session = URLSession.shared
        if let url = URL(string: urlString) {
            let task = session.dataTask(with: url) { (data: Data?, response: URLResponse?, error: Error?) in
                let shops = parseShop(data: data!)
                
                // Download images (at this point we are in another thread, so, Thread.current != Thread.main)
                assert(Thread.current != Thread.main)
                for i in 0 ..< shops.count() {
                    let shop = shops.get(index: i)
                    if let url = URL(string: shop.logo), let logoData = NSData(contentsOf: url) {
                        shop.logoData = logoData as Data
                    } else {
                        print("\(shop.description), there was a problem problem with image \(shop.logo)")
                    }
                    
                    if let url = URL(string: shop.image), let imageData = NSData(contentsOf: url) {
                        shop.imageData = imageData as Data
                    } else {
                        print("\(shop.description), there was a problem problem with image \(shop.image))")
                    }
                    
                    // https://maps.googleapis.com/maps/api/staticmap?center=40.452048,-3.686463&zoom=17&size=375x150
                    let mapUrl = "https://maps.googleapis.com/maps/api/staticmap?center=\(shop.latitude!),\(shop.longitude!)&zoom=17&size=375x150"
                    if let url = URL(string: mapUrl), let mapData = NSData(contentsOf: url) {
                        shop.mapData = mapData as Data
                    } else {
                        print("\(shop.description), there was a problem problem with image \(mapUrl)")
                    }
                }
                
                // Return to main thread and call the onSuccess closure
                OperationQueue.main.addOperation {
                    assert(Thread.current == Thread.main)
                    if error == nil {
                        // OK
                        onSuccess(shops)
                    } else {
                        // ERROR
                        if let onError = onError {
                            onError(error!)
                        }
                    }
                }
            }
            task.resume()
        }
    }
}
