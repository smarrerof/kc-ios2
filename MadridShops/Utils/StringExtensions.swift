//
//  StringExtensions.swift
//  MadridShops
//
//  Created by Sergio Marrero Fernandez on 9/21/17.
//  Copyright © 2017 Sergio Marrero. All rights reserved.
//

import Foundation
import UIKit

extension String {
    func loadImage(into imageView: UIImageView) {
        let queue = OperationQueue()
        queue.addOperation {
            if let url = URL(string: self),
                let data = NSData(contentsOf: url),
                let image = UIImage(data: data as Data) {
                
                OperationQueue.main.addOperation {
                    imageView.image = image
                }
            }
        }
    }
    
    func downloadImage() -> Data? {
        if let encodedUrl = self.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) {
            if let url = URL(string: encodedUrl) {
                if let data = NSData(contentsOf: url) {
                    return data as Data
                } else {
                    print("There was a problem downloading the image url \(self) encoded as \(encodedUrl)")
                }
            }
            else {
                print("There was a problem parsing the image url \(self) encoded as \(encodedUrl)")
            }
        } else {
            print("There was a problem encoding the image url \(self)")
        }
        
        return nil
    }
    
    func parseLatLong() -> Float? {
        return Float(self.trimmingCharacters(in: .whitespaces)
            .replacingOccurrences(of: ",", with: ""))
    }
}
