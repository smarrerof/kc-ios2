//
//  MapModel.swift
//  MadridShops
//
//  Created by Sergio Marrero Fernandez on 9/29/17.
//  Copyright © 2017 Sergio Marrero. All rights reserved.
//

import Foundation

func mapEntityIntoModel(entity: Entity) -> Model {
    let model = Model(name: entity.name ?? "", address: entity.address ?? "")
    
    model.info_en = entity.info_en ?? ""
    model.info_es = entity.info_es ?? ""
    model.latitude = entity.latitude
    model.longitude = entity.longitude
    model.logo = entity.logo ?? ""
    model.logoData = entity.logoData
    model.image = entity.image ?? ""
    model.imageData = entity.imageData
    model.openingHours_en = entity.openingHours_en ?? ""
    model.openingHours_es = entity.openingHours_es ?? ""
    model.mapData = entity.mapData
    
    return model
}
