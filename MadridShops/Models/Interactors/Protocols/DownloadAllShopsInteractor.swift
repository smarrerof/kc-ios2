//
//  DownloadAllShopsInteractor.swift
//  MadridShops
//
//  Created by Sergio Marrero Fernandez on 9/19/17.
//  Copyright © 2017 Sergio Marrero. All rights reserved.
//

import Foundation


import Foundation

protocol DownloadAllShopsInteractor {
    // execute: downloads all shops. Return on the main thread
    func execute(onSuccess: @escaping shopsSuccessClosure)
    func execute(onSuccess: @escaping shopsSuccessClosure, onError: errorClosure)
    
}
