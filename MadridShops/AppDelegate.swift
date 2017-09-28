//
//  AppDelegate.swift
//  MadridShops
//
//  Created by Sergio Marrero Fernandez on 9/19/17.
//  Copyright © 2017 Sergio Marrero. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var cds = CoreDataStack()
    var context: NSManagedObjectContext?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.context = cds.createContainer(dbName: "MadridShops").viewContext
        
        /*let navigationController = self.window?.rootViewController as! UINavigationController
        let mainViewController = navigationController.topViewController as! MainViewController
        mainViewController.context = self.context
        
        return true*/
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        
        let rootViewController = Main2ViewController(nibName: nil, bundle: nil)
        rootViewController.context = context
        
        window?.rootViewController = rootViewController.wrappedInNavigation()
        
        return true
    }
}

extension UIViewController {
    func wrappedInNavigation() -> UINavigationController {
        let navigation = UINavigationController(rootViewController: self)
        return navigation
    }
}
