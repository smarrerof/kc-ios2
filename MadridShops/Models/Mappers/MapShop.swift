//
//  MapShop.swift
//  MadridShops
//
//  Created by Sergio Marrero Fernandez on 9/22/17.
//  Copyright © 2017 Sergio Marrero. All rights reserved.
//

import CoreData

func mapShopIntoShopEntity(context: NSManagedObjectContext, shop: Shop) -> ShopEntity {
    let shopEntity = ShopEntity(context: context)
    
    shopEntity.name = shop.name
    shopEntity.address = shop.address
    shopEntity.info = shop.info
    shopEntity.latitude = shop.latitude ?? 0.0
    shopEntity.longitude = shop.longitude ?? 0.0
    shopEntity.logo = shop.logo
    shopEntity.logoData = shop.logoData
    shopEntity.image = shop.image
    shopEntity.imageData = shop.imageData
    shopEntity.openingHours = shop.openingHours
    shopEntity.mapData = shop.mapData

    return shopEntity
}

func mapShopEntityIntoShop(shopEntity: ShopEntity) -> Shop {
    let shop = Shop(name: shopEntity.name ?? "", address: shopEntity.address ?? "")

    shop.info = shopEntity.info ?? ""
    shop.latitude = shopEntity.latitude
    shop.longitude = shopEntity.longitude
    shop.logo = shopEntity.logo ?? ""
    shop.logoData = shopEntity.logoData
    shop.image = shopEntity.image ?? ""
    shop.imageData = shopEntity.imageData
    shop.openingHours = shopEntity.openingHours ?? ""
    shop.mapData = shopEntity.mapData
    
    return shop
}
