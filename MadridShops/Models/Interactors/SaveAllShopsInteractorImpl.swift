//
//  SaveAllShopsInteractorImpl.swift
//  MadridShops
//
//  Created by Sergio Marrero Fernandez on 9/22/17.
//  Copyright © 2017 Sergio Marrero. All rights reserved.
//

import CoreData

class SaveAllShopsInteractorImpl: SaveAllShopsInteractor {
    func execute(shops: Shops, context: NSManagedObjectContext, onSuccess: @escaping shopsSuccessClosure) {
        execute(shops: shops, context: context, onSuccess: onSuccess, onError: nil)
    }
    
    func execute(shops: Shops, context: NSManagedObjectContext, onSuccess: @escaping shopsSuccessClosure, onError: errorClosure) {
        for i in 0 ..< shops.count() {
            let shop = shops.get(index: i)
            // Download logo
            // Download image
            let _ = mapShopIntoShopEntity(context: context, shop: shop)
        }
        
        do {
            try context.save()
            onSuccess(shops)
        } catch {
            // TODO: Error handling
        }
    }
}
