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
                    
                    shop.logoData = shop.logo.downloadImage()
                    shop.imageData = shop.image.downloadImage()

                    //let mapUrl = "https://maps.googleapis.com/maps/api/staticmap?center=\(shop.latitude!),\(shop.longitude!)&zoom=17&size=375x150"
                    //shop.mapData = mapUrl.downloadImage()
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
