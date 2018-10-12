//
//  CacheManager.swift
//  News
//
//  Created by Vitaliy Kurbatov on 13/02/2018.
//  Copyright © 2018 Vitaliy Kurbatov. All rights reserved.
//

import Foundation


class CacheManager {
    
    static var imageDictionary = [String:Data]()
    
    static func saveImageData(_ url:String, _ data:Data) {
    imageDictionary[url] = data
    }
    
    static func retrieveImageData(_ url:String) -> Data? {
        return imageDictionary[url]
    }
}
