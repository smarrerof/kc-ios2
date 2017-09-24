//
//  ExecuteOnceInteractorImpl.swift
//  MadridShops
//
//  Created by Sergio Marrero Fernandez on 9/23/17.
//  Copyright © 2017 Sergio Marrero. All rights reserved.
//

import Foundation

class ExecuteOnceInteractorImpl: ExecuteOnceInteractor {
    func execute(onceClosure: () -> Void, closure: () -> Void) {
        let defaults = UserDefaults.standard
        
        if let _ = defaults.string(forKey: "once") {
            // already saved
            closure()
        } else {
            // first time
            onceClosure()
        }
    }
}
