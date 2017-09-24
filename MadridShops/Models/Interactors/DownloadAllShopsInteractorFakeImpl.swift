//
//  DownloadAllShopsInteractorFakeImpl.swift
//  MadridShops
//
//  Created by Sergio Marrero Fernandez on 9/19/17.
//  Copyright © 2017 Sergio Marrero. All rights reserved.
//

import Foundation

final class DownloadAllShopsInteractorFakeImpl: DownloadAllShopsInteractor {
    func execute(onSuccess: @escaping shopsSuccessClosure) {
        execute(onSuccess: onSuccess, onError: nil)
    }
    
    func execute(onSuccess: @escaping shopsSuccessClosure, onError: errorClosure = nil) {
        let shops = Shops()
        
        for i in 1...100 {
            let shop = Shop(name: "Shop \( i )", address: "Address \( i )")
            shop.logo = "https://lorempixel.com/100/100/"
            shop.image = "https://lorempixel.com/800/600"
            shop.info = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed condimentum nibh ex, ut tristique ex iaculis sed. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed magna turpis, pharetra ac malesuada nec, pulvinar rutrum lorem. Aliquam massa tellus, molestie in convallis ac, vehicula non quam. Etiam ut accumsan sapien. Quisque sollicitudin quam et velit rutrum, id placerat purus eleifend. Nullam a consectetur eros. Ut volutpat lacus sed fringilla facilisis. Etiam interdum velit nec sapien lacinia, id eleifend neque dictum."
            shop.openingHours = "Monday to Saturday from 10:00 to 22:00"
            
            if let url = URL(string: shop.logo), let logoData = NSData(contentsOf: url) {
                shop.logoData = logoData as Data
            }
            if let url = URL(string: shop.image), let imageData = NSData(contentsOf: url) {
                shop.imageData = imageData as Data
            }
            
            shops.add(shop: shop)
        }
        
        OperationQueue.main.addOperation {
            onSuccess(shops)
        }
    }
}
