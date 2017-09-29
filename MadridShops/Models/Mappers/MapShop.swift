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
    shopEntity.info_en = shop.info_en
    shopEntity.info_es = shop.info_es
    shopEntity.latitude = shop.latitude ?? 0.0
    shopEntity.longitude = shop.longitude ?? 0.0
    shopEntity.logo = shop.logo
    shopEntity.logoData = shop.logoData
    shopEntity.image = shop.image
    shopEntity.imageData = shop.imageData
    shopEntity.openingHours_en = shop.openingHours_en
    shopEntity.openingHours_es = shop.openingHours_es
    shopEntity.mapData = shop.mapData

    return shopEntity
}

func mapEntityIntoActivity(entity: BaseEntity) -> Shop {
    let shop = Shop(name: entity.name ?? "", address: entity.address ?? "")
    
    shop.info_en = entity.info_en ?? ""
    shop.info_es = entity.info_es ?? ""
    shop.latitude = entity.latitude
    shop.longitude = entity.longitude
    shop.logo = entity.logo ?? ""
    shop.logoData = entity.logoData
    shop.image = entity.image ?? ""
    shop.imageData = entity.imageData
    shop.openingHours_en = entity.openingHours_en ?? ""
    shop.openingHours_es = entity.openingHours_es ?? ""
    shop.mapData = entity.mapData
    
    return shop
}


func mapShopEntityIntoShop(shopEntity: ShopEntity) -> Shop {
    let shop = Shop(name: shopEntity.name ?? "", address: shopEntity.address ?? "")

    shop.info_en = shopEntity.info_en ?? ""
    shop.info_es = shopEntity.info_es ?? ""
    shop.latitude = shopEntity.latitude
    shop.longitude = shopEntity.longitude
    shop.logo = shopEntity.logo ?? ""
    shop.logoData = shopEntity.logoData
    shop.image = shopEntity.image ?? ""
    shop.imageData = shopEntity.imageData
    shop.openingHours_en = shopEntity.openingHours_en ?? ""
    shop.openingHours_es = shopEntity.openingHours_es ?? ""
    shop.mapData = shopEntity.mapData
    
    return shop
}
