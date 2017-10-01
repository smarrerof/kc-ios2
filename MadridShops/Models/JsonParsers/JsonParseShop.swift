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
            shop.info_en = shopJson["description_en"]! as! String
            shop.info_es = shopJson["description_es"]! as! String
            shop.latitude = (shopJson["gps_lat"]! as! String).parseLatLong()
            shop.longitude = (shopJson["gps_lon"]! as! String).parseLatLong()
            shop.logo = shopJson["logo_img"]! as! String
            shop.image = shopJson["img"]! as! String
            shop.openingHours_en = shopJson["opening_hours_en"]! as! String
            shop.openingHours_es = shopJson["opening_hours_es"]! as! String
            
            shops.add(shop: shop)
        }
    } catch {
        print("Error parsing JSON")
    }
    return shops
}

func parseActivity(data: Data) -> Activities {
    let activities = Activities()
    do {
        let jsonObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! Dictionary<String, Any>
        let result = jsonObject["result"] as! [Dictionary<String, Any>]
        
        for shopJson in result {
            let activity = Activity(name: shopJson["name"]! as! String, address: shopJson["address"]! as! String)
            activity.info_en = shopJson["description_en"]! as! String
            activity.info_es = shopJson["description_es"]! as! String
            activity.latitude = (shopJson["gps_lat"]! as! String).parseLatLong()
            activity.longitude = (shopJson["gps_lon"]! as! String).parseLatLong()
            activity.logo = shopJson["logo_img"]! as! String
            activity.image = shopJson["img"]! as! String
            activity.openingHours_en = shopJson["opening_hours_en"]! as! String
            activity.openingHours_es = shopJson["opening_hours_es"]! as! String
            
            activities.add(activity: activity)
        }
    } catch {
        print("Error parsing JSON")
    }
    return activities
}

