//
//  JsonParseShop.swift
//  MadridShops
//
//  Created by Sergio Marrero Fernandez on 9/23/17.
//  Copyright © 2017 Sergio Marrero. All rights reserved.
//

import Foundation

func parseShop(data: Data) -> Shops {
    let shops = Shops()
    do {
        let jsonObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! Dictionary<String, Any>
        let result = jsonObject["result"] as! [Dictionary<String, Any>]
        
        for shopJson in result {
            let shop = Shop(name: shopJson["name"]! as! String, address: shopJson["address"]! as! String)
            shop.info = shopJson["description_en"]! as! String
            shop.latitude = Float((shopJson["gps_lat"]! as! String).trimmingCharacters(in: .whitespaces))
            shop.longitude = Float((shopJson["gps_lon"]! as! String).trimmingCharacters(in: .whitespaces))
            shop.logo = shopJson["logo_img"]! as! String
            shop.image = shopJson["img"]! as! String
            shop.openingHours = shopJson["opening_hours_en"]! as! String
            
            
            shops.add(shop: shop)
        }
    } catch {
        print("Error parsing JSON")
    }
    return shops
}
