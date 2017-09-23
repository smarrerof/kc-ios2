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
                OperationQueue.main.addOperation {
                    assert(Thread.current == Thread.main)
                    if error == nil {
                        // OK
                        let shops = parseShop(data: data!)
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
