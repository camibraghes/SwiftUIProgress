//
//  PhotoModelCacheManager.swift
//  SwiftUIProgress
//
//  Created by Camelia Braghes on 12.05.2022.
//

import Foundation
import SwiftUI

class PhotoModelCacheManager {
    
    static let instance = PhotoModelCacheManager()
    private init() {}
    
    let photoChace: NSCache<NSString, UIImage> = {
        var cache = NSCache<NSString, UIImage>()
        cache.countLimit = 200
        cache.totalCostLimit = 1024 * 1024 * 200
        return cache
    }()
    
    func add(key:NSString, value: UIImage) {
        photoChace.setObject(value, forKey: key as NSString)
    }
    
    func get(key: String) -> UIImage? {
        return photoChace.object(forKey: key as NSString)
    }
}
