//
//  DownloadAllActivitiesInteractor.swift
//  MadridShops
//
//  Created by Sergio Marrero Fernandez on 9/28/17.
//  Copyright © 2017 Sergio Marrero. All rights reserved.
//

import Foundation

protocol DownloadAllActivitiesInteractor {
    // execute: downloads all shops. Return on the main thread
    func execute(onSuccess: @escaping activitiesSuccessClosure)
    func execute(onSuccess: @escaping activitiesSuccessClosure, onError: errorClosure)
}
