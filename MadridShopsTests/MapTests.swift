//
//  MapTests.swift
//  MadridShopsTests
//
//  Created by Sergio Marrero Fernandez on 9/29/17.
//  Copyright © 2017 Sergio Marrero. All rights reserved.
//

import XCTest
import CoreData
@testable import MadridShops

class MapTests: XCTestCase {
    var context: NSManagedObjectContext?
    
    override func setUp() {
        super.setUp()
        
        let managedObjectModel = NSManagedObjectModel.mergedModel(from: [Bundle.main])!
        let persistentStoreCoordinator = NSPersistentStoreCoordinator(managedObjectModel: managedObjectModel)
        do {
            try persistentStoreCoordinator.addPersistentStore(ofType: NSInMemoryStoreType, configurationName: nil, at: nil, options: nil)
        } catch {
            print("🙈 Adding in-memory persistent store failed")
        }
        
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = persistentStoreCoordinator
        
        self.context = managedObjectContext
    }
    
    func testMapShopIntoShopEntity() {
        let shop = Shop(name: "Shop 1", address: "Address 1")
        let entity = mapShopIntoShopEntity(context: self.context!, shop: shop)
        
        XCTAssertEqual(shop.name, entity.name)
        XCTAssertEqual(shop.address, entity.address)
    }
    
    func testMapShopEntityIntoShop() {
        let entity = ShopEntity(context: self.context!)
        entity.name = "Shop 1"
        entity.address = "Address 1"
        
        let shop = mapShopEntityIntoShop(shopEntity: entity)
     
        XCTAssertEqual(entity.name, shop.name)
        XCTAssertEqual(entity.address, shop.address)
    }
    
    func testMapActivityIntoActivityEntity() {
        let activity = Activity(name: "Activity 1", address: "Address 1")
        let entity = mapActivityIntoActivityEntity(context: self.context!, activity: activity)
        
        XCTAssertEqual(activity.name, entity.name)
        XCTAssertEqual(activity.address, entity.address)
    }
    
    
    func testMapActivityEntityIntoActivity() {
        let entity = ActivityEntity(context: self.context!)
        entity.name = "Activity 1"
        entity.address = "Address 1"
        
        let shop = mapActivityEntityIntoActivity(activityEntity: entity)
        
        XCTAssertEqual(entity.name, shop.name)
        XCTAssertEqual(entity.address, shop.address)
    }
    
    func testMapEntityIntoModel() {
        //let entity = Entity(context: self.context!)
        let entity = NSEntityDescription.insertNewObject(forEntityName: "ActivityEntity", into: self.context!) as! Entity
        entity.name = "Activity 1"
        entity.address = "Address 1"
        
        let model = mapEntityIntoModel(entity: entity)
        
        XCTAssertEqual(entity.name, model.name)
        XCTAssertEqual(entity.address, model.address)
    }
}
